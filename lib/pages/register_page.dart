import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:konnect/services/navigation_service.dart';

class RegisPage extends StatefulWidget {
  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: regisPageUI(),
      backgroundColor: backgroundColor,
    );
  }

  Widget regisPageUI() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          btnBackWidget(),
          SizedBox(
            height: 30,
          ),
          titleRegisWidget(),
          SizedBox(
            height: 35,
          ),
          inputForm(),
        ],
      ),
    );
  }

  Widget btnBackWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
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

  Widget titleRegisWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Sign Up to Konnect",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: dotColor, borderRadius: BorderRadius.circular(100)),
            )
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Please enter your details',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 25, color: Colors.white38),
        )
      ],
    );
  }

  Widget inputForm() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageSelectorWidget(),
          SizedBox(
            height: 20,
          ),
          nameTextFieldWidget(),
          SizedBox(
            height: 20,
          ),
          emailTextFieldWidget(),
          SizedBox(
            height: 20,
          ),
          passwordTextFieldWidget(),
        ],
      ),
    );
  }

  Widget imageSelectorWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/avt.png"), fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  Widget emailTextFieldWidget() {
    return Container(
        child: TextFormField(
      autocorrect: false,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(25),
        fillColor: Colors.grey[900],
        filled: true,
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white38),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
    ));
  }

  Widget nameTextFieldWidget() {
    return Container(
      child: TextFormField(
        autocorrect: false,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(25),
          fillColor: Colors.grey[900],
          filled: true,
          hintText: "Name",
          hintStyle: TextStyle(color: Colors.white38),
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

  Widget passwordTextFieldWidget() {
    return Container(
      child: TextFormField(
        autocorrect: false,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(25),
          fillColor: Colors.grey[900],
          filled: true,
          suffixIcon: Icon(
            Icons.vpn_key,
            color: Colors.white38,
          ),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white38),
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
}
