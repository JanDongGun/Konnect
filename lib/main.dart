import 'package:flutter/material.dart';
import 'package:konnect/pages/login_page.dart';
import 'services/navigation_service.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      initialRoute: "login",
      routes: {
        "login":(BuildContext _context) => LoginPage(),
      },
    );
  }
}
