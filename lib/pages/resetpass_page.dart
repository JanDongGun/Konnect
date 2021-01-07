import 'package:flutter/material.dart';
import 'package:konnect/provider/auth_provider.dart';
import 'package:konnect/services/navigation_service.dart';
import 'package:konnect/services/snackbar_service.dart';
import 'package:provider/provider.dart';
import '../constant.dart';

class ResetPassPage extends StatefulWidget {
  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  bool _showPass = false;
  bool _showPass1 = false;
  bool _showPass2 = false;

  GlobalKey<FormState> _formKey;

  String _password;
  String newpass;
  String rpPass;

  bool checkCurrentPasswordValid = true;

  AuthProvider _auth;

  _ResetPassPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dotColor,
      ),
      backgroundColor: backgroundColor,
      body: Container(
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: SingleChildScrollView(
            child: resetPassPageUI(),
          ),
        ),
      ),
    );
  }

  Widget resetPassPageUI() {
    return Builder(builder: (BuildContext _context) {
      SnackBarSv.instance.buildContext = _context;
      _auth = Provider.of<AuthProvider>(_context);
      return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            titleResetWidget(),
            SizedBox(
              height: 20,
            ),
            inputForm(),
            SizedBox(
              height: 230,
            ),
            saveButton(),
          ],
        ),
      );
    });
  }

  Widget titleResetWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 30, 0, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Change Password",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 8,
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                  color: dotColor, borderRadius: BorderRadius.circular(100)),
            )
          ]),
        ],
      ),
    );
  }

  Widget inputForm() {
    return Form(
      key: _formKey,
      onChanged: () {
        _formKey.currentState.save();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          children: [
            passWordCurrent(),
            SizedBox(
              height: 15,
            ),
            newPassword(),
            SizedBox(
              height: 15,
            ),
            repeatPassword()
          ],
        ),
      ),
    );
  }

  Widget passWordCurrent() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      obscureText: !_showPass,
      validator: (_input) {
        return _input.length >= 6 ? null : "Please type password";
      },
      onSaved: (_input) {
        _password = _input;
      },
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38),
        hintText: "Password Current",
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPass = !_showPass;
            });
          },
          child: Icon(
            Icons.vpn_key,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }

  Widget newPassword() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      obscureText: !_showPass1,
      validator: (_input) {
        return _input.length >= 6 ? null : "Please type password";
      },
      onSaved: (_input) {
        newpass = _input;
      },
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38),
        hintText: "New Password",
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPass1 = !_showPass1;
            });
          },
          child: Icon(
            Icons.vpn_key,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }

  Widget repeatPassword() {
    return TextFormField(
      style: TextStyle(color: Colors.white, fontSize: 15),
      obscureText: !_showPass2,
      validator: (_input) {
        return _input.length >= 6 && _input == newpass
            ? null
            : "Please enter the same password";
      },
      onSaved: (_input) {
        rpPass = _input;
      },
      decoration: InputDecoration(
        fillColor: Colors.grey[900],
        filled: true,
        hintStyle: TextStyle(color: Colors.white38),
        hintText: "Repeat Password",
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPass2 = !_showPass2;
            });
          },
          child: Icon(
            Icons.vpn_key,
            color: Colors.white38,
          ),
        ),
      ),
    );
  }

  Widget saveButton() {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(2000)),
        onPressed: () async {
          checkCurrentPasswordValid = await validatorCurPass(_password);
          if (_formKey.currentState.validate() && checkCurrentPasswordValid) {
            updatePassWord(newpass);
            NavigationService.instance.goBack();
          }
        },
        color: dotColor,
        textColor: Colors.white,
        child: Text("Save",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<bool> validatorCurPass(String password) async {
    return await _auth.changePassword(password);
  }

  void updatePassWord(String password) {
    _auth.updatePass(password);
  }
}
