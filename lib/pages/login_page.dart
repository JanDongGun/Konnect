import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:konnect/constant.dart';
import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;

  GlobalKey<FormState> _formKey;

  String _email;
  String _password;

  _LoginPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: backgroundColor,
      body: loginPageUI(),
    );
  }

  Widget loginPageUI() {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          btnBackWidget(),
          titleLoginWidget(),
          inputForm(),
          Spacer(),
          textSignUpWidget(),
          SizedBox(
            height: 20,
          ),
          signinButtonWidget(),
        ],
      ),
    );
  }

  Widget btnBackWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 23, 0, 0),
      height: 30,
      width: 30,
      child: GestureDetector(
          onTap: () {
            NavigationService.instance.goBack();
          },
          child: SvgPicture.asset(
            "images/back.svg",
            color: Colors.white54,
          )),
    );
  }

  Widget titleLoginWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 30, 0, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Let's Sign you In",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                  color: dotColor, borderRadius: BorderRadius.circular(100)),
            )
          ]),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 250,
            child: Text(
              "Welcome Back you have been missed!",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                color: Colors.white54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          children: [
            emailInputWidget(),
            SizedBox(
              height: 20,
            ),
            passwordInputWidget(),
            SizedBox(
              height: 8,
            ),
            forgotPasswordWidget()
          ],
        ),
      ),
    );
  }

  Widget emailInputWidget() {
    return TextFormField(
      validator: (_input) {
        return _input.contains("@") && _input.length > 1
            ? null
            : "Please type a valid email";
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
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
    );
  }

  Widget passwordInputWidget() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      obscureText: !_showPass,
      validator: (_input) {
        return _input.length >= 6 ? null : "Please type password";
      },
      onSaved: (_input) {
        _password = _input;
      },
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38),
        hintText: "Password",
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
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

  Widget forgotPasswordWidget() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            NavigationService.instance.navigateToReplacement("forgot");
          },
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget textSignUpWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.white38,
            fontSize: 18,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            NavigationService.instance.navigateToReplacement("regis");
          },
          child: Text(
            "Sign up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget signinButtonWidget() {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          setState(() {
            if (_formKey.currentState.validate()) {
              print("Login success");
            }
          });
        },
        color: dotColor,
        textColor: Colors.white,
        child: Text("Sign In",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
