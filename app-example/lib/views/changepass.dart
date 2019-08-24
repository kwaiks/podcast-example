import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/global.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../services/const.dart' as url;

class ChangePass extends StatefulWidget{
  ChangePass({this.username});
  final String username;
  @override
  _ChangePass createState()=> _ChangePass();
}

class _ChangePass extends State<ChangePass>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController _password = TextEditingController();
  String newPass,confirm,oldPass,oldPassIn;

  // Future<void> getSharedPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   oldPass = prefs.getString("password");
  //   print(oldPass);
  // }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("password");
    if(name!=null){
      oldPass=name;
    }
  }

String _validatePassword(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter Password";
    } else if (value.length < 8) {
      return "Password must be more than 8 characters";
    }

    // The pattern of the email didn't match the regex above.
    return null;
  }

  String _validateConfirm(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter your password again";
    } else if (value != _password.text) {
      return "Password do not match";
    }

    // The pattern of the email didn't match the regex above.
    return null;
  }
  
  String _validateOldPass(String value){
    if (value.isEmpty) {
      // The form is empty
      return "Enter Password";
    }
    return null;
  }

  void _validateInputs() {
    final form = _formKey.currentState;
    print(oldPass);
    if (form.validate() && oldPassIn == oldPass) {
      form.save();
      _update();
      Navigator.of(context).pop();
    } else {
      setState(() => _autoValidate = true);
      print("ga sama");
    }
  }

Future<void> _update() async {
     final response = await http.post(url.url+"changepass.php", body: {
      "password": newPass,
      "user" : widget.username,
    });

    print(response.body);

    if(response.body=="success"){
      Navigator.of(context).pop();
    }else{
    }
  }

  @override
  Widget build(BuildContext context){
  final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
     setState(() {
       oldPass = _globalBloc.musicPlayerBloc.password;
       print(oldPass);
     });
    return Scaffold(
      appBar: new AppBar(title: Text("Change Password"),),
        body: SafeArea(
                  child: Center(
            child: Form(
                    autovalidate: _autoValidate,
                    key:_formKey,
                                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: new Text("Old Password"),
                        ),
                        new TextFormField(
                          onSaved: (String value) {
                            oldPassIn = value;
                          },
                          validator: _validateOldPass,
                          obscureText: true),
                        SizedBox(
                          height: 20,
                        ),
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: new Text("New Password"),
                        ),
                        new TextFormField(
                          controller: _password,
                          onSaved: (String value) {
                            newPass = value;
                          },
                          validator: _validatePassword,
                          obscureText: true),
                        SizedBox(
                          height: 20,
                        ),
                        new Container(
                          alignment: Alignment.centerLeft,
                          child: new Text("Confirm New Password"),
                        ),
                        new TextFormField(
                          onSaved: (String value) {
                            confirm = value;
                          },
                          validator: _validateConfirm,
                          obscureText: true),
                          SizedBox(
                            height: 20,
                          ),
                          new Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: _validateInputs,
                          child: Text("Register",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                      ],
                    ),
                  ),
          ),
        ),
      );
  }
}