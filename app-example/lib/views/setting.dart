import 'dart:io';

import 'package:flutter/material.dart';
import 'package:podcast/views/changepass.dart';
import '../services/getcat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/const.dart' as url;
import 'package:file_picker/file_picker.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key, this.user1}) : super(key: key);
  final String user1;
  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  String user = "";

  void initState() {
    user = widget.user1;
    getSharedPrefs();
    super.initState();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("username");
    if (name != null) {
      user = name;
    }
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          new Container(
            child: new FutureBuilder<List<Users>>(
                future: downloadUserJSON(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Users> user = snapshot.data;
                    return new CustomUsersView(user);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return new CircularProgressIndicator();
                }),
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangePass(username: user,)));
            },
            child:
                Text("Change Password", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ));
  }
}

class CustomUsersView extends StatefulWidget{
  final List<Users> users;
    CustomUsersView(this.users);
  @override
  _CustomUsersView createState()=> _CustomUsersView();
}

class _CustomUsersView extends State<CustomUsersView> {
  
  String email, fileName, _fileName;
  String el="";
  bool net = true;
  bool _autoValidate = false;
  File file;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  void _openImage() async {
    try {
      file = await FilePicker.getFile(type: FileType.IMAGE);
      print(file.path);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      fileName = basename(file.path);
      _fileName = extension(file.path);
    });
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _update(file);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  Future _update(File file) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse(url.url+"update.php");

    var request = new http.MultipartRequest("POST", uri);

    var multiPartFile = new http.MultipartFile("berkas", stream, length,
        filename: widget.users[0].username + _fileName);
    try {
      request.fields['email'] = email;
      request.fields['username'] = widget.users[0].username;
      print(email);
      print(multiPartFile.filename);
      request.files.add(multiPartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {
        throw Exception('Error');
      }
    } catch (Exception) {
      //Handle Exception
    } finally {
      setState(() {
        el="Successfully Changed";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Form(
                  autovalidate: _autoValidate,
                  key:_formKey,
                                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: new Text("Username"),
                      ),
                      new TextFormField(
                        enabled: false,
                        initialValue: widget.users[0].username,
                        decoration: new InputDecoration(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: new Text("Email"),
                      ),
                      new TextFormField(
                        initialValue: widget.users[0].email,
                        validator: _validateEmail,
                        onSaved: (String value) {
                          email = value;
                        },
                        decoration: new InputDecoration(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      new Container(
                        alignment: Alignment.centerLeft,
                        child: new Text("Birthday"),
                      ),
                      new TextFormField(
                        enabled: false,
                        initialValue: widget.users[0].birthdate,
                        decoration: new InputDecoration(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  new Container(
                    child: new Text("Picture"),
                  ),
                  _picChange()
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text(el),
        SizedBox(
          height: 30,
        ),
        FlatButton(
          color: Colors.blueAccent,
          onPressed: () {
            _validateInputs();
          },
          child: Text("Save Changes", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _picChange() {
    if (net) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          new Image.network(
            url.url + "image/user/" + widget.users[0].pic,
            height: 100,
            width: 100,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
                _openImage();
              setState((){
                net = false;
              });
            },
            child:
                Text("Change Picture", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          new Image.file(file,
            height: 100,
            width: 100,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              _openImage();
            },
            child:
                Text("Change Picture", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    }
  }
}
