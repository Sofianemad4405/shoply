import 'dart:convert';

import 'package:shopify/core/utils/constants.dart';
import 'package:shopify/core/utils/prefs.dart';
import 'package:shopify/features/auth/data/model/user_model.dart';
import 'package:shopify/features/auth/domain/entities/user_entity.dart';

String? validateName(value) {
  if (value!.isEmpty) {
    return "Name is required";
  }
  if (value.length < 3) {
    return "Name must be at least 3 characters long";
  }
  if (value.length > 20) {
    return "Name must be at most 20 characters long";
  }
  if (!value.contains(RegExp(r"^[a-zA-Z ]+$"))) {
    return "Name must contain only letters";
  }
  return null;
}

String? passwordConfirmValidator(String password, String? value) {
  if (value!.isEmpty) {
    return "Password is required";
  }
  if (value != password) {
    return "Passwords do not match";
  }
  return null;
}

String? validatePassword(value) {
  if (value!.isEmpty) {
    return "Password is required";
  }
  if (value.length < 6) {
    return "Password must be at least 6 characters long";
  }

  return null;
}

String? validateLocation(value) {
  if (value!.isEmpty) {
    return "Location is required";
  }
  return null;
}

String? validateEmail(value) {
  if (value!.isEmpty) {
    return "E-mail is required";
  }
  if (!value.contains("@")) {
    return "Invalid E-mail";
  }
  if (!value.contains(".")) {
    return "Invalid E-mail";
  }
  return null;
}

UserEntity getUserData() {
  var jsonData = Prefs.getString(Constants.kUser);
  var user = UserModel.fromJson(jsonDecode(jsonData));
  return user;
}
