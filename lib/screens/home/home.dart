import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: nmtdAppbar(),
      bottomNavigationBar:const NmtdNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSection1Item(
                  icon: Icons.local_hospital,
                  title: 'Blood Tests and Scans',
                  subtitle: 'Save upto 50% on blood tests and scans',
                  backgroundColor: Colors.blueAccent.shade100,
                  onTap: () {context.go('/health-checks');},
                ),
                buildSection1Item(
                  icon: Icons.home,
                  title: 'Health Checks at Home',
                  subtitle: 'Starting from ₹499',
                  backgroundColor: Colors.amberAccent,
                  onTap: () {},
                ),
                buildSection1Item(
                  icon: Icons.local_offer,
                  title: 'App Exclusive Deals',
                  subtitle: 'Starting from ₹99',
                  backgroundColor: Colors.orangeAccent,
                  onTap: () {},
                ),
                buildSection1Item(
                  icon: Icons.phone,
                  title: 'Request a Call',
                  subtitle: 'We call you. No more call waiting',
                  backgroundColor: Colors.greenAccent,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 400,
                child: Text(
                  'Top Checkups',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildSection2Item(
                    icon: Icons.accessibility_sharp,
                    title: 'Kidney Function Test (KFT)',
                    subtitle: '₹699',
                  ),
                  buildSection2Item(
                    icon: Icons.my_library_books_rounded,
                    title: 'Hemoglobin Test',
                    subtitle: '₹399',
                  ),
                  buildSection2Item(
                    icon: Icons.assignment_ind,
                    title: 'Blood Glucose Test',
                    subtitle: '₹499',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
