import 'package:bni_mobile/app/services/authService.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: loginController.usernameController,
                decoration: const InputDecoration(
                  hintText: 'ID Karyawan',
                  prefixIcon: Icon(Icons.person),
                  contentPadding:
                      EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => TextField(
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => loginController.isPassword.value =
                          !loginController.isPassword.value,
                      icon: loginController.isPassword.value
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off),
                    ),
                    hintText: 'Kata Sandi',
                    prefixIcon: Icon(Icons.key),
                    contentPadding: 
                        EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                    ),
                  ),
                  obscureText: loginController.isPassword.value,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  var id = loginController.usernameController.text;
                  var pass = loginController.passwordController.text;
                  authService().login(context, id, pass);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFF024A94),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Kirim",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
