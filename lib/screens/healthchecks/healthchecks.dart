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
                  context.go('/home');
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
            price: '₹299',
          ),
          buildHealthCheckItem(
            title: 'Thyroid Function Test (TFT)',
            price: '₹499',
          ),
          buildHealthCheckItem(
            title: 'Liver Function Test (LFT)',
            price: '₹799',
          ),
          buildHealthCheckItem(
            title: 'Kidney Function Test (KFT)',
            price: '₹699',
          ),
          buildHealthCheckItem(
            title: 'Blood Glucose Test',
            price: '₹199',
          ),
          buildHealthCheckItem(
            title: 'Lipid Profile Test',
            price: '₹599',
          ),
          buildHealthCheckItem(
            title: 'Hemoglobin Test',
            price: '₹149',
          ),
          buildHealthCheckItem(
            title: 'Vitamin D Test',
            price: '₹899',
          ),
          buildHealthCheckItem(
            title: 'Iron Deficiency Test',
            price: '₹399',
          ),
        ],
      ),
    );
  }
}
