import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';
import 'package:nmt_doctor_app/routes/navbar.dart';
import 'package:nmt_doctor_app/screens/auth/edit_detail.dart';
import 'package:nmt_doctor_app/widgets/nmtd_appbar.dart';
import 'package:provider/provider.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userData = userProvider.userData;
    final isLoading = userProvider.isLoading;

    return Scaffold(
      appBar: nmtdAppbar(
        title: const Text('My Profile'),
        actionWidget: IconButton(
          onPressed: () => _showLogoutConfirmation(context),
          icon: const Icon(
            Icons.logout_rounded,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("User details not available"))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40.0, horizontal: 8.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 30,
                                maxRadius: 40,
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  size: 80,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userData['fullName'] ?? 'Guest',
                                        style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        onTap: userData.isNotEmpty
                                            ? () => showEditUserDetailForm(
                                                  context,
                                                  userData,
                                                )
                                            : null,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.blueGrey,
                                        ), // Disable if no data
                                      ),
                                    ],
                                  ),
                                  Text(
                                    userData['email'] ?? '-- -- --',
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    userData['phone'] ?? '-- -- --',
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildSectionTitle("My Details"),
                      _buildProfileOption(
                        "Family Members",
                        Icons.group,
                        () => context.push('/family-member'),
                      ),
                      _buildProfileOption(
                        "Address Book",
                        Icons.location_on,
                        () => context.push('/address'),
                      ),
                      _buildProfileOption(
                        "Prescription",
                        Icons.file_copy,
                        () {},
                      ),
                      _buildProfileOption(
                          "Bookings & Reports", Icons.shopping_bag, () {}),
                    ],
                  ),
                ),
      bottomNavigationBar: const NmtdNavbar(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildProfileOption(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        leading: Icon(icon, color: Colors.black87),
        title: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/signup');
                }
              },
              child: const Text("Logout",
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
