import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddFuelController extends GetxController {
  Rx<DateTime?> selectDate = Rx<DateTime?>(null);
  ImagePicker picker = ImagePicker();
  RxString image = ''.obs;
  TextEditingController id = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController uprice = TextEditingController();
  TextEditingController tp = TextEditingController();
  TextEditingController date = TextEditingController();

  void addcameraimage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.camera);
    if (pickedfile != null) {
      image.value = pickedfile.path;
    }
  }
}
