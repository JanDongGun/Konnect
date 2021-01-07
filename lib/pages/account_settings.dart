import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/models/contact.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/cloud_storage_service.dart';
import 'package:konnect/services/db_service.dart';
import 'package:konnect/services/media_service.dart';
import 'package:konnect/services/navigation_service.dart';
import 'package:konnect/services/snackbar_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AccSettingsPage extends StatefulWidget {
  @override
  _AccSettingsPageState createState() => _AccSettingsPageState();

  final _width;
  final _height;

  AccSettingsPage(this._width, this._height);

  AuthProvider _auth = AuthProvider.instance;
}

class _AccSettingsPageState extends State<AccSettingsPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _AccSettingsPageState() {
    _formKey = GlobalKey<FormState>();
  }
  File image;
  String checkname;
  String name;
  String email;
  String userEmail;
  String imageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dotColor,
      ),
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
    return Form(
      key: _formKey,
      onChanged: () {
        _formKey.currentState.save();
      },
      child: Builder(builder: (BuildContext _context) {
        widget._auth = Provider.of<AuthProvider>(_context);
        SnackBarSv.instance.buildContext = _context;
        return StreamBuilder<Contact>(
          stream: DBService.instance.getUserData(widget._auth.user.uid),
          builder: (_context, _snapshot) {
            var _userData = _snapshot.data;
            return _snapshot.hasData
                ? Align(
                    child: SizedBox(
                      height: widget._height * 0.88,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          _userImageWidget(_userData.image),
                          SizedBox(height: 30),
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
      }),
    );
  }

  Widget _userImageWidget(String _image) {
    double _imageRadius = widget._height * 0.3;
    imageURL = _image;
    return Container(
      margin: EdgeInsets.only(left: 70),
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
    checkname = _userName;
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
    userEmail = _email;
    return Container(
      height: widget._height * 0.05,
      width: widget._width,
      child: Text(
        _email,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Roboto",
          color: Colors.white70,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _updateButton() {
    return widget._auth.status == AuthStatus.Authenticating
        ? Align(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          )
        : Container(
            height: widget._height * 0.09,
            width: widget._width,
            child: FlatButton(
              onPressed: () {
                if (name == null) {
                  name = checkname;
                  updateProfile();
                } else if (image == null) {
                  SnackBarSv.instance.showSnackbarError("Please pick a image");
                } else {
                  updateProfile();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2000),
              ),
              color: dotColor,
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }

  void updateProfile() {
    widget._auth.updateProfile(name, imageURL, (String _uid) async {
      var _result =
          await CloudStorageService.instance.uploadUserImage(_uid, image);
      var _imageURL = await _result.ref.getDownloadURL();
      await DBService.instance.updateUserInDB(_uid, name, userEmail, _imageURL);
    });
  }
}
