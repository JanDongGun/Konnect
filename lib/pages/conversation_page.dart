import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/models/message.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/db_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  String _conversationID;
  String _receiverID;
  String _receiverImage;
  String _receiverName;
  AuthProvider _auth;

  ConversationPage(this._conversationID, this._receiverID, this._receiverImage,
      this._receiverName);
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  double _width;
  double _height;

  GlobalKey<FormState> _formKey;
  String _message;

  _ConversationPageState() {
    _formKey = GlobalKey<FormState>();
    _message = "";
  }

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
          body: ChangeNotifierProvider<AuthProvider>.value(
            value: AuthProvider.instance,
            child: _conversationPageUI(),
          ),
        );
      },
    );
  }

  Widget _conversationPageUI() {
    return Builder(builder: (_context) {
      widget._auth = Provider.of<AuthProvider>(_context);
      return Stack(
        overflow: Overflow.visible,
        children: [
          _messageListView(),
          Align(
              alignment: Alignment.bottomCenter,
              child: _messageField(_context)),
        ],
      );
    });
  }

  Widget _messageListView() {
    return Container(
        width: _width,
        height: _height * 0.75,
        padding: EdgeInsets.all(15),
        child: StreamBuilder(
            stream: DBService.instance.getConversation(widget._conversationID),
            builder: (_context, _snaphot) {
              var _conversationData = _snaphot.data;
              if (_conversationData != null) {
                return ListView.builder(
                    itemCount: _conversationData.messages.length,
                    itemBuilder: (_context, _index) {
                      var _message = _conversationData.messages[_index];
                      bool _isOwnMessage =
                          _message.senderID == widget._auth.user.uid;
                      return _messageListViewChild(_isOwnMessage, _message);
                    });
              } else {
                return SpinKitWanderingCubes(
                  color: dotColor,
                  size: 50,
                );
              }
            }));
  }

  Widget _messageListViewChild(bool _isOwnMessage, Message _message) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment:
              _isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _userImageWidget(_isOwnMessage),
            SizedBox(
              width: 15,
            ),
            _textMessageBubble(
                _isOwnMessage, _message.content, _message.timestamp),
          ],
        ));
  }

  Widget _userImageWidget(bool _isOwnMessages) {
    double _imageRadius = _height * 0.06;
    return _isOwnMessages
        ? Container()
        : Container(
            width: _imageRadius,
            height: _imageRadius,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget._receiverImage),
              ),
            ),
          );
  }

  Widget _textMessageBubble(
      bool _isOwnMessage, String _message, Timestamp _timestamp) {
    List<Color> _colorScheme = _isOwnMessage
        ? [dotColor, Color(0xFF38f9d7)]
        : [Color.fromRGBO(69, 69, 69, 1), Color.fromRGBO(43, 43, 43, 1)];
    return Container(
      width: _width * 0.7,
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
              fontSize: 16,
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

  Widget _messageField(BuildContext _context) {
    return Container(
      height: _height * 0.08,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(43, 43, 43, 1),
        borderRadius: BorderRadius.circular(200),
      ),
      child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _messageTextField(),
              _sendMessageButton(_context),
              _imageMessageButton(),
            ],
          )),
    );
  }

  Widget _messageTextField() {
    return SizedBox(
        width: _width * 0.55,
        child: TextFormField(
          style: TextStyle(
            fontFamily: "Roboto",
            color: Colors.white,
            fontSize: 16,
          ),
          validator: (_input) {
            if (_input.length == 0) {
              return "Please enter a message";
            }
            return null;
          },
          onChanged: (_input) {
            setState(() {
              _message = _input;
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Type a message",
            hintStyle: TextStyle(
              color: Colors.white30,
              fontFamily: "Roboto",
              fontSize: 15,
            ),
          ),
          autocorrect: false,
          cursorColor: Colors.white,
        ));
  }

  Widget _sendMessageButton(BuildContext _context) {
    return Container(
      height: _height * 0.05,
      width: _height * 0.05,
      child: IconButton(
        icon: Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            DBService.instance.sendMessage(
              widget._conversationID,
              Message(
                  content: _message,
                  timestamp: Timestamp.now(),
                  senderID: widget._auth.user.uid,
                  type: MessageType.Text),
            );
          }
          _formKey.currentState.reset();
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget _imageMessageButton() {
    return Container(
      height: _height * 0.05,
      width: _height * 0.05,
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.camera_enhance),
      ),
    );
  }
}
