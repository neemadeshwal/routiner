class AppConstants {
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Regular expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
  static final RegExp urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );

  static const String welcomeTitle = "welcome to routiner";
  static const String welcomeSubtitle =
      "Explore the app, Find some peace of mind to achieve good habits.";
  static const String skip = "skip";
  static const String getStarted = "get started";
  static const String continueWithFb = "continue with facebook";
  static const String continueWithGoogle = "continue with google";
  static const String loginwithemail = "or log in with email";

  static const String welcomeBack = "welcome back";

  static const String emailAddress = "email address";

  static const String password = "password";

  static const String logIn = "log in";

  static const String create="create";
  static const String continue_="continue";

  static const String forgotPasswordDescription = "Enter your email to reset your password";

  static const String forgotPassword = "forgot password ?";

  static const String enterOtpCode="enter otp code";
  static const String enterOtpCodeDescription="Enter the 6-digit code sent to your email";
  static const String dontHaveAnAccount = "Don't have an account?";

  static const String alreadyHaveAnAccount = "already have an account?";
  static const String signup = " sign up";

  static const String createYourAccount = "create your account";
  static const String signupwithemail = "or sign up with email";
  static const String resetPassword = "reset password";
  static const String resetPasswordDescription = "Enter your new password";
  static const String newPassword = "new password";
  static const String confirmPassword = "confirm password";
  static const String fullName = "full name";

  static const String iHaveRead = "i have read ";
  static const String privacyPolicy = "privacy policy";
}
