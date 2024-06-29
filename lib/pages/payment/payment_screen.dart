import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'payment_service.dart'; // Import the service file
import 'payment_webview.dart'; // Import the web view page

class PaymentPage extends StatelessWidget {
  final int diamond;
  final int amount;

  PaymentPage({required this.diamond, required this.amount});

  Future<void> _makePayment(BuildContext context) async {
    final paymentService = PaymentService();
    final String? redirectUrl =
        await paymentService.createPayment(diamond, amount);

    if (redirectUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentWebview(url: redirectUrl),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Error'),
          content: Text('Failed to process the payment.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method: $diamond',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Amount: USD $amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => _makePayment(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: Text(
                  'Proceed to Pay',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
