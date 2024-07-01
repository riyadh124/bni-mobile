import 'dart:io';

import 'package:bni_mobile/app/components/dialog.dart';
import 'package:bni_mobile/app/components/loading.dart';
import 'package:bni_mobile/app/env/global_var.dart';
import 'package:bni_mobile/app/modules/form/controllers/form_controller.dart';
import 'package:bni_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:bni_mobile/app/modules/home/views/home_view.dart';
import 'package:bni_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class authService extends GetConnect {
  Future uploadImage(context, image, RxString documentation) async {
    FormController formController = Get.put(FormController());

    try {
      final token = await GetStorage().read("token");

      print("image : $image");

      if (token != null) {
        final response = await post(
            '$urlApi/api/photo',
            FormData({
              'photo': MultipartFile(image, filename: 'image.jpg'),
            }),
            headers: {'Authorization': 'Bearer $token'});

        var data = response.body;

        print("upload image : $data");

        if (data != null) {
          documentation.value = data["url"];
          formController.update();
        }
      } else {
        errorMessage("Token is null");
        throw Exception("Token is null");
      }
    } catch (e) {
      errorMessage("uploadImage : $e");
    }
  }

  void login(context, id, pass) async {
    print("username: " + id);
    print("password: " + pass);

    if (id != '' && pass != '') {
      showLoading();

      try {
        final response = await post('$urlApi/api/auth/login', {
          'id': id,
          'password': pass,
        });

        var data = response.body;
        print("response $data");

        if (data['message'] == 'User Logged In Successfully') {
          GetStorage().write("token", data["token"]);
          GetStorage().write("userData", data["data"]);
          onLoadingDismiss();
          Get.offAll(HomeView());
          successMessage(context, data['message']);
        } else {
          onLoadingDismiss();
          errorMessage(data['message']);
        }
      } catch (e) {
        onLoadingDismiss();
        errorMessage(e);
      }
    } else {
      errorMessage("Lengkapi ID dan Password terlebih dahulu.");
    }
  }

  Future<List> getForms(tiket) async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/api/forms?nomor_tiket=$tiket',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['success']) {
        // successMessage(Get.context, data['message']);
        return data['data'];
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return [];
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return [];
    }
  }

  Future getDetailForms(id) async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/api/forms/$id',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['success']) {
        // successMessage(Get.context, data['message']);
        return data['data'];
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return false;
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return false;
    }
  }

  Future submitForm() async {
    FormController formController = Get.put(FormController());
    HomeController homeController = Get.put(HomeController());
    final userData = await GetStorage().read("userData");

    final formData = {
      "user_id": userData["id"],
      "nomor_tiket": formController.dataArguments != null
          ? formController.dataArguments["nomor_tiket"]
          : '',
      "tipe_unit": formController.tipeUnitController.text,
      "model_unit": formController.modelUnitController.text,
      "nomor_unit": formController.nomorUnitController.text,
      "shift": formController.shiftController.text,
      "jam_mulai": formController.jamMulaiController.text,
      "jam_selesai": formController.jamSelesaiController.text,
      "hm_awal": int.parse(formController.hmAwalController.text),
      "hm_akhir": int.parse(formController.hmAkhirController.text),
      "job_site": formController.jobSiteController.text,
      "lokasi": formController.lokasiController.text,
      "catatan": formController.catatanController.text,
      "form_checks": [
        {
          "item_name": "Kondisi Underacarriage (A)",
          "status": formController.statusKondisiUnderacarriage.value,
          "documentation":
              formController.dokumentasiKondisiUnderacarriage.value,
        },
        {
          "item_name": "Kerusakan akibat insiden ***) (AA)",
          "status": formController.statusKerusakanAkibatInsiden.value,
          "documentation":
              formController.dokumentasiKerusakanAkibatInsiden.value,
        },
        {
          "item_name": "Kebocoran oli gear box / oil PTO (AA)",
          "status": formController.statusKebocoranOliGearBox.value,
          "documentation": formController.dokumentasiKebocoranOliGearBox.value,
        },
        {
          "item_name": "Level oil swing & kebocoran (AA)",
          "status": formController.statusLevelOilSwing.value,
          "documentation": formController.dokumentasiLevelOilSwing.value,
        },
        {
          "item_name": "Level oil hydraulic & kebocoran (AA)",
          "status": formController.statusLevelOilHydraulic.value,
          "documentation": formController.dokumentasiLevelOilHydraulic.value,
        },
        {
          "item_name": "Fuel drain / Buangan air dari tanki BBC (A)",
          "status": formController.statusFuelDrain.value,
          "documentation": formController.dokumentasiFuelDrain.value,
        },
        {
          "item_name": "BBC minimum 25% dari Cap. Tanki (A)",
          "status": formController.statusBBCminimum.value,
          "documentation": formController.dokumentasiBBCminimum.value,
        },
        {
          "item_name": "Buang air dalam tanki udara (A)",
          "status": formController.statusBuangAirDalamTankiUdara.value,
          "documentation":
              formController.dokumentasiBuangAirDalamTankiUdara.value,
        },
        {
          "item_name": "Kebersihan accessories safety & Alat (A)",
          "status": formController.statusKebersihanAccessoriesSafety.value,
          "documentation":
              formController.dokumentasiKebersihanAccessoriesSafety.value,
        },
        {
          "item_name": "Kebocoran2 bila ada (oli, solar, grease ) (A)",
          "status": formController.statusKebocoranBilaAda.value,
          "documentation": formController.dokumentasiKebocoranBilaAda.value,
        },
        {
          "item_name": "Alarm travel (Big Digger) (A)",
          "status": formController.statusAlarmTravel.value,
          "documentation": formController.dokumentasiAlarmTravel.value,
        },
        {
          "item_name": "Lock pin Bucket (AA)",
          "status": formController.statusLockpinBucket.value,
          "documentation": formController.dokumentasiLockpinBucket.value,
        },
        {
          "item_name": "Lock pin tooth & ketajaman kuku (AA)",
          "status": formController.statusLockpinTooth.value,
          "documentation": formController.dokumentasiLockpinTooth.value,
        },
        {
          "item_name": "Kebersihan aki / battery (A)",
          "status": formController.statusKebersihanAki.value,
          "documentation": formController.dokumentasiKebersihanAki.value,
        },
        {
          "item_name": "Air conditioner (AC) (A)",
          "status": formController.statusAirConditioner.value,
          "documentation": formController.dokumentasiAirConditioner.value,
        },
        {
          "item_name": "Fungsi steering / kemudi (AA)",
          "status": formController.statusFungsiSteering.value,
          "documentation": formController.dokumentasiFungsiSteering.value,
        },
        {
          "item_name": "Fungsi seat belt / sabuk pengaman (AA)",
          "status": formController.statusFungsiSeatbelt.value,
          "documentation": formController.dokumentasiFungsiSeatbelt.value,
        },
        {
          "item_name": "Fungsi semua lampu (AA)",
          "status": formController.statusFungsiSemuaLampu.value,
          "documentation": formController.dokumentasiFungsiSemuaLampu.value,
        },
        {
          "item_name": "Fungsi Rotary lamp (AA)",
          "status": formController.statusFungsiRotaryLamp.value,
          "documentation": formController.dokumentasiFungsiRotaryLamp.value,
        },
        {
          "item_name": "Fungsi mirror / spion (A)",
          "status": formController.statusFungsiMirror.value,
          "documentation": formController.dokumentasiFungsiMirror.value,
        },
        {
          "item_name": "Fungsi wiper dan air wiper (A)",
          "status": formController.statusFungsiWiper.value,
          "documentation": formController.dokumentasiFungsiWiper.value,
        },
        {
          "item_name": "Fungsi horn / klakson (AA)",
          "status": formController.statusFungsiHorn.value,
          "documentation": formController.dokumentasiFungsiHorn.value,
        },
        {
          "item_name": "Fire Extinguiser / Fire supresion APAR (AA)",
          "status": formController.statusFireExtinguiser.value,
          "documentation": formController.dokumentasiFireExtinguiser.value,
        },
        {
          "item_name": "Fungsi kontrol panel (AA)",
          "status": formController.statusFungsiKontrolPanel.value,
          "documentation": formController.dokumentasiFungsiKontrolPanel.value,
        },
        {
          "item_name": "Fungsi radio komunikasi (AA)",
          "status": formController.statusFungsiRadioKomunikasi.value,
          "documentation":
              formController.dokumentasiFungsiRadioKomunikasi.value,
        },
        {
          "item_name": "Kebersihan ruang kabin (A)",
          "status": formController.statusKebersihanRuangKabin.value,
          "documentation": formController.dokumentasiKebersihanRuangKabin.value,
        },
        {
          "item_name": "Radiator (AA)",
          "status": formController.statusRadiator.value,
          "documentation": formController.dokumentasiRadiator.value,
        },
        {
          "item_name": "Engine / Oli Mesin (AA)",
          "status": formController.statusEngine.value,
          "documentation": formController.dokumentasiEngine.value,
        }
      ]
    };

    print("formdata: $formData");

    final token = await GetStorage().read("token");

    try {
      final response = await post('$urlApi/api/forms', formData,
          headers: {'Authorization': "Bearer $token"});

      var data = response.body;
      print("response $data");

      if (data['message'] == "Form updated successfully" ||
          data['message'] == "Form created successfully") {
        // successMessage(Get.context, data['message']);
        Get.back();
        successMessage(Get.context, data['message']);
        homeController.getDataForms("");
        return true;
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit form: $e');
      return false;
    }
  }
}
