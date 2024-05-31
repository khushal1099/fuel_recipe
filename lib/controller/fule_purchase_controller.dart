import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/fule_purchase_model.dart';

class FuelPurchaseController extends GetxController {
  RxList<FulePurchase> fuleList = <FulePurchase>[].obs;

  @override
  void onInit() {
    getApi();
    super.onInit();
  }

  Future<void> getApi() async {
    try {
      var post = await http.post(
          Uri.parse(
              'https://raviraj.co.in/raviraj//api/fuelpurchase/getfuelpurchase'),
          body: json.encode({"api_token": "fcGFRNoNfDrFEq4qOKdG8vPQOu3yYb", "user_type": "sitemanager"}),
          headers: {'Content-Type': 'application/json'});

      if(post.statusCode==200){
        Map<String,dynamic> data = jsonDecode(post.body) as Map<String,dynamic>;
        var records = data["records"] as Map<String,dynamic>;
        var dataList = records["data"] as List;
        fuleList.value=dataList.map((e) {
          print("EEEE = > $e");
          return FulePurchase.fromJson(e);
        }).toList();

      }

      print("ress ${post.body}");
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
