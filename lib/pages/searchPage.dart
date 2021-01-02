import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final _width;
  final _height;
  SearchPage(this._width, this._height);
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Search Here'));
  }
}
