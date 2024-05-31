import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/add_fule_controller.dart';
import '../model/api_helper.dart';

class AddFule extends StatefulWidget {
  const AddFule({Key? key}) : super(key: key);

  @override
  State<AddFule> createState() => _HomePageState();
}

class _HomePageState extends State<AddFule> {
  AddFuelController controller = Get.put(AddFuelController());
  RxDouble TotalPrice = 0.0.obs;
  RxDouble q = 0.0.obs;
  RxDouble up = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Fuel Purchase"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Invoice Number :",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              TextFormField(
                controller: controller.id,
                decoration: InputDecoration(
                  hintText: "Invoice no.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Date :",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6,
              ),
              Obx(
                () => Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        controller.selectDate.value = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          barrierDismissible: false,
                        );
                      },
                      child: Icon(
                        Icons.calendar_month,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.selectDate.value != null
                          ? DateFormat('dd-MM-yyyy')
                              .format(controller.selectDate.value!)
                          : "Pick Date",
                      style: TextStyle(fontSize: 25, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Quantity(liter) :",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: controller.qty,
                onChanged: (value) {
                  q.value = double.tryParse(controller.qty.text)!;
                  TotalPrice.value = q.value * up.value;
                  controller.tp.text = "${TotalPrice.value}";
                },
                decoration: InputDecoration(
                  hintText: "Quantity(liter)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Unit Price :",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: controller.uprice,
                onChanged: (value) {
                  up.value = double.tryParse(controller.uprice.text)!;
                  TotalPrice.value = q.value * up.value;
                  controller.tp.text = "${TotalPrice.value}";
                  print(TotalPrice.value);
                },
                decoration: InputDecoration(
                  hintText: "Unit Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Total Price :",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                readOnly: true,
                controller: controller.tp,
                // Convert double to String,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchase Bill :",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 6,
              ),
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.addcameraimage();
                  },
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.blue,
                    // Check if image is not empty
                    backgroundImage: controller.image.isNotEmpty
                        ? FileImage(
                            File(controller.image.value),
                          )
                        : null,
                    child: controller.image.isEmpty
                        ? Icon(
                            Icons.add_a_photo_outlined,
                            size: 100,
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    // Change color here
                    minimumSize: MaterialStateProperty.all<Size>(
                      Size(double.infinity, 50),
                    ),
                  ),
                  onPressed: () {
                    if (controller.id.text.isNotEmpty &&
                        controller.qty.text.isNotEmpty &&
                        controller.uprice.text.isNotEmpty &&
                        controller.image.isNotEmpty) {
                      ApiHelper().getApiData(
                        controller.id.text,
                        controller.selectDate.toString(),
                        controller.qty.text,
                        controller.tp.text,
                        controller.image.toString(),
                      );

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Successful"),
                            content: Text("Fule Purchase Added Successfully "),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );

                      controller.id.clear();
                      controller.selectDate.value = null;
                      controller.qty.clear();
                      controller.uprice.clear();
                      controller.tp.clear();
                      controller.image.value = '';
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Please Fulfill the Details"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
