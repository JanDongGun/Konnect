import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: loginPageUI(),
      ),
    );
  }

  Widget loginPageUI() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: [titleLoginWidget(), inputForm()],
      ),
    );
  }

  Widget titleLoginWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 50, 80, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's Sign you In",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Welcome Back you have been missed!",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 25,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  Widget inputForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Column(
        children: [
          emailInputWidget(),
          SizedBox(
            height: 7,
          ),
          passwordInputWidget()
        ],
      ),
    );
  }

  Widget emailInputWidget() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 15),
        hintText: "Email Address",
        contentPadding: EdgeInsets.all(20),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 2)),
      ),
    );
  }

  Widget passwordInputWidget() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      obscureText: !_showPass,
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38),
        hintText: "Password",
        contentPadding: EdgeInsets.all(20),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
                color: Colors.grey, style: BorderStyle.solid, width: 2)),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPass = !_showPass;
            });
          },
          child: Icon(
            Icons.vpn_key,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }

  Widget signinButtonWidget() {}
}
