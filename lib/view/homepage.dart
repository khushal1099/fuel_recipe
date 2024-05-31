import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/fule_purchase_controller.dart';
import 'add_fule_purchase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FuelPurchaseController controller = Get.put(FuelPurchaseController());

  Future<void> refreshData() async {
    // Call your API to fetch fresh data
    await controller.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel Purchase List"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Obx(
        () {
          if (controller.fuleList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: refreshData,
              child: ListView.builder(
                itemCount: controller.fuleList.length,
                itemBuilder: (context, index) {
                  var fuelPurchase = controller.fuleList[index];
                  DateTime parsedDate =
                      DateFormat('yyyy-MM-dd').parse(fuelPurchase.date!);

                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Invoice Number.: ${fuelPurchase.id}",
                            style: TextStyle(fontSize: 20)),
                        Text(
                          "Date: ${DateFormat('dd-MM-yyyy').format(parsedDate)}",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity(liter): ${fuelPurchase.quantity}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "UnitPrice: ${fuelPurchase.unitPrice}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        Text(
                          "TotalPrice: ${fuelPurchase.totalPrice}",
                          style: TextStyle(
                              fontSize: 20, backgroundColor: Colors.black26),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddFule(),
              transition: Transition.cupertino,
              duration: Duration(milliseconds: 700),
              curve: Curves.linear);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
