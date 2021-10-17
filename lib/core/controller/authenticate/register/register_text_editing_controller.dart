import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTextEditingController extends GetxController {
  final _nameTextEditingController = TextEditingController();
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _nameFieldValid = true.obs;
  final _emailFieldValid = true.obs;
  final _passwordFieldValid = true.obs;

  TextEditingController get nameTextEditingController =>
      _nameTextEditingController;
  TextEditingController get emailTextEditingController =>
      _emailTextEditingController;
  TextEditingController get passwordTextEditingController =>
      _passwordTextEditingController;
  bool get nameFieldValid => _nameFieldValid.value;
  bool get emailFieldValid => _emailFieldValid.value;
  bool get passwordFieldValid => _passwordFieldValid.value;

  @override
  void onClose() {
    _nameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.onClose();
  }

  bool validateFields() {
    if (_nameTextEditingController.text.isEmpty) {
      _nameFieldValid.value = false;
    } else {
      _nameFieldValid.value = true;
    }

    if (_emailTextEditingController.text.length < 6) {
      _emailFieldValid.value = false;
    } else {
      _emailFieldValid.value = true;
    }

    if (_passwordTextEditingController.text.length < 6) {
      _passwordFieldValid.value = false;
    } else {
      _passwordFieldValid.value = true;
    }

    if (!nameFieldValid || !emailFieldValid || !passwordFieldValid) {
      return false;
    }

    return true;
  }
}
