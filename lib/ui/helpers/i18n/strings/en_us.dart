import './translations.dart';

class EnUs implements Translations {
  String get msgEmailInUse => 'Email is already in use.';
  String get msgInvalidCredentials => 'Invalid credentials.';
  String get msgInvalidField => 'Invalid field.';
  String get msgRequiredField => 'Required field.';
  String get msgUnexpectedError => 'Something went wrong. Please try again soon.';

  String get addAccount => 'Add account';
  String get confirmPassword => 'Confirm password';
  String get email => 'Email';
  String get enter => 'Enter';
  String get login => 'Login';
  String get name => 'Name';
  String get password => 'Password';
  String get reload => 'Reload';
  String get surveys => 'Surveys';
  String get wait => 'Wait...';
}
