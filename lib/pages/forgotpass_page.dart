import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:konnect/services/navigation_service.dart';

class ForgotpassPage extends StatefulWidget {
  @override
  _ForgotpassPageState createState() => _ForgotpassPageState();
}

class _ForgotpassPageState extends State<ForgotpassPage> {
  String _email;

  GlobalKey<FormState> _formKey;

  _ForgotpassPageState() {
    _formKey = GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: backgroundColor,
      body: forgotpassPageUI(),
    );
  }

  Widget forgotpassPageUI() {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            imageMailBoxWidget(),
            SizedBox(
              height: 30,
            ),
            titleForgotWidget(),
            SizedBox(
              height: 60,
            ),
            emailForgotPassWidget(),
            SizedBox(
              height: 40,
            ),
            sendMailButtonWidget(),
            Spacer(),
            backToLoginWidget()
          ],
        ),
      ),
    );
  }

  Widget imageMailBoxWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
      child: SvgPicture.asset(
        "images/mailbox.svg",
        height: 200,
        width: 200,
      ),
    );
  }

  Widget titleForgotWidget() {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Forgot your password?",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 27,
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
              "Enter your registered mail below to receive password reset intruction",
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

  Widget emailForgotPassWidget() {
    return Container(
      child: TextFormField(
        validator: (_input) {
          return _input.contains("@") ? null : "Please type a valid email";
        },
        onSaved: (_input) {
          _email = _input;
        },
        style: TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          fillColor: Colors.grey[900],
          filled: true,
          hintStyle: TextStyle(color: Colors.white38, fontSize: 15),
          hintText: "Email Address",
          contentPadding: EdgeInsets.all(20),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget sendMailButtonWidget() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          if (_formKey.currentState.validate())
            NavigationService.instance.navigateToReplacement("checkmail");
        },
        color: Color(0xFF00C898),
        textColor: Colors.white,
        child: Text("Send",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget backToLoginWidget() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.navigateToReplacement("login");
      },
      child: Text(
        "Back to login",
        style: TextStyle(
            color: Colors.white70, fontSize: 20, fontFamily: "Roboto"),
      ),
    );
  }
}
