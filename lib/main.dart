import 'package:flutter/material.dart';
import 'package:konnect/pages/login_page.dart';
import 'package:konnect/pages/register_page.dart';
import 'services/navigation_service.dart';
import 'package:konnect/pages/started_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      },
    );
  }
}
