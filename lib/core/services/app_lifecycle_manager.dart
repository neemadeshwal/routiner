import 'package:flutter/material.dart';

class AppLifecycleManager with WidgetsBindingObserver {
  static final AppLifecycleManager _instance = AppLifecycleManager._internal();
  
  factory AppLifecycleManager() {
    return _instance;
  }
  
  AppLifecycleManager._internal();
  
  VoidCallback? onAppResumed;
  VoidCallback? onAppPaused;
  DateTime? _pauseTime;
  bool _isInitialized = false;
  
  void init() {
    if (!_isInitialized) {
      WidgetsBinding.instance.addObserver(this);
      _isInitialized = true;
      print('AppLifecycleManager initialized');
    }
  }
  
  void dispose() {
    if (_isInitialized) {
      WidgetsBinding.instance.removeObserver(this);
      _isInitialized = false;
      print('AppLifecycleManager disposed');
    }
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App lifecycle changed: $state');
    
    switch (state) {
      case AppLifecycleState.resumed:
        // App came to foreground — do NOT clear _pauseTime here; the auth
        // check runs async and must read pause duration first (see resetPauseTime after check).
        final pauseSnapshot = _pauseTime;
        final secondsBackground = pauseSnapshot == null
            ? null
            : DateTime.now().difference(pauseSnapshot).inSeconds;
        debugPrint(
          '[BIOMETRIC_DEBUG] resumed: pauseTime=$pauseSnapshot '
          'backgroundSeconds=$secondsBackground — scheduling onAppResumed',
        );
        onAppResumed?.call();
        break;
        
      case AppLifecycleState.paused:
        // App went to background
        print('[APP PAUSED] Record pause time');
        _pauseTime = DateTime.now();
        onAppPaused?.call();
        break;
        
      case AppLifecycleState.inactive:
        // App is inactive (transitioning states)
        print('[APP INACTIVE]');
        break;
        
      case AppLifecycleState.detached:
        // App is being terminated
        print('[APP DETACHED]');
        break;
        
      case AppLifecycleState.hidden:
        // App is hidden (rare state on some platforms)
        print('[APP HIDDEN]');
        break;
    }
  }
  
  /// Check if app was in background for longer than threshold
  bool shouldRequireReauth({Duration threshold = const Duration(minutes: 5)}) {
    if (_pauseTime == null) {
      debugPrint(
        '[BIOMETRIC_DEBUG] shouldRequireReauth: false (no _pauseTime — '
        'never paused this session, or already reset after last check)',
      );
      return false;
    }

    final now = DateTime.now();
    final difference = now.difference(_pauseTime!);
    final shouldReauth = difference > threshold;

    debugPrint(
      '[BIOMETRIC_DEBUG] shouldRequireReauth: paused ${difference.inSeconds}s '
      '(threshold ${threshold.inSeconds}s) => $shouldReauth',
    );

    return shouldReauth;
  }
  
  /// Get how long app was paused in seconds
  int getBackgroundDurationSeconds() {
    if (_pauseTime == null) return 0;
    return DateTime.now().difference(_pauseTime!).inSeconds;
  }
  
  /// Reset pause time
  void resetPauseTime() {
    _pauseTime = null;
  }
}