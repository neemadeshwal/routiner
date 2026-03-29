import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_event.dart';
import 'package:routiner/features/auth/presentation/bloc/auth_state.dart';

class BiometricDialog extends StatefulWidget {
  final String reason;
  final void Function(bool success) onResult;

  const BiometricDialog({
    super.key,
    required this.reason,
    required this.onResult,
  });

  @override
  State<BiometricDialog> createState() => _BiometricDialogState();
}

class _BiometricDialogState extends State<BiometricDialog> {
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_startAuthAfterDialogIsReady());
    });
  }

  /// iOS needs the dialog route to be fully presented before `LAContext` can show
  /// Face ID; calling immediately after `showDialog` often yields no sheet on Simulator.
  Future<void> _startAuthAfterDialogIsReady() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await Future<void>.delayed(const Duration(milliseconds: 550));
    }
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    debugPrint(
      '[BIOMETRIC_DEBUG] BiometricDialog: dialog ready → AuthenticateWithBiometricRequested',
    );
    _startBiometricAuthentication();
  }

  void _startBiometricAuthentication() {
    debugPrint(
      '[BIOMETRIC_DEBUG] BiometricDialog: dispatch AuthenticateWithBiometricRequested',
    );
    context.read<AuthBloc>().add(
          AuthenticateWithBiometricRequested(reason: widget.reason),
        );
  }

  void _continueWithoutBiometricLock() {
    context.read<AuthBloc>().add(BiometricDisableGateRequested());
    Navigator.of(context).pop();
    widget.onResult(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is BiometricAuthenticationSuccess) {
          Navigator.of(context).pop();
          widget.onResult(true);
        }
        if (state is BiometricAuthenticationFailed) {
          setState(() => _errorMessage = state.message);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLG),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.fingerprint,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Authenticate',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.reason,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.red.shade800,
                      ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    setState(() => _errorMessage = null);
                    _startBiometricAuthentication();
                  },
                  child: const Text('Try again'),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _continueWithoutBiometricLock,
                child: const Text('Continue without biometric lock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
