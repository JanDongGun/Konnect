import 'package:flutter/material.dart';
import 'package:konnect/pages/CheckMail.dart';
import 'package:konnect/pages/forgotpass_page.dart';
import 'package:konnect/pages/homepage.dart';
import 'package:konnect/pages/login_page.dart';
import 'package:konnect/pages/register_page.dart';
import 'services/navigation_service.dart';
import 'package:konnect/pages/started_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: "started",
      routes: {
        "started": (BuildContext _context) => StartedPage(),
        "login": (BuildContext _context) => LoginPage(),
        "regis": (BuildContext _context) => RegisPage(),
        "forgot": (BuildContext _context) => ForgotpassPage(),
        "checkmail": (BuildContext _context) => CheckMailPage(),
        "homepage": (BuildContext _context) => HomePage(),
      },
    );
  }
}
