// To parse this JSON data, do
//
//     final fulePurchase = fulePurchaseFromJson(jsonString);

import 'dart:convert';

FulePurchase fulePurchaseFromJson(String str) => FulePurchase.fromJson(json.decode(str));

String fulePurchaseToJson(FulePurchase data) => json.encode(data.toJson());

class FulePurchase {
  String? id;
  String? date;
  String? quantity;
  String? unitPrice;
  String? totalPrice;
  String? image;

  FulePurchase({
    this.id,
    this.date,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.image,
  });

  factory FulePurchase.fromJson(Map<String, dynamic> json) => FulePurchase(
    id: json["invoice_id"],
    date: json["datee"],
    quantity: json["quantity"],
    unitPrice: json["rate"],
    totalPrice: json["total_price"],
    image: json["bill"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "quantity": quantity,
    "unitPrice": unitPrice,
    "totalPrice": totalPrice,
    "image": image,
  };
}
