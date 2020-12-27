import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/services/navigation_service.dart';

import '../services/navigation_service.dart';

class StartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.0,
              width: double.infinity,
            ),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login.png'), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Konnect',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                      color: dotColor,
                      borderRadius: BorderRadius.circular(100)),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Easy communication, offers free, fast, easy and secure communication via text messages',
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 22, color: Colors.white38),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: signInBtnColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        NavigationService.instance.navigateTo("regis");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        NavigationService.instance.navigateTo("login");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
