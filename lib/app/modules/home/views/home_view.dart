import 'package:bni_mobile/app/env/colors.dart';
import 'package:bni_mobile/app/modules/form/views/form_view.dart';
import 'package:bni_mobile/app/modules/profile/views/profile_view.dart';
import 'package:bni_mobile/app/services/authService.dart';
import 'package:bni_mobile/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  homeController.userData["name"],
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                CText(
                  "ID : ${homeController.userData["id"]}",
                  color: Color(0xFF7C7C9A),
                )
              ],
            ),
            GestureDetector(
              onTap: () => Get.to(ProfileView()),
              child: CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await authService().getForms(homeController.tiket.text);
          },
          child: ListView(
            children: [
              TextField(
                controller: homeController.tiket,
                onChanged: (value) {
                  homeController.getDataForms(value);
                },
                decoration: const InputDecoration(
                  fillColor: Color(0xFFF9F8FD),
                  filled: true,
                  hintText: 'Cari Formulir Laporan..',
                  suffixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Obx(() => homeController.isFormsExist.value
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: homeController.forms.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Get.to(() => FormView(),
                              arguments: homeController.forms[index]),
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 14),
                            decoration: BoxDecoration(
                                color: Color(0xFF5995F0),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CText(
                                      homeController.forms[index]
                                          ["nomor_tiket"],
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                          color: homeController.forms[index]
                                                      ["status"] ==
                                                  "Waiting"
                                              ? Color(0xFF9EA0B9)
                                              : homeController.forms[index]
                                                          ["status"] ==
                                                      "Rejected"
                                                  ? Color(0xFFFF5555)
                                                  : Color(0xFF9EA0B9),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: CText(
                                        homeController.forms[index]["status"],
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CText(
                                  homeController.forms[index]["user"]["name"],
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CText(
                                  homeController.formatTime(homeController
                                      .forms[index]["created_at"]),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF77AAF6),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Image.asset(homeController
                                                        .forms[index]
                                                    ["tipe_unit"] ==
                                                "Excavator"
                                            ? "assets/images/excavator.png"
                                            : homeController.forms[index]
                                                        ["tipe_unit"] ==
                                                    "Bulldozer"
                                                ? "assets/images/bulldozer.png"
                                                : homeController.forms[index]
                                                            ["tipe_unit"] ==
                                                        "Dump Truck"
                                                    ? "assets/images/dump-truck.png"
                                                    : "assets/images/excavator.png"),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CText(
                                            homeController.forms[index]
                                                ["tipe_unit"],
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          CText(
                                            homeController.forms[index]
                                                ["model_unit"],
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          CText(
                                            homeController.forms[index]
                                                ["nomor_unit"],
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(FormView()),
        shape: CircleBorder(),
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
