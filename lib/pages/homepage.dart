import 'package:flutter/material.dart';
import 'package:konnect/constant.dart';
import 'package:konnect/pages/RecentConversationPage.dart';
import 'package:konnect/pages/profilePage.dart';
import 'package:konnect/pages/searchPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/snackbar_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  double _height;
  double _width;

  AuthProvider _auth = AuthProvider.instance;

  _HomePageState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            color: backgroundColor,
            onSelected: (val) => choiceAction(val, context),
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
          )
        ],
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Container(
          width: _width * 0.31,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "konnect",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 25,
                    color: Colors.white,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: dotColor, borderRadius: BorderRadius.circular(100)),
              )
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          indicatorColor: dotColor,
          labelColor: dotColor,
          tabs: [
            Tab(
              icon: Icon(
                Icons.people_outline,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 25,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.person_outline,
                size: 25,
              ),
            )
          ],
        ),
      ),
      body: _tabBarPages(),
    );
  }

  Widget _tabBarPages() {
    return TabBarView(
      controller: _tabController,
      children: [
        SearchPage(_width, _height),
        RecentConversationPage(_width, _height),
        ProfilePage(_width, _height)
      ],
    );
  }

  void choiceAction(String choice, BuildContext context) {
    if (choice == Constants.AccountSettings) {
      print('AccountSettings');
    } else if (choice == Constants.PasswordSettings) {
      print('PasswordSettings');
    } else if (choice == Constants.SignOut) {
      _auth.logoutUser(() {});
    }
  }
}
