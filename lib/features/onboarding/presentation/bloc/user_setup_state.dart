
import 'package:routiner/features/onboarding/domain/entities/user_setup_entities.dart';

sealed class UserSetupState {}

class UserSetupInitial extends UserSetupState {}

class UserSetupProgress extends UserSetupState {
  final UserSetupEntity formData;

  UserSetupProgress( this.formData);
}

class UserSetupSubmitting extends UserSetupState {
  final UserSetupEntity formData;

  UserSetupSubmitting( this.formData);
}

class UserSetupSuccess extends UserSetupState {}

class UserSetupError extends UserSetupState {
  final String message;

  UserSetupError( this.message);
}
