import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  static final BiometricService _instance = BiometricService._internal();
  
  factory BiometricService() {
    return _instance;
  }
  
  BiometricService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  final _secureStorage = const FlutterSecureStorage();

  static String _noBiometricsEnrolledMessage() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'Face ID is not ready. Simulator: use an iPhone with Face ID, set a passcode '
            'in Settings → Face ID & Passcode, enable Features → Face ID → Enrolled. '
            'When the Face ID sheet appears, choose Features → Face ID → Matching Face (⌥⌘M).';
      case TargetPlatform.android:
        return 'No fingerprint or face unlock enrolled. Emulator: Settings → Security → '
            'Fingerprint (set a PIN/pattern first, then add a fingerprint). '
            'Device: Settings → Security & privacy → Fingerprint or Face unlock.';
      default:
        return 'No biometrics enrolled. Set up Face ID, Touch ID, fingerprint, or face unlock in system settings.';
    }
  }
  
  // Check if device supports biometric
  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      print('Error checking biometric availability: $e');
      return false;
    }
  }
  
  // Get available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      print('Error getting available biometrics: $e');
      return [];
    }
  }
  
  /// Returns `(true, null)` on success, or `(false, userFacingMessage)` on failure.
  Future<(bool, String?)> authenticate({String? localizedReason}) async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final types = await _localAuth.getAvailableBiometrics();
      if (!canCheck && types.isEmpty) {
        debugPrint('[BIOMETRIC] Device does not support biometric');
        return (
          false,
          'Biometrics are not available on this device.',
        );
      }

      // `biometricOnly: false` on iOS uses LAPolicy.deviceOwnerAuthentication, which can show
      // the device PIN/passcode instead of Face ID. Use `true` so only Face ID / Touch ID is used.
      const biometricOnly = true;
      debugPrint(
        '[BIOMETRIC] Starting authentication... (biometricOnly=$biometricOnly, '
        'canCheck=$canCheck, types=$types)',
      );
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason:
            localizedReason ?? 'Please authenticate to access your account',
        // biometricOnly: biometricOnly,
        persistAcrossBackgrounding:
            defaultTargetPlatform == TargetPlatform.iOS,
      );
      debugPrint('[BIOMETRIC] Authentication result: $didAuthenticate');
      if (didAuthenticate) {
        return (true, null);
      }
      return (false, 'Authentication was cancelled or did not complete.');
    } on LocalAuthException catch (e) {
      debugPrint(
        '[BIOMETRIC] LocalAuthException: ${e.code} — ${e.description}',
      );
      switch (e.code) {
        case LocalAuthExceptionCode.noBiometricsEnrolled:
          return (false, _noBiometricsEnrolledMessage());
        case LocalAuthExceptionCode.uiUnavailable:
          if (defaultTargetPlatform == TargetPlatform.iOS) {
            return (
              false,
              'Face ID could not open yet (UI not interactive). Wait a moment, tap Try again. '
              'When the Face ID sheet appears: Features → Face ID → Matching Face (⌥⌘M).',
            );
          }
          final d = e.description ?? '';
          if (d.contains('FragmentActivity')) {
            return (
              false,
              'Biometric prompt needs FlutterFragmentActivity on Android. '
              'Rebuild after MainActivity extends FlutterFragmentActivity.',
            );
          }
          return (false, d.isNotEmpty ? d : 'Biometric UI unavailable.');
        case LocalAuthExceptionCode.systemCanceled:
          return (
            false,
            'Authentication was interrupted (e.g. app switched away). Tap Try again.',
          );
        case LocalAuthExceptionCode.biometricLockout:
        case LocalAuthExceptionCode.temporaryLockout:
          return (false, 'Biometrics are temporarily locked. Try again later.');
        default:
          return (false, e.description ?? e.toString());
      }
    } catch (e) {
      debugPrint('[BIOMETRIC] Authentication error: $e');
      final text = e.toString();
      if (text.contains('noBiometricsEnrolled') ||
          text.contains('Biometry is not enrolled')) {
        return (false, _noBiometricsEnrolledMessage());
      }
      if (text.contains('LockedOut') || text.contains('locked out')) {
        return (false, 'Biometrics are temporarily locked. Try again later.');
      }
      if (text.contains('FragmentActivity')) {
        return (
          false,
          'Biometric prompt needs FlutterFragmentActivity on Android. '
          'Rebuild the app after setting MainActivity to extend FlutterFragmentActivity.',
        );
      }
      return (false, text);
    }
  }
  
  // Save biometric preference
  Future<void> saveBiometricPreference(bool enabled) async {
    try {
      await _secureStorage.write(
        key: 'biometric_enabled',
        value: enabled.toString(),
      );
      print('[SECURE STORAGE] Saved biometric preference: $enabled');
    } catch (e) {
      print('Error saving biometric preference: $e');
    }
  }
  
  // Get biometric preference
  Future<bool> getBiometricPreference() async {
    try {
      final value = await _secureStorage.read(key: 'biometric_enabled');
      final isEnabled = value == 'true';
      debugPrint(
        '[BIOMETRIC_DEBUG] secureStorage biometric_enabled raw="$value" → enabled=$isEnabled',
      );
      return isEnabled;
    } catch (e) {
      debugPrint('[BIOMETRIC_DEBUG] getBiometricPreference error: $e');
      return false;
    }
  }
  
  // Save user ID for biometric unlock
  Future<void> saveUserIdForBiometric(String userId) async {
    try {
      await _secureStorage.write(
        key: 'biometric_user_id',
        value: userId,
      );
      print('[SECURE STORAGE] Saved user ID: $userId');
    } catch (e) {
      print('Error saving user ID: $e');
    }
  }
  
  // Get saved user ID
  Future<String?> getSavedUserIdForBiometric() async {
    try {
      final userId = await _secureStorage.read(key: 'biometric_user_id');
      print('[SECURE STORAGE] Read user ID: $userId');
      return userId;
    } catch (e) {
      print('Error reading user ID: $e');
      return null;
    }
  }
  
  // Clear all biometric data
  Future<void> clearBiometricData() async {
    try {
      await _secureStorage.delete(key: 'biometric_enabled');
      await _secureStorage.delete(key: 'biometric_user_id');
      print('[SECURE STORAGE] Cleared all biometric data');
    } catch (e) {
      print('Error clearing biometric data: $e');
    }
  }
}