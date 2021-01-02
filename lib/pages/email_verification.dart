import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:konnect/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = _auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: backgroundColor,
      body: checkMailPageUI(),
    );
  }

  Widget checkMailPageUI() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          imageMailWidget(),
          SizedBox(
            height: 30,
          ),
          titleMailWidget(),
          Spacer(),
          okButtonWidget()
        ],
      ),
    );
  }

  Widget imageMailWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
      child: SvgPicture.asset(
        "images/mail.svg",
        height: 200,
        width: 200,
      ),
    );
  }

  Widget titleMailWidget() {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Check your email",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                    color: dotColor, borderRadius: BorderRadius.circular(100)),
              )
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "An email has been sent to ${user.email}. Please check it",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 18,
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget okButtonWidget() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          NavigationService.instance.navigateToReplacement("login");
        },
        color: Color(0xFF00C898),
        textColor: Colors.white,
        child: Text("Ok",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      NavigationService.instance.navigateToReplacement("checkmail");
    }
  }
}
