import 'package:appwrite_auth_kit/appwrite_auth_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nmt_doctor_app/providers/address_provider.dart';
import 'package:nmt_doctor_app/providers/auth_provider.dart';
import 'package:nmt_doctor_app/providers/cart_provider.dart';
import 'package:nmt_doctor_app/providers/family_provider.dart';
import 'package:nmt_doctor_app/providers/healthcheck_provider.dart';
import 'package:nmt_doctor_app/providers/healthpack_provider.dart';
import 'package:nmt_doctor_app/providers/user_provider.dart';
import 'package:nmt_doctor_app/routes/routes.dart';
import 'package:nmt_doctor_app/utils/themes.dart';
import 'package:provider/provider.dart';


final Client client = Client();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  client
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('67bd465c003b91ff03f1');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthNotifier(client)),
        ChangeNotifierProvider(create: (_) => MyAuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => HealthpackProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => FamilyMemberProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: MyApp(myclient: client),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Client myclient;

  const MyApp({super.key, required this.myclient});

  @override
  Widget build(BuildContext context) {
    return AppwriteAuthKit(
      client: myclient,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'NMT Doctor',
        theme: nmtDoctorTheme,
      ),
    );
  }
}
