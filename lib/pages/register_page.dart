import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:konnect/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/db_service.dart';
import 'package:konnect/services/navigation_service.dart';
import 'package:konnect/services/media_service.dart';
import 'package:konnect/services/cloud_storage_service.dart';
import 'package:konnect/services/snackbar_service.dart';
import 'package:provider/provider.dart';

class RegisPage extends StatefulWidget {
  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  GlobalKey<FormState> _formKey;
  AuthProvider _auth;

  bool _hidePass = true;

  File _image;

  String _name;
  String _email;
  String _password;
  String _defaultImage =
      "https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.15752-9/129845629_994232164410256_7458584177989089590_n.png?_nc_cat=103&ccb=2&_nc_sid=ae9488&_nc_ohc=FpOUV-aaxzUAX-Fce46&_nc_ht=scontent.fsgn4-1.fna&oh=56c6c9434034e0ab9a4f999a125db030&oe=601B1D99";

  _RegisPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: regisPageUI(),
      )),
      backgroundColor: backgroundColor,
    );
  }

  Widget regisPageUI() {
    return Builder(builder: (BuildContext _context) {
      SnackBarSv.instance.buildContext = _context;
      _auth = Provider.of<AuthProvider>(_context);
      return Container(
        child: Padding(
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
                height: 20,
              ),
              inputForm(),
              SizedBox(
                height: 70,
              ),
              textSignInWidget(),
              SizedBox(
                height: 20,
              ),
              signUpButtonWidget()
            ],
          ),
        ),
      );
    });
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
    return Container(
      child: Column(
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
                fontFamily: 'Roboto', fontSize: 25, color: Colors.white54),
          )
        ],
      ),
    );
  }

  Widget inputForm() {
    return Container(
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageSelectorWidget() {
    return GestureDetector(
        onTap: () async {
          File _imageFile = await MediaService.instance.getImageInLibary();
          setState(() {
            _image = _imageFile;
          });
        },
        child: Column(
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _image != null
                              ? FileImage(_image)
                              : AssetImage("images/avt.png"),
                          fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Select a image',
              style: TextStyle(color: Colors.white38, fontSize: 15),
            )
          ],
        ));
  }

  Widget emailTextFieldWidget() {
    return TextFormField(
      validator: (_input) {
        return _input.length != 0 && _input.contains("@")
            ? null
            : "Please enter a valid email";
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
      },
      keyboardType: TextInputType.emailAddress,
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

  Widget nameTextFieldWidget() {
    return TextFormField(
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a name";
      },
      onSaved: (_input) {
        setState(() {
          _name = _input;
        });
      },
      style: TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 15),
        hintText: "Name",
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

  Widget passwordTextFieldWidget() {
    return Container(
        child: TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      obscureText: _hidePass,
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
              _hidePass = !_hidePass;
            });
          },
          child: Icon(
            Icons.vpn_key,
            color: Colors.white38,
          ),
        ),
      ),
    ));
  }

  Widget textSignInWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account ?",
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
            NavigationService.instance.navigateToReplacement("login");
          },
          child: Text(
            "Sign in",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget signUpButtonWidget() {
    return _auth.status == AuthStatus.Authenticating
        ? Align(
            child: CircularProgressIndicator(
              backgroundColor: dotColor,
            ),
            alignment: Alignment.center,
          )
        : Container(
            height: 70,
            width: double.infinity,
            child: SizedBox(
              height: 70,
              width: double.infinity,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2000)),
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      createUser();
                    }
                  });
                },
                color: dotColor,
                textColor: Colors.black,
                child: Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          );
  }

  void createUser() {
    _auth.regisUserWithEmailAndPassword(_email, _password, (String _uid) async {
      if (_image != null) {
        var _result =
            await CloudStorageService.instance.uploadUserImage(_uid, _image);
        var _imageURL = await _result.ref.getDownloadURL();
        await DBService.instance.createUserInDB(_uid, _name, _email, _imageURL);
      } else {
        await DBService.instance
            .createUserInDB(_uid, _name, _email, _defaultImage);
      }
    });
  }
}
