import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  final userData = GetStorage().read("userData");

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

  void increment() => count.value++;
}
