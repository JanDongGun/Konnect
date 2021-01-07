import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';

class ConversationPage extends StatefulWidget {
  String _conversationID;
  String _receiverID;
  String _receiverImage;
  String _receiverName;

  ConversationPage(this._conversationID, this._receiverID, this._receiverImage,
      this._receiverName);
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  double _width;
  double _height;
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Builder(
      builder: (BuildContext _context) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Text(
              widget._receiverName,
              style: TextStyle(
                fontSize: 23,
                letterSpacing: 2,
                fontFamily: "Roboto",
              ),
            ),
            centerTitle: true,
          ),
          body: _conversationPageUI(),
        );
      },
    );
  }

  Widget _conversationPageUI() {
    return Stack(
      overflow: Overflow.visible,
      children: [
        _messageListView(),
      ],
    );
  }

  Widget _messageListView() {
    return Container(
      width: _width,
      height: _height * 0.75,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (_context, _index) {
            return _textMessageBubble(true, "Hello");
          }),
    );
  }

  Widget _textMessageBubble(bool _isOwnMessage, String _message) {
    List<Color> _colorScheme = _isOwnMessage
        ? [dotColor, Color(0xFF38f9d7)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    return Container(
      width: _width * 0.75,
      height: _height * 0.1,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2000),
        gradient: LinearGradient(
          colors: _colorScheme,
          stops: [0.3, 1],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _message,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
            ),
          ),
          Text(
            "A moment ago",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
            ),
          ),
        ],
      ),
    );
  }
}
