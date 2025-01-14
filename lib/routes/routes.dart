import 'package:go_router/go_router.dart';
import 'package:nmtdoctor_app/screens/healthchecks/cart.dart';
import 'package:nmtdoctor_app/screens/healthchecks/healthchecks.dart';
import 'package:nmtdoctor_app/screens/healthpacks/healthpacks.dart';
import 'package:nmtdoctor_app/screens/home/home.dart';
import 'package:nmtdoctor_app/screens/profile/profile.dart';
import 'package:nmtdoctor_app/screens/receipts/receipts.dart';
import 'package:nmtdoctor_app/screens/reports/reports.dart';
import 'package:nmtdoctor_app/screens/requestcall/requestcall.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Home page
      builder: (context, state) => const HomeContent(),
    ),
    GoRoute(
      path: '/health-checks', // Health Checks page
      builder: (context, state) => const HealthChecksContent(),
    ),
    GoRoute(
      path: '/health-packs', // Profile page
      builder: (context, state) => const HealthPacksContent(),
    ),
    GoRoute(
      path: '/health-checks/cart', // Health Checks page
      builder: (context, state) => const CartContent(),
    ),
    GoRoute(
      path: '/reports', // My Reports page
      builder: (context, state) => const ReportsContent(),
    ),
    GoRoute(
      path: '/receipts', // Profile page
      builder: (context, state) => const ReceiptsContent(),
    ),
    GoRoute(
      path: '/profile', // Profile page
      builder: (context, state) => const ProfileContent(),
    ),
    GoRoute(
      path: '/request-call', // Profile page
      builder: (context, state) => RequestCallContent(),
    ),
  ],
);
