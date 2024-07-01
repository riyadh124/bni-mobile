import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  SplashscreenView({Key? key}) : super(key: key);
  SplashscreenController splashController = Get.put(SplashscreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
