import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/services/db_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

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
        child: StreamBuilder(
            stream: DBService.instance.getConversation(widget._conversationID),
            builder: (_context, _snaphot) {
              var _conversationData = _snaphot.data;
              if (_conversationData != null) {
                return ListView.builder(
                    itemCount: _conversationData.messages.length,
                    itemBuilder: (_context, _index) {
                      var _message = _conversationData.messages[_index];
                      return _textMessageBubble(
                          true, _message.content, _message.timestamp);
                    });
              } else {
                return SpinKitWanderingCubes(
                  color: dotColor,
                  size: 50,
                );
              }
            }));
  }

  Widget _textMessageBubble(
      bool _isOwnMessage, String _message, Timestamp _timestamp) {
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
            timeago.format(_timestamp.toDate()),
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
