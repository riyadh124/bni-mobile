import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  RxBool isPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
