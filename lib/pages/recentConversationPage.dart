import 'package:flutter/material.dart';

class RecentConversationPage extends StatefulWidget {
  @override
  _RecentConversationPageState createState() => _RecentConversationPageState();

  final _width;
  final _height;
  RecentConversationPage(this._width, this._height);
}

class _RecentConversationPageState extends State<RecentConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text('Conversation here'),
    );
  }
}
