class StringConstants {
  /// This class contains all the string constants used in the application.
  /// It helps in maintaining consistency and makes it easier to manage text across the app.
  /// You can add more strings as needed.
  /// Example usage: Text(StringConstants.appName)
  /// General Strings
  /// These can be used throughout the app for various labels and messages
  /// Example: Text(StringConstants.appName)
  /// ---------------------------------------------------------------
  static const String appName = "NJM";
  static const String welcome = "Welcome to NJM";
  static const String login = "Login";
  static const String userName = "Username";
  static const String userNameEmailMobileNumber = "Username, email or mobile number";
  static const String phoneNumber = "Phone number";
  static const String email = "Email";
  static const String password = "Password";
  static const String forgotPassword = "Forgot Password?";
  static const String signUp = "Sign Up";
  static const String googleSignIn = "Sign in with Google";

  static const String home = "Home";
  static const String settings = "Settings";
  static const String logout = "Logout";
  static const String enterEmail = "Please enter your email";
  static const String enterValidEmail = "Please enter a valid email";
  static const String enterPassword = "Please enter your password";
  static const String passwordLength =
      "Password must be at least 6 characters long";
  static const String loading = "Loading...";
  static const String error = "An error occurred. Please try again.";
  static const String success = "Operation completed successfully.";
  static const String createAccount = "Create Account";
  static const String alreadyHaveAccount = "Already have an account?";
  static const String iAlreadyHaveAccount = 'I already have an account';
  static const String dontHaveAccount = "Don't have an account? Sign Up";
  static const String resetPassword = "Reset Password";
  static const String sendResetLink = "Send Reset Link";
  static const String enterRegisteredEmail =
      "Please enter your registered email to receive a password reset link.";

  /// Screen Titles
  /// These can be used in AppBars or as section headers
  /// 
  /// Example: AppBar(title: Text(StringConstants.registerScreenTitle))
  /// ---------------------------------------------------------------
  static const String registerScreenTitle = "Register Screen";
  static const String loginScreenTitle = "Login Screen";
}

class DialogConstants {
  /// Button Texts
  /// These can be used for dialog buttons
  /// Example: Text(DialogConstants.ok)
  /// ---------------------------------------------------------------
  static const String continueCreatingAccount = "Continue Creating Account";
  static const String done = "Done";
  static const String ok = "OK";
  static const String cancel = "Cancel";
  static const String login = "Log in";
}

class ButtonStrConstants {
  /// Button Texts
  /// These can be used for button labels
  /// Example: ElevatedButton(child: Text(ButtonStrConstants.create))
  /// ---------------------------------------------------------------
  static const String create = 'Create';
  static const String done = "Done";
  static const String ok = "OK";
  static const String cancel = "Cancel";
  static const String login = "Log in";
  static const String createNewAccount = "Create new account";
  static const String forgotPassword = "Forgot password?";
}