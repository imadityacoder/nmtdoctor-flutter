import 'package:go_router/go_router.dart';
import 'package:nmt_doctor_app/auth_warpper.dart';
import 'package:nmt_doctor_app/screens/auth/forgot_password.dart';
import 'package:nmt_doctor_app/screens/auth/login.dart';
import 'package:nmt_doctor_app/screens/auth/signup.dart';
import 'package:nmt_doctor_app/screens/healthchecks/cart.dart';
import 'package:nmt_doctor_app/screens/healthchecks/healthchecks.dart';
import 'package:nmt_doctor_app/screens/healthpacks/healthpacks.dart';
import 'package:nmt_doctor_app/screens/home/home.dart';
import 'package:nmt_doctor_app/screens/profile/profile.dart';
import 'package:nmt_doctor_app/screens/receipts/receipts.dart';
import 'package:nmt_doctor_app/screens/reports/reports.dart';
import 'package:nmt_doctor_app/screens/requestcall/requestcall.dart';
import 'package:nmt_doctor_app/screens/user/address.dart';
import 'package:nmt_doctor_app/screens/user/family.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/', // Home page
      builder: (context, state) => const AuthWrapper(),
    ),
    GoRoute(
      path: '/home', // Home page
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
      path: '/health-checks/hc-cart', // Health Checks page
      builder: (context, state) => const HcCartContent(),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const ReportsContent(),
    ),
    GoRoute(
      path: '/receipts',
      builder: (context, state) => const ReceiptsContent(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileContent(),
    ),
    GoRoute(
      path: '/request-call',
      builder: (context, state) => RequestCallContent(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpContent(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginContent(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordContent(),
    ),
    GoRoute(
      path: '/family-member',
      builder: (context, state) => const FamilyMemberForm(),
    ),
    GoRoute(
      path: '/address',
      builder: (context, state) => const AddressForm(),
    ),
  ],
);
