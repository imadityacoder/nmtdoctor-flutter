import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:provider/provider.dart';

class HomeContent extends StatefulWidget {
  final bool isNewUser;

  const HomeContent({super.key, this.isNewUser = false});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false)
          .checkAndShowUserForm(context,);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: nmtdAppbar(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            const Text(
              'NMT DOCTOR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        actionIcon: Icons.notifications,
        actionFunction: () {},
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSection1Item(
                          icon: Icons.medical_services,
                          title: 'Blood Tests and Scans',
                          subtitle: 'Save upto 50% on blood tests',
                          backgroundColor: Colors.redAccent.shade200,
                          onTap: () => context.push('/health-checks'),
                        ),
                        buildSection1Item(
                          icon: Icons.safety_check_rounded,
                          title: 'Health Checks at Home',
                          subtitle: 'Starting from ₹499',
                          backgroundColor: Colors.amberAccent,
                          onTap: () => context.push('/health-packs'),
                          // Empty callback fixed
                        ),
                        buildSection1Item(
                          icon: Icons.camera_enhance_rounded,
                          title: 'Upload Prescription Receipt',
                          subtitle: 'Securely upload prescription receipt',
                          backgroundColor: Colors.purpleAccent,
                          onTap: () =>
                              context.push('/receipts'), // Empty callback fixed
                        ),
                        buildSection1Item(
                          icon: Icons.call_rounded,
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
                      'Popular Checkups',
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
                      children: popularCheckups.map((item) {
                        return buildSection2Item(
                          icon: item['icon']!,
                          title: item['title']!,
                          price: item['price']!,
                          preprice: item['price']!,
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
