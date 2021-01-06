import 'dart:io';

import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/models/contact.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/db_service.dart';
import 'package:konnect/services/media_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AccSettingsPage extends StatefulWidget {
  @override
  _AccSettingsPageState createState() => _AccSettingsPageState();

  final _width;
  final _height;

  AccSettingsPage(this._width, this._height);

  AuthProvider _auth;
}

class _AccSettingsPageState extends State<AccSettingsPage> {
  File image;
  String name;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Container(
        height: widget._height,
        width: widget._width,
        padding: EdgeInsets.all(15),
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: _profilePageUI(),
        ),
      ),
    );
  }

  Widget _profilePageUI() {
    return Builder(builder: (BuildContext _context) {
      widget._auth = Provider.of<AuthProvider>(_context);
      return StreamBuilder<Contact>(
        stream: DBService.instance.getUserData(widget._auth.user.uid),
        builder: (_context, _snapshot) {
          var _userData = _snapshot.data;
          return _snapshot.hasData
              ? Align(
                  child: SizedBox(
                    height: widget._height * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _userImageWidget(_userData.image),
                        SizedBox(height: 50),
                        _userNameWidget(_userData.name),
                        SizedBox(height: 30),
                        _userEmailWidget(_userData.email),
                        Spacer(),
                        _updateButton(),
                      ],
                    ),
                  ),
                )
              : SpinKitWanderingCubes(
                  color: dotColor,
                  size: 50,
                );
        },
      );
    });
  }

  Widget _userImageWidget(String _image) {
    double _imageRadius = widget._height * 0.3;

    return Container(
      height: _imageRadius,
      width: _imageRadius,
      child: GestureDetector(
        onTap: () async {
          File _imageFile = await MediaService.instance.getImageInLibary();
          setState(() {
            image = _imageFile;
          });
        },
        child: Container(
          height: _imageRadius,
          width: _imageRadius,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_imageRadius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: image != null ? FileImage(image) : NetworkImage(_image),
              )),
        ),
      ),
    );
  }

  Widget _userNameWidget(String _userName) {
    return TextFormField(
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a name";
      },
      onSaved: (_input) {
        setState(() {
          name = _input;
        });
      },
      style: TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 15),
        hintText: _userName,
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

  Widget _userEmailWidget(String _email) {
    return Container(
      height: widget._height * 0.05,
      width: widget._width,
      child: Text(
        _email,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Roboto",
          color: Colors.white70,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _updateButton() {
    return Container(
      height: widget._height * 0.1,
      width: widget._width,
      child: FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: dotColor,
        child: Text(
          'Update',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
