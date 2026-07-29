import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!EmailValidator.validate(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validateText(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message?? "Enter a valid value";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter your phone number";
    }

    final RegExp phoneRegExp = RegExp(r'^01[3-9]\d{8}$');

    if (!phoneRegExp.hasMatch(value.trim())) {
      return "Enter a valid phone number";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }else if(value.length < 7){
      return 'Enter a password more than 6 character';
    }

    /*// password must have 6 character also combination of capital letter, small letter, number and symbol
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#()_\-+=])[A-Za-z\d@$!%*?&^#()_\-+=]{6,}$',
    );



    if (!passwordRegExp.hasMatch(value)) {
      return "Password must contain at least 6 characters, including uppercase, lowercase, number, and special character.";
    }*/

    return null;
  }


}
