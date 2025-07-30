import 'package:flutter/cupertino.dart';

class FormValidation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email can't be empty";
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }


  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number can't be empty";
    }
   return null;
  }


  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    return null;
  }

  static String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN cannot be empty';
    }
    if (value.length != 4) {
      return 'PIN must be exactly 4 digits';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username can't be empty";
    }
    return null;
  }

  static String? validatePasswordMatch(
    String? value,
    TextEditingController newPssWordController,
  ) {
    if (value != newPssWordController.value.text)
      return "Passwords do not match";
    return null;
  }

  /// ========================================== Create New PasssWord ===================================///

  static String? confirmPasswordValidator(
    String? value,
    TextEditingController changePassController,
  ) {
    if (value == null || value.isEmpty) {
      return "Must be atleast 8 characters";
    } else if (value.length < 8) {
      return "Must be atleast 8 characters";
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must be atleast 8 characters";
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must be atleast 8 characters";
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Password must contain at least one special character";
    } else if (value != changePassController.text) {
      return "Passwords do not match";
    }
    return null;
  }
}
