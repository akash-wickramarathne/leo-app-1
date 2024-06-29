import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart'; // Import the convert package

class PaymentService {
  static const String _url =
      'https://merchant-api-live-v2.onepay.lk/api/ipg/gateway/request-payment-link/';
  static const String _authorization =
      'fb8de5292c46d7eda5cb1e3d1c3e888a2184498e5d65cd5b82d009f0bd172a09aeb6640a60412a95.JY2T118E5281558BF868E';
  static const String _additionalCode = 'GV0D118E5281558BF867A';

  String _generateHash(Map<String, dynamic> data) {
    var bodyString = json.encode(data);
    var combinedString = '$bodyString$_additionalCode';
    var bytes = utf8.encode(combinedString);
    var digest = sha256.convert(bytes);
    return hex.encode(digest.bytes); // Convert the hash to a hexadecimal string
  }

  Future<String?> createPayment(int diamond, int amount) async {
    final Map<String, dynamic> body = {
      "amount": amount.toString(),
      "app_id": "TRYL118E5281558BF8652",
      "reference": "1234567823",
      "customer_first_name": "Johne",
      "customer_last_name": "Dohe",
      "customer_phone_number": "+94771234567",
      "customer_email": "onepay@spemai.com",
      "transaction_redirect_url":
          "https://developer.onepay.lk/#authentication/1234-3456"
    };

    final String hash = _generateHash(body);

    final response = await http.post(
      Uri.parse('$_url?hash=$hash'),
      headers: {
        'Authorization': _authorization,
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 1000) {
        return responseData['data']['gateway']['redirect_url'];
      }
    }
    return null;
  }
}
