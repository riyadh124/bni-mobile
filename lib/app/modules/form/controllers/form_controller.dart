import 'package:bni_mobile/app/components/loading.dart';
import 'package:bni_mobile/app/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class FormController extends GetxController {
  GetStorage box = GetStorage();
  var dataArguments;
  var dataDetailForm;

  List tipeUnitList = ["Excavator", "Dump Truck", "Bulldozer"];
  List shiftList = ["Siang", "Malam"];

  //Informasi Formulir
  TextEditingController tipeUnitController = TextEditingController();
  TextEditingController modelUnitController = TextEditingController();
  TextEditingController nomorUnitController = TextEditingController();
  TextEditingController shiftController = TextEditingController();
  TextEditingController jamMulaiController = TextEditingController();
  TextEditingController jamSelesaiController = TextEditingController();
  TimeOfDay jamMulaiSelected = TimeOfDay.now();
  TimeOfDay jamSelesaiSelected = TimeOfDay.now();
  TextEditingController hmAwalController = TextEditingController();
  TextEditingController hmAkhirController = TextEditingController();
  TextEditingController jobSiteController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController catatanController = TextEditingController();

  //Checks
  RxString statusKondisiUnderacarriage = "OK".obs;
  RxString dokumentasiKondisiUnderacarriage = "".obs;

  RxString statusKerusakanAkibatInsiden = "OK".obs;
  RxString dokumentasiKerusakanAkibatInsiden = "".obs;

  RxString statusKebocoranOliGearBox = "OK".obs;
  RxString dokumentasiKebocoranOliGearBox = "".obs;

  RxString statusLevelOilSwing = "OK".obs;
  RxString dokumentasiLevelOilSwing = "".obs;

  RxString statusLevelOilHydraulic = "OK".obs;
  RxString dokumentasiLevelOilHydraulic = "".obs;

  RxString statusFuelDrain = "OK".obs;
  RxString dokumentasiFuelDrain = "".obs;

  RxString statusBBCminimum = "OK".obs;
  RxString dokumentasiBBCminimum = "".obs;

  RxString statusBuangAirDalamTankiUdara = "OK".obs;
  RxString dokumentasiBuangAirDalamTankiUdara = "".obs;

  RxString statusKebersihanAccessoriesSafety = "OK".obs;
  RxString dokumentasiKebersihanAccessoriesSafety = "".obs;

  RxString statusKebocoranBilaAda = "OK".obs;
  RxString dokumentasiKebocoranBilaAda = "".obs;

  RxString statusAlarmTravel = "OK".obs;
  RxString dokumentasiAlarmTravel = "".obs;

  RxString statusLockpinBucket = "OK".obs;
  RxString dokumentasiLockpinBucket = "".obs;

  RxString statusLockpinTooth = "OK".obs;
  RxString dokumentasiLockpinTooth = "".obs;

  RxString statusKebersihanAki = "OK".obs;
  RxString dokumentasiKebersihanAki = "".obs;

  RxString statusAirConditioner = "OK".obs;
  RxString dokumentasiAirConditioner = "".obs;

  RxString statusFungsiSteering = "OK".obs;
  RxString dokumentasiFungsiSteering = "".obs;

  RxString statusFungsiSeatbelt = "OK".obs;
  RxString dokumentasiFungsiSeatbelt = "".obs;

  RxString statusFungsiSemuaLampu = "OK".obs;
  RxString dokumentasiFungsiSemuaLampu = "".obs;

  RxString statusFungsiRotaryLamp = "OK".obs;
  RxString dokumentasiFungsiRotaryLamp = "".obs;

  RxString statusFungsiMirror = "OK".obs;
  RxString dokumentasiFungsiMirror = "".obs;

  RxString statusFungsiWiper = "OK".obs;
  RxString dokumentasiFungsiWiper = "".obs;

  RxString statusFungsiHorn = "OK".obs;
  RxString dokumentasiFungsiHorn = "".obs;

  RxString statusFireExtinguiser = "OK".obs;
  RxString dokumentasiFireExtinguiser = "".obs;

  RxString statusFungsiKontrolPanel = "OK".obs;
  RxString dokumentasiFungsiKontrolPanel = "".obs;

  RxString statusFungsiRadioKomunikasi = "OK".obs;
  RxString dokumentasiFungsiRadioKomunikasi = "".obs;

  RxString statusKebersihanRuangKabin = "OK".obs;
  RxString dokumentasiKebersihanRuangKabin = "".obs;

  RxString statusRadiator = "OK".obs;
  RxString dokumentasiRadiator = "".obs;

  RxString statusEngine = "OK".obs;
  RxString dokumentasiEngine = "".obs;

  @override
  void onInit() {
    super.onInit();
    tipeUnitController.text = "Excavator";
    shiftController.text = "Siang";
    jamMulaiController.text =
        "${jamMulaiSelected.hour.toString().padLeft(2, '0')}:${jamMulaiSelected.minute.toString().padLeft(2, '0')}:00";
    jamSelesaiController.text =
        "${jamSelesaiSelected.hour.toString().padLeft(2, '0')}:${jamSelesaiSelected.minute.toString().padLeft(2, '0')}:00";
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDetailForm() async {
    dataArguments = Get.arguments;
    print("data arguments ${dataArguments}");
    if (dataArguments != null) {
      dataDetailForm = await authService().getDetailForms(dataArguments["id"]);
      setData(dataDetailForm);
    }
  }

  void setData(Map<String, dynamic> data) {
    // Mengisi data ke TextEditingController dengan pengecekan null
    tipeUnitController.text = data['tipe_unit'] ?? '';
    modelUnitController.text = data['model_unit'] ?? '';
    nomorUnitController.text = data['nomor_unit'] ?? '';
    shiftController.text = data['shift'] ?? '';
    jamMulaiController.text = data['jam_mulai'] ?? '';
    jamSelesaiController.text = data['jam_selesai'] ?? '';
    hmAwalController.text =
        data['hm_awal'] != null ? data['hm_awal'].toString() : '';
    hmAkhirController.text =
        data['hm_akhir'] != null ? data['hm_akhir'].toString() : '';
    jobSiteController.text = data['job_site'] ?? '';
    lokasiController.text = data['lokasi'] ?? '';
    catatanController.text = data['catatan'] ?? '';

    // Mengisi waktu dengan pengecekan null
    if (data['jam_mulai'] != null && data['jam_mulai'].contains(":")) {
      jamMulaiSelected = TimeOfDay(
        hour: int.parse(data['jam_mulai'].split(":")[0]),
        minute: int.parse(data['jam_mulai'].split(":")[1]),
      );
    } else {
      jamMulaiSelected = TimeOfDay(hour: 0, minute: 0); // Default value
    }

    if (data['jam_selesai'] != null && data['jam_selesai'].contains(":")) {
      jamSelesaiSelected = TimeOfDay(
        hour: int.parse(data['jam_selesai'].split(":")[0]),
        minute: int.parse(data['jam_selesai'].split(":")[1]),
      );
    } else {
      jamSelesaiSelected = TimeOfDay(hour: 0, minute: 0); // Default value
    }

    // Mengisi status dan dokumentasi checks dengan pengecekan null
    if (data['checks'] != null) {
      for (var check in data['checks']) {
        String itemName = check['item_name'] ?? '';
        String status = check['status'] ?? '';
        String documentation = check['documentation'] ?? '';

        switch (itemName) {
          case "Kondisi Underacarriage (A)":
            statusKondisiUnderacarriage.value = status;
            dokumentasiKondisiUnderacarriage.value = documentation;
            break;
          case "Kerusakan akibat insiden ***) (AA)":
            statusKerusakanAkibatInsiden.value = status;
            dokumentasiKerusakanAkibatInsiden.value = documentation;
            break;
          case "Kebocoran oli gear box / oil PTO (AA)":
            statusKebocoranOliGearBox.value = status;
            dokumentasiKebocoranOliGearBox.value = documentation;
            break;
          case "Level oil swing & kebocoran (AA)":
            statusLevelOilSwing.value = status;
            dokumentasiLevelOilSwing.value = documentation;
            break;
          case "Level oil hydraulic & kebocoran (AA)":
            statusLevelOilHydraulic.value = status;
            dokumentasiLevelOilHydraulic.value = documentation;
            break;
          case "Fuel drain / Buangan air dari tanki BBC (A)":
            statusFuelDrain.value = status;
            dokumentasiFuelDrain.value = documentation;
            break;
          case "BBC minimum 25% dari Cap. Tanki (A)":
            statusBBCminimum.value = status;
            dokumentasiBBCminimum.value = documentation;
            break;
          case "Buang air dalam tanki udara (A)":
            statusBuangAirDalamTankiUdara.value = status;
            dokumentasiBuangAirDalamTankiUdara.value = documentation;
            break;
          case "Kebersihan accessories safety & Alat (A)":
            statusKebersihanAccessoriesSafety.value = status;
            dokumentasiKebersihanAccessoriesSafety.value = documentation;
            break;
          case "Kebocoran2 bila ada (oli, solar, grease ) (A)":
            statusKebocoranBilaAda.value = status;
            dokumentasiKebocoranBilaAda.value = documentation;
            break;
          case "Alarm travel (Big Digger) (A)":
            statusAlarmTravel.value = status;
            dokumentasiAlarmTravel.value = documentation;
            break;
          case "Lock pin Bucket (AA)":
            statusLockpinBucket.value = status;
            dokumentasiLockpinBucket.value = documentation;
            break;
          case "Lock pin tooth & ketajaman kuku (AA)":
            statusLockpinTooth.value = status;
            dokumentasiLockpinTooth.value = documentation;
            break;
          case "Kebersihan aki / battery (A)":
            statusKebersihanAki.value = status;
            dokumentasiKebersihanAki.value = documentation;
            break;
          case "Air conditioner (AC) (A)":
            statusAirConditioner.value = status;
            dokumentasiAirConditioner.value = documentation;
            break;
          case "Fungsi steering / kemudi (AA)":
            statusFungsiSteering.value = status;
            dokumentasiFungsiSteering.value = documentation;
            break;
          case "Fungsi seat belt / sabuk pengaman (AA)":
            statusFungsiSeatbelt.value = status;
            dokumentasiFungsiSeatbelt.value = documentation;
            break;
          case "Fungsi semua lampu (AA)":
            statusFungsiSemuaLampu.value = status;
            dokumentasiFungsiSemuaLampu.value = documentation;
            break;
          case "Fungsi Rotary lamp (AA)":
            statusFungsiRotaryLamp.value = status;
            dokumentasiFungsiRotaryLamp.value = documentation;
            break;
          case "Fungsi mirror / spion (A)":
            statusFungsiMirror.value = status;
            dokumentasiFungsiMirror.value = documentation;
            break;
          case "Fungsi wiper dan air wiper (A)":
            statusFungsiWiper.value = status;
            dokumentasiFungsiWiper.value = documentation;
            break;
          case "Fungsi horn / klakson (AA)":
            statusFungsiHorn.value = status;
            dokumentasiFungsiHorn.value = documentation;
            break;
          case "Fire Extinguiser / Fire supresion APAR (AA)":
            statusFireExtinguiser.value = status;
            dokumentasiFireExtinguiser.value = documentation;
            break;
          case "Fungsi kontrol panel (AA)":
            statusFungsiKontrolPanel.value = status;
            dokumentasiFungsiKontrolPanel.value = documentation;
            break;
          case "Fungsi radio komunikasi (AA)":
            statusFungsiRadioKomunikasi.value = status;
            dokumentasiFungsiRadioKomunikasi.value = documentation;
            break;
          case "Kebersihan ruang kabin (A)":
            statusKebersihanRuangKabin.value = status;
            dokumentasiKebersihanRuangKabin.value = documentation;
            break;
          case "Radiator (AA)":
            statusRadiator.value = status;
            dokumentasiRadiator.value = documentation;
            break;
          case "Engine / Oli Mesin (AA)":
            statusEngine.value = status;
            dokumentasiEngine.value = documentation;
            break;
        }
      }
    }
  }

  void showImagePicker(BuildContext context, documentation) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 150,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, documentation, context);
                  Navigator.pop(context);
                },
                child: Text('Ambil Gambar dari Kamera'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery, documentation, context);
                  Navigator.pop(context);
                },
                child: Text('Pilih Gambar dari Galeri'),
              ),
            ],
          ),
        );
      },
    );
  }

  XFile? imageFile;

  Future<void> getImage(
      ImageSource source, RxString documentation, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();

      XFile? imageFile =
          await picker.pickImage(source: source, imageQuality: 25);

      showLoading();

      if (imageFile != null) {
        var result = await FlutterImageCompress.compressWithFile(
          imageFile.path,
          minHeight: 1024,
          quality: 30,
        );

        print(result);

        print("resizedImageFile.path : ${result}");

        await authService().uploadImage(context, result, documentation);

        onLoadingDismiss();
      }
    } catch (e) {
      print('Error saat mengambil gambar: $e');
      onLoadingDismiss();
    }
  }
}
