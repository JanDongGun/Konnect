import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

  final _width;
  final _height;

  ProfilePage(this._width,this._height);
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text('Profile here'),
    );
  }
}
