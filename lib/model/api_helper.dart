import 'package:http/http.dart' as http;

class ApiHelper {
  static ApiHelper obj = ApiHelper._();

  ApiHelper._();

  factory ApiHelper() {
    return obj;
  }


  Future<void> getApiData(String invoice_id, String date, String qty,
      String tprice, String image) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://raviraj.co.in/raviraj/api/fuelpurchase/addfuelpurchase'));

      // Add form fields
      request.fields.addAll({
        'api_token': 'fcGFRNoNfDrFEq4qOKdG8vPQOu3yYb',
        'user_type': 'sitemanager',
        'fuelpump_id': '11',
        'purchase_type': 'Diesel',
        'vendor_id': '9',
        'invoice_id': invoice_id,
        'datee': date,
        'quantity': qty,
        'total_price': tprice
      });

      // Add file
      request.files.add(await http.MultipartFile.fromPath('bill', image));

      // Send request
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}
