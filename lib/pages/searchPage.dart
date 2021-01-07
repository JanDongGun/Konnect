import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/db_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final _width;
  final _height;
  SearchPage(this._width, this._height);

  AuthProvider _auth;
}

class _SearchPageState extends State<SearchPage> {
  String _searchText;

  _SearchPageState() {
    _searchText = '';
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: widget._width,
        height: widget._height,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: _searchPageUI(),
        ),
      ),
    );
  }

  Widget _searchPageUI() {
    return Builder(builder: (BuildContext _context) {
      widget._auth = Provider.of<AuthProvider>(_context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _userSearchField(),
          _usersListView(),
        ],
      );
    });
  }

  Widget _userSearchField() {
    return Container(
      height: this.widget._height * 0.1,
      width: widget._width,
      margin: EdgeInsets.only(top: widget._height * 0.025),
      child: TextField(
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        onChanged: (_input) {
          setState(() {
            _searchText = _input;
          });
        },
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
    return StreamBuilder(
        stream: DBService.instance.getUsersInDB(_searchText),
        builder: (_context, _snapshot) {
          var _userData = _snapshot.data;
          if (_userData != null) {
            _userData.removeWhere(
                (_contact) => _contact.id == widget._auth.user.uid);
          }
          return _snapshot.hasData
              ? Container(
                  height: widget._height * 0.7,
                  child: ListView.builder(
                    itemCount: _userData.length,
                    itemBuilder: (BuildContext _context, int _index) {
                      var _user = _userData[_index];
                      var _currentTime = DateTime.now();
                      var _isUserActive = _user.lastseen.toDate().isAfter(
                          _currentTime.subtract(Duration(minutes: 20)));
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: ListTile(
                          title: Text(
                            _user.name,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto",
                                color: Colors.white70),
                          ),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_user.image),
                              ),
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _isUserActive
                                  ? Text(
                                      "Active Now",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Roboto",
                                        color: Colors.white70,
                                      ),
                                    )
                                  : Text(
                                      "Lastseen",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Roboto",
                                        color: Colors.white70,
                                      ),
                                    ),
                              _isUserActive
                                  ? Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: dotColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                  : Text(
                                      timeago.format(_user.lastseen.toDate()),
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Roboto",
                                        color: Colors.white70,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : SpinKitWanderingCubes(
                  color: dotColor,
                  size: 50,
                );
        });
  }
}
