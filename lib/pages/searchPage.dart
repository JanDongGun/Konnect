import 'package:flutter/material.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final _width;
  final _height;
  SearchPage(this._width, this._height);

  AuthProvider _auth;
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._width,
      height: widget._height,
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _searchPageUI(),
      ),
    );
  }

  Widget _searchPageUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _userSearchField(),
        _usersListView(),
      ],
    );
  }

  Widget _userSearchField() {
    return Container(
      height: this.widget._height * 0.1,
      width: widget._width,
      padding: EdgeInsets.symmetric(vertical: widget._height * 0.025),
      child: TextField(
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        onSubmitted: (_input) {},
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          labelStyle: TextStyle(color: Colors.white70),
          labelText: "Search",
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _usersListView() {
    return Container(
      height: widget._height * 0.7,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext _context, int _index) {
          return ListTile(
            title: Text("Hussain Mustafa",style: TextStyle(
              fontSize: 15,
                  fontFamily: "Roboto",
                  color: Colors.white70
            ),),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://i.pravatar.cc/150?img=3"),
                ),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Lastseen",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Roboto",
                  color: Colors.white70,
                  ),),
                  Text("About an hour ago",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Roboto",
                  color: Colors.white70,
                  ),),
              ],
            ),


          );
        },
      ),
    );
  }
}
