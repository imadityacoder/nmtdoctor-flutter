import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/api/local_data.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    // List of famous checkups items

    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar: const NmtdNavbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nmtdTitlebar(),
            // Section 1: Vertical list of items
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSection1Item(
                    icon: Icons.local_hospital,
                    title: 'Blood Tests and Scans',
                    subtitle: 'Save upto 50% on blood tests and scans',
                    backgroundColor: Colors.blueAccent.shade100,
                    onTap: () => context.push('/health-checks'),
                  ),
                  buildSection1Item(
                    icon: Icons.home,
                    title: 'Health Checks at Home',
                    subtitle: 'Starting from ₹499',
                    backgroundColor: Colors.amberAccent,
                    onTap: () => context.push('/health-packs'),
                    // Empty callback fixed
                  ),
                  buildSection1Item(
                    icon: Icons.camera_alt,
                    title: 'Upload Your Prescription Receipt',
                    subtitle:
                        'Securely upload your prescription receipt for quick and accurate healthcare services',
                    backgroundColor: Colors.purpleAccent,
                    onTap: () =>
                        context.push('/receipts'), // Empty callback fixed
                  ),
                  buildSection1Item(
                    icon: Icons.phone,
                    title: 'Request or Make a Call',
                    subtitle: 'We call you. No more call waiting',
                    backgroundColor: Colors.greenAccent,
                    onTap: () => context.push('/request-call'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Section 2: Famous Checkups Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Famous Checkups',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Section 3: Horizontal list of items (Dynamically generated)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: famousCheckups.map((item) {
                  return buildSection2Item(
                    icon: item['icon'] as IconData,
                    title: item['title']!,
                    price: item['price']!,
                    preprice: item['price'],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
