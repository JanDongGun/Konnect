import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/models/contact.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/db_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

  final _width;
  final _height;

  ProfilePage(this._width, this._height);

  AuthProvider _auth;
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget._height,
      width: widget._width,
      padding: EdgeInsets.all(15),
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _profilePageUI(),
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
                    height: widget._height * 0.65,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _userImageWidget(_userData.image),
                        SizedBox(height: 50),
                        _userNameWidget(_userData.name),
                        SizedBox(height: 15),
                        _userEmailWidget(_userData.email),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_imageRadius),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(_image),
          )),
    );
  }

  Widget _userNameWidget(String _userName) {
    return Container(
      height: widget._height * 0.06,
      width: widget._width,
      child: Text(
        _userName,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400),
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
}
