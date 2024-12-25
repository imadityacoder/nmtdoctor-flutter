import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';

class HealthChecksContent extends StatelessWidget {
  const HealthChecksContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar: const NmtdNavbar(),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              const Text(
                ' Health Checks',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          buildHealthCheckItem(
            title: 'Complete Blood Count (CBC)',
            preprice:'200',
            price: '299',
          ),
          buildHealthCheckItem(
            title: 'Thyroid Function Test (TFT)',
            preprice:'200',
            price: '499',
          ),
          buildHealthCheckItem(
            title: 'Liver Function Test (LFT)',
            preprice:'200',
            price: '799',
          ),
          buildHealthCheckItem(
            title: 'Kidney Function Test (KFT)',
            preprice:'200',
            price: '699',
          ),
          buildHealthCheckItem(
            title: 'Blood Glucose Test',
            preprice:'200',
            price: '199',
          ),
          buildHealthCheckItem(
            title: 'Lipid Profile Test',
            preprice:'200',
            price: '599',
          ),
          buildHealthCheckItem(
            title: 'Hemoglobin Test',
            preprice:'200',
            price: '149',
          ),
          buildHealthCheckItem(
            title: 'Vitamin D Test',
            preprice:'200',
            price: '899',
          ),
          buildHealthCheckItem(
            title: 'Iron Deficiency Test',
            preprice:'200',
            price: '399',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/health-checks/cart');
        },
        child: const Icon(Icons.shopping_cart_rounded),
      ),
    );
  }


}
