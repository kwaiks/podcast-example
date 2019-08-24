import 'dart:convert';
import '../services/const.dart' as url;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, password;
  bool _autoValidate = false;
  String wow = "";

  String _validateUsername(String value) {
    if (value.isEmpty) {
      return "Enter Username";
    }
    return null;
  }

  Future<void> _login() async {
    final response = await http.post(url.url + "login.php", body: {
      "user": email,
      "pass": password,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        wow = "Login Fail";
      });
    } else {
      String username = datauser[0]['username'];
      saveData(username, password);
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }
  }

  Future<bool> saveData(String ea, String aww) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(aww);
    print(ea);
    setState(() {
      preferences.setString('username', ea);
      preferences.setString('password', aww);
    });
    return true;
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Text forms was validated.
      form.save();
      _login();
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, offset: new Offset(0, 0), blurRadius: 20)
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 300,
          height: 400,
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          new Image.asset(
                            "image/logo.png",
                            height: 150,
                            width: 150,
                          ),
                        ],
                      )),
                  new Text(
                    "Username",
                  ),
                  new Container(
                    width: 240,
                    child: new TextFormField(
                      validator: _validateUsername,
                      onSaved: (String value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    ),
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new Text(
                    "Password",
                  ),
                  new Container(
                    width: 240,
                    child: new TextFormField(
                      validator: _validateUsername,
                      onSaved: (String value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Your Password",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    ),
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new Container(
                    child: new Text(wow,
                        style:
                            TextStyle(fontSize: 10, color: Colors.redAccent)),
                  ),
                  new Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/RegisterPage');
                              },
                              child: Text("Register Now",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blueAccent)))),
                      FlatButton(
                        onPressed: () {
                          _validateInputs();
                        },
                        color: Colors.blue,
                        child: Text("Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
