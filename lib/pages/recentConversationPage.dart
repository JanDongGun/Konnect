import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';

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
    return Container(
      width: widget._width,
      height: widget._height,
      child: _conversationListViewWidget(),
    );
  }

  Widget _conversationListViewWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: widget._height,
      width: widget._width,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (_context, _index) {
          return ListTile(
            onTap: () {},
            title: Text("Hussain Mustafa",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Roboto",
                color: Colors.white,),),
            subtitle: Text("Subtitle",style: TextStyle(
              fontSize: 15,
          fontFamily: "Roboto",
          color: Colors.white,
            ),),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: NetworkImage("https://i.pravatar.cc/150?img=3"),
                ),
              ),
            ),
            trailing: _listTitleTrailingWidgets(),
          );
        },
      ),
    );
  }

  Widget _listTitleTrailingWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Lastseen",style: TextStyle(
          fontSize: 15,
          fontFamily: "Roboto",
          color: Colors.white,
        ),),
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: dotColor,
          ),
        ),
        
      ],
    );
  }
}
