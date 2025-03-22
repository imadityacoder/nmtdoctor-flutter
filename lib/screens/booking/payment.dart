import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nmt_doctor_app/providers/order_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool addHardCopy = false;
  String? selectedPayment;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final packageDetails = orderProvider.getPackageDetails();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add Hard Copy Reports
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: addHardCopy,
                          onChanged: (value) {
                            setState(() {
                              addHardCopy = value!;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text("Add Hard Copy Reports @FREE"),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Price Details
                const Text(
                  "Price Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        priceDetailRow("Total Amount", "",
                            "₹${packageDetails?["totalPrice"]}"),
                        priceDetailRow("Hard Copy Fee", "₹89", "Free"),
                        priceDetailRow("Report Consultation", "₹299", "Free"),
                        const Divider(),
                        priceDetailRow("Amount to be paid", "",
                            "₹${packageDetails?["totalPrice"]}",
                            isBold: true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Select Payment Option
                const Text(
                  "Select Payment Option",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                paymentOptionTile("Pay online",
                    "UPI  Google Pay  PhonePe  All Bank", "online"),
                paymentOptionTile(
                    "Pay by Cash/Card during sample collection", "", "offline"),
                const SizedBox(height: 20),

                // Savings
                Text(
                  "You Saved ₹${packageDetails != null ? (3600 - int.parse(packageDetails["totalPrice"])) : "0"} on this booking",
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),

                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Grand Total",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹${packageDetails?["totalPrice"]}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                    height:
                        80), // Extra space so content doesn't overlap button
              ],
            ),
          ),

          // Fixed Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.white,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Handle payment confirmation
                  if (selectedPayment == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Please select a payment method!")),
                    );
                    return;
                  }
                  orderProvider.setPaymentType(selectedPayment!);
                  orderProvider.confirmOrder(
                      "user123"); // Pass actual user ID dynamically
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order Confirmed!")),
                  );
                },
                child: const Text(
                  "Confirm & Pay",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceDetailRow(String title, String oldPrice, String newPrice,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Row(
            children: [
              if (oldPrice.isNotEmpty)
                Text(
                  oldPrice,
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
              const SizedBox(width: 4),
              Text(
                newPrice,
                style: TextStyle(
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    color: isBold ? Colors.blue.shade700 : Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentOptionTile(String title, String subtitle, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Radio(
                value: value,
                groupValue: selectedPayment,
                onChanged: (val) {
                  setState(() {
                    selectedPayment = val as String;
                  });
                },
                activeColor: Colors.blue,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
