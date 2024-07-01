import 'package:bni_mobile/app/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  List forms = [];
  RxBool isFormsExist = false.obs;
  final userData = GetStorage().read("userData");
  TextEditingController tiket = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataForms("");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDataForms(String keyword) async {
    isFormsExist.value = false;
    update();

    forms = await authService().getForms(keyword);
    isFormsExist.value = true;
    update();
  }

  String formatTime(String isoTime) {
    DateTime dateTime = DateTime.parse(isoTime).toLocal();
    DateFormat formatter = DateFormat('dd MMM yyyy HH:mm');
    return formatter.format(dateTime);
  }
}
