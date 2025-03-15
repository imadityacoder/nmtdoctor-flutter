import 'package:flutter/material.dart';
import 'package:nmt_doctor_app/widgets/nmtd_navbar.dart';
import 'package:go_router/go_router.dart';

class NmtdNavbar extends StatelessWidget {
  const NmtdNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      currentIndex: _getCurrentIndex(context),
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.push('/health-checks');
            break;
          case 2:
            context.push('/cart');
            break;
          case 3:
            context.push('/profile');
            break;
        }
      },
      items: navbarItems,
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/home') return 0;
    if (location == '/health-checks') return 1;
    if (location == '/cart') return 2;
    if (location == '/profile') return 3;
    return 0;
  }
}
