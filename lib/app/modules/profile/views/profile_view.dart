import 'package:bni_mobile/app/components/dialog.dart';
import 'package:bni_mobile/app/env/colors.dart';
import 'package:bni_mobile/app/modules/login/views/login_view.dart';
import 'package:bni_mobile/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CText(
            'Profile',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        profileController.userData["name"],
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      CText(
                        "ID : ${profileController.userData["id"]}",
                        color: Color(0xFF7C7C9A),
                      )
                    ],
                  ),
                ],
              ),
              Divider(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  confirmMessage(
                    context,
                    "Konfirmasi Logout",
                    "Apakah Anda yakin ingin logout?",
                    () async {
                      await GetStorage().remove("token");
                      Get.offAll(LoginView());
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CText(
                      "Logout",
                      color: Colors.red,
                      fontSize: 16,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
