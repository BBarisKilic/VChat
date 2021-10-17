import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginTextEditingController extends GetxController {
  final _emailTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _emailFieldValid = true.obs;
  final _passwordFieldValid = true.obs;

  TextEditingController get emailTextEditingController =>
      _emailTextEditingController;
  TextEditingController get passwordTextEditingController =>
      _passwordTextEditingController;
  bool get emailFieldValid => _emailFieldValid.value;
  bool get passwordFieldValid => _passwordFieldValid.value;

  @override
  void onClose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.onClose();
  }

  bool validateFields() {
    return true;
  }
}
