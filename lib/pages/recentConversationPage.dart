import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/models/conversation.dart';
import 'package:konnect/pages/conversation_page.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/db_service.dart';
import 'package:konnect/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';

class RecentConversationPage extends StatefulWidget {
  @override
  _RecentConversationPageState createState() => _RecentConversationPageState();

  final _width;
  final _height;
  RecentConversationPage(this._width, this._height);

  AuthProvider _auth;
}

class _RecentConversationPageState extends State<RecentConversationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width,
      height: widget._height,
      child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance, child: _conversationListViewWidget()),
    );
  }

  Widget _conversationListViewWidget() {
    return Builder(builder: (BuildContext _context) {
      widget._auth = Provider.of<AuthProvider>(_context);
      return Container(
          margin: EdgeInsets.only(top: 15),
          height: widget._height,
          width: widget._width,
          child: StreamBuilder<List<ConversationSnippet>>(
            stream:
                DBService.instance.getUserConversation(widget._auth.user.uid),
            builder: (_context, _snapshot) {
              var _data = _snapshot.data;
              if (_data != null) {
                return _data.length != 0
                    ? ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (_context, _index) {
                          return ListTile(
                            onTap: () {
                              NavigationService.instance.navigateToRoute(
                                  MaterialPageRoute(
                                      builder: (BuildContext _context) {
                                return ConversationPage(
                                    _data[_index].conversationID,
                                    _data[_index].id,
                                    _data[_index].image,
                                    _data[_index].name);
                              }));
                            },
                            title: Text(
                              _data[_index].name,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto",
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              _data[_index].lastMessage,
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto",
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(_data[_index].image),
                                ),
                              ),
                            ),
                            trailing: _listTitleTrailingWidgets(
                                _data[_index].timestamp),
                          );
                        },
                      )
                    : Align(
                        child: Text(
                          "No conversations Yet!",
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: "Roboto",
                            fontSize: 15,
                          ),
                        ),
                      );
              } else {
                return SpinKitWanderingCubes(
                  color: dotColor,
                  size: 50,
                );
              }
            },
          ));
    });
  }

  Widget _listTitleTrailingWidgets(Timestamp _lastMessageTimestamp) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Last message",
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Roboto",
            color: Colors.white70,
          ),
        ),
        Text(
          timeago.format(_lastMessageTimestamp.toDate()),
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Roboto",
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
