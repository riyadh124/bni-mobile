import 'package:bni_mobile/app/modules/home/views/home_view.dart';
import 'package:bni_mobile/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    var token = box.read("token");
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (token == null) {
          Get.off(() => LoginView());
        } else {
          Get.off(() => HomeView());
        }
      },
    );
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
