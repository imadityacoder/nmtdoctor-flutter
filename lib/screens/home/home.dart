import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:nmt_doctor_app/widgets/builders.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/api/local_data.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
<<<<<<< HEAD
              padding: const EdgeInsets.only(right: 10),
=======
              padding: const EdgeInsets.symmetric(horizontal: 12),
>>>>>>> parent of fb8340f (UI upgraded)
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset('assets/images/icon.png'),
                ),
              ),
            ),
            const Text(
              'NMT DOCTOR',
              style: TextStyle(
                color: Colors.white,
<<<<<<< HEAD
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Roboto',
=======
                fontWeight: FontWeight.w600,
                fontSize: 24,
                fontFamily: 'Poppins',
>>>>>>> parent of fb8340f (UI upgraded)
              ),
            ),
          ],
        ),
<<<<<<< HEAD
        actionWidget: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
      ),
      bottomNavigationBar: const NmtdNavbar(),
      body: SafeArea(
        child: Column(
          children: [
            // Location Header
            Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                color: Color(0xFF003580),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Builder(
                builder: (context) {
                  final locationProvider =
                      Provider.of<LocationProvider>(context);

                  return Row(
                    children: [
                      const Icon(Icons.my_location_outlined,
                          color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: locationProvider.location.isEmpty ||
                                locationProvider.location.contains("location")
                            ? InkWell(
                                onTap: () {
                                  locationProvider.requestLocation(context);
                                  locationProvider.fetchLocation();
                                },
                                child: const Text(
                                  'Use My Current Location',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Text(
                                locationProvider.location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: userProvider.isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          // Section 1: Quick Actions Loading
                          for (int i = 0; i < 4; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(height: 20),

                          // Section 2: Popular Checkups Title Loading
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 25,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),

                          // Section 3: Horizontal List of Popular Checkups Loading
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          // Section 1: Quick Actions
                          buildSection1Item(
                            icon: Icons.medical_services,
                            title: 'Blood Tests and Scans',
                            subtitle: 'Save up to 50% on blood tests',
                            backgroundColor: Colors.redAccent.shade200,
                            onTap: () => context.push('/health-checks'),
                          ),
                          buildSection1Item(
                            icon: Icons.safety_check_rounded,
                            title: 'Health Checks at Home',
                            subtitle: 'Starting from ₹499',
                            backgroundColor: Colors.amberAccent,
                            onTap: () => context.push('/health-packs'),
                          ),
                          buildSection1Item(
                            icon: Icons.camera_enhance_rounded,
                            title: 'Upload Prescription',
                            subtitle: 'Securely upload prescription receipt',
                            backgroundColor: Colors.purpleAccent,
                            onTap: () => context.push('/receipts'),
                          ),
                          buildSection1Item(
                            icon: Icons.call_rounded,
                            title: 'Request or Make a Call',
                            subtitle: 'We call you. No more call waiting',
                            backgroundColor: Colors.greenAccent,
                            onTap: () => context.push('/request-call'),
                          ),
                          const SizedBox(height: 20),

                          // Section 2: Popular Checkups
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Popular Checkups',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Section 3: Horizontal List of Popular Checkups
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: popularCheckups.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: buildSection2Item(
                                    context: context,
                                    cardId: item['cardId'] ?? '',
                                    icon: item['svgAsset'] ?? '',
                                    title: item['title'] ?? '',
                                    price: item['price'] ?? '',
                                    preprice: item['preprice'] ?? '',
                                    desc: item['description'] ?? '',
                                    tests: item['tests'] ?? [],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
=======
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
>>>>>>> parent of fb8340f (UI upgraded)
    );
  }
}
