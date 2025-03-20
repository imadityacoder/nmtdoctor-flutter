import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Payment Option",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // UPI Payment Option
            GestureDetector(
              onTap: () {},
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.payment, color: Colors.blue),
                      SizedBox(width: 10),
                      Text("Pay using UPI"),
                    ],
                  ),
                ),
              ),
            ),

            // Cash/Card Payment Option
            GestureDetector(
              onTap: () {
                debugPrint("Cash/Card Payment Selected");
              },
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.money, color: Colors.green),
                      SizedBox(width: 10),
                      Text("Pay by Cash/Card on Sample Collection"),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Confirm & Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
