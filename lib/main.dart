import 'package:flutter/material.dart';
import 'package:konnect/pages/CheckMail.dart';
import 'package:konnect/pages/forgotpass_page.dart';
import 'package:konnect/pages/login_page.dart';
import 'package:konnect/pages/register_page.dart';
import 'services/navigation_service.dart';
import 'package:konnect/pages/started_page.dart';
import 'package:konnect/services/db_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //DBService.instance.createUserInDB(
    //   "0123", "Dung", "dung@gmail.com", "http://www.pravat.cc");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: "started",
      routes: {
        "started": (BuildContext _context) => StartedPage(),
        "login": (BuildContext _context) => LoginPage(),
        "regis": (BuildContext _context) => RegisPage(),
        "forgot": (BuildContext _context) => ForgotpassPage(),
        "checkmail": (BuildContext _context) => CheckMailPage()
      },
    );
  }
}
