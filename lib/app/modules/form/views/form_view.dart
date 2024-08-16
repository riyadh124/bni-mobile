import 'package:bni_mobile/app/env/global_var.dart';
import 'package:bni_mobile/app/services/authService.dart';
import 'package:bni_mobile/widgets/button.dart';
import 'package:bni_mobile/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/form_controller.dart';

class FormView extends GetView<FormController> {
  FormView({Key? key}) : super(key: key);
  FormController formController = Get.put(FormController());
  @override
  Widget build(BuildContext context) {
    formController.getDetailForm();
    return Scaffold(
        appBar: AppBar(
          title: CText(
            'Formulir',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE3E5EB)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Informasi Formulir",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Tipe Unit',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                    value: formController.tipeUnitController.text,
                    onChanged: (newValue) {
                      print(newValue);
                      formController.tipeUnitController.text = newValue;
                    },
                    items: formController.tipeUnitList
                        .map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: formController.modelUnitController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Model Unit',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: formController.nomorUnitController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Nomor Unit',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Shift',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                    value: formController.shiftController.text,
                    onChanged: (newValue) {
                      print(newValue);
                      formController.shiftController.text = newValue;
                    },
                    items:
                        formController.shiftList.map<DropdownMenuItem>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          );
                        },
                        initialTime: formController.jamMulaiSelected,
                      );
                      if (picked != null &&
                          picked != formController.jamMulaiSelected) {
                        formController.jamMulaiSelected = picked;

                        // Convert TimeOfDay to DateTime
                        final now = DateTime.now();
                        final selectedTime = DateTime(now.year, now.month,
                            now.day, picked.hour, picked.minute);

                        // Format DateTime to HH:mm:ss
                        final formattedTime =
                            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";

                        formController.jamMulaiController.text = formattedTime;
                      }
                    },
                    controller: formController.jamMulaiController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Jam Mulai',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    readOnly: true,
                    onTap: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(alwaysUse24HourFormat: true),
                            child: child!,
                          );
                        },
                        initialTime: formController.jamSelesaiSelected,
                      );
                      if (picked != null &&
                          picked != formController.jamSelesaiSelected) {
                        formController.jamSelesaiSelected = picked;

                        // Convert TimeOfDay to DateTime
                        final now = DateTime.now();
                        final selectedTime = DateTime(now.year, now.month,
                            now.day, picked.hour, picked.minute);

                        // Format DateTime to HH:mm:ss
                        final formattedTime =
                            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";

                        formController.jamSelesaiController.text =
                            formattedTime;
                      }
                    },
                    controller: formController.jamSelesaiController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Jam Selesai',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: formController.hmAwalController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'HM Awal',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: formController.hmAkhirController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'HM Akhir',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: formController.jobSiteController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Job Site',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: formController.lokasiController,
                    decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: 'Lokasi',
                        labelStyle: TextStyle(color: Colors.blue.shade900)),
                  ),
                ],
              ),
            ),
          
          
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE3E5EB)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Pemeriksaan Keliling Unit / Diluar Kabin",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kondisi underacarriage",
                      formController.statusKondisiUnderacarriage,
                      formController.dokumentasiKondisiUnderacarriage),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kerusakan akibat insiden ***)",
                      formController.statusKerusakanAkibatInsiden,
                      formController.dokumentasiKerusakanAkibatInsiden),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kebocoran oli gear box / oil PTO",
                      formController.statusKebocoranOliGearBox,
                      formController.dokumentasiKebocoranOliGearBox),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Level oil swing & kebocoran",
                      formController.statusLevelOilSwing,
                      formController.dokumentasiLevelOilSwing),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Level oil hydraulic & kebocoran",
                      formController.statusLevelOilHydraulic,
                      formController.dokumentasiLevelOilHydraulic),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fuel drain / Buangan air dari tanki BBC",
                      formController.statusFuelDrain,
                      formController.dokumentasiFuelDrain),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "BBC minimum 25% dari Cap. Tanki",
                      formController.statusBBCminimum,
                      formController.dokumentasiBBCminimum),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Buang air dalam tanki udara",
                      formController.statusBuangAirDalamTankiUdara,
                      formController.dokumentasiBuangAirDalamTankiUdara),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kebersihan accessories safety & Alat",
                      formController.statusKebersihanAccessoriesSafety,
                      formController.dokumentasiKebersihanAccessoriesSafety),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kebocoran2 bila ada (oli, solar, grease)",
                      formController.statusKebocoranBilaAda,
                      formController.dokumentasiKebocoranBilaAda),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Alarm travel (Big Digger)",
                      formController.statusAlarmTravel,
                      formController.dokumentasiAlarmTravel),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Lock pin Bucket",
                      formController.statusLockpinBucket,
                      formController.dokumentasiLockpinBucket),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Lock pin tooth & ketajaman kuku",
                      formController.statusLockpinTooth,
                      formController.dokumentasiLockpinTooth),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kebersihan aki / battery",
                      formController.statusKebersihanAki,
                      formController.dokumentasiKebersihanAki),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE3E5EB)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Pemeriksaan Di Dalam Kabin",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Air conditioner (AC)",
                      formController.statusAirConditioner,
                      formController.dokumentasiAirConditioner),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi steering / kemudi",
                      formController.statusFungsiSteering,
                      formController.dokumentasiFungsiSteering),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi seat belt / sabuk pengaman",
                      formController.statusFungsiSeatbelt,
                      formController.dokumentasiFungsiSeatbelt),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi semua lampu",
                      formController.statusFungsiSemuaLampu,
                      formController.dokumentasiFungsiSemuaLampu),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi Rotary lamp",
                      formController.statusFungsiRotaryLamp,
                      formController.dokumentasiFungsiRotaryLamp),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi mirror / spion",
                      formController.statusFungsiMirror,
                      formController.dokumentasiFungsiMirror),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi wiper dan air wiper",
                      formController.statusFungsiWiper,
                      formController.dokumentasiFungsiWiper),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi horn / klakson",
                      formController.statusFungsiHorn,
                      formController.dokumentasiFungsiHorn),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fire Extinguiser / Fire supresion APAR",
                      formController.statusFireExtinguiser,
                      formController.dokumentasiFireExtinguiser),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi kontrol panel",
                      formController.statusFungsiKontrolPanel,
                      formController.dokumentasiFungsiKontrolPanel),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Fungsi radio komunikasi",
                      formController.statusFungsiRadioKomunikasi,
                      formController.dokumentasiFungsiRadioKomunikasi),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Kebersihan ruang kabin",
                      formController.statusKebersihanRuangKabin,
                      formController.dokumentasiKebersihanRuangKabin),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE3E5EB)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Pemeriksaan Di Ruang Mesin",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  check(context, "Radiator", formController.statusRadiator,
                      formController.dokumentasiRadiator),
                  SizedBox(
                    height: 14,
                  ),
                  check(
                      context,
                      "Engine / Oli Mesin",
                      formController.statusEngine,
                      formController.dokumentasiEngine),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE3E5EB)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CText(
                    "Catatan",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextField(
                      controller: formController.catatanController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Tulis catatan',
                        border: OutlineInputBorder(),
                      )),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
                child: PrimaryButton(
                    text: "Simpan",
                    onTap: () {
                      authService().submitForm();
                    }))
          ],
        ));
  }

  Widget check(BuildContext context, String name, RxString status,
      RxString dokumentasi) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              width: MediaQuery.sizeOf(context).width - 300,
              child: CText(name)),
          Row(
            children: [
              Column(
                children: <Widget>[
                  Radio<String>(
                    value: 'OK',
                    groupValue: status.value,
                    onChanged: (String? value) {
                      status.value = value!;
                    },
                  ),
                  Text('OK'),
                ],
              ),
              SizedBox(width: 5), // Add some spacing between the columns
              Column(
                children: <Widget>[
                  Radio<String>(
                    value: 'NOK',
                    groupValue: status.value,
                    onChanged: (String? value) {
                      status.value = value!;
                    },
                  ),
                  Text('NOK'),
                ],
              ),
              SizedBox(width: 5), // Add some spacing between the columns

              Column(
                children: <Widget>[
                  Obx(() => dokumentasi.value != ""
                      ? IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {
                            Get.dialog(GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                margin: EdgeInsets.all(40),
                                // height: 100,
                                // width: 100,
                                // color: Colors.amber,
                                child: Image.network(
                                    "$urlApi${dokumentasi.value}"),
                              ),
                            ));
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            formController.showImagePicker(
                                context, dokumentasi);
                          },
                        )),
                  Text('Dokumentasi'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
