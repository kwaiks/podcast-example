import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/const.dart' as url;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _nick = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email, password, confirm, username;
  String gender ="Male";
  DateTime selectedDate = DateTime.now();
  String yes = "Select Date";
  bool _autoValidate = false;
  String eh = "";
  String el ="";
  int _currValue = 1;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1980, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        yes = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

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

  String _validateUsername(String value) {
    if (value.isEmpty) {
      return "Enter Username";
    }
    return null;
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
  Future<void> _register() async {
     
     final response = await http.post(url.url+"register.php", body: {
      "email": email,
      "pass": password,
      "user":username,
      "gender":gender,
      "bday":yes
    });

    print(response.body);

    if(response.body=="success"){
      saveData(username);
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }else{
      setState(() {
        el = "GAGAL";
      });
    }
  }
  void _validateInputs() {
    final form = _formKey.currentState;
    if (form.validate() && yes != "Select Date") {
      form.save();
      _register();
    } else {
      setState(() => _autoValidate = true);
      eh = "Select Your BirthDay";
    }
  }

  
Future<bool> saveData(String ea) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('username', ea);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new SizedBox(
                      height: 30,
                    ),
                    new Container(alignment: Alignment.center,child: new Text("REGISTER", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.blueAccent),),),
                    new SizedBox(
                      height: 30,
                    ),
                    new Text(
                      "Email",
                    ),
                    new Container(
                      child: new TextFormField(
                        controller: _email,
                        onSaved: (String value) {
                          email = value;
                        },
                        validator: _validateEmail,
                        decoration: InputDecoration(
                            hintText: "Your Email",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12.0)),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Username",
                    ),
                    new Container(
                      child: new TextFormField(
                        controller: _nick,
                        onSaved: (String value) {
                          username = value;
                        },
                        validator: _validateUsername,
                        decoration: InputDecoration(
                            hintText: "Your Username",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12.0)),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Password",
                    ),
                    new Container(
                      child: new TextFormField(
                        controller: _password,
                        onSaved: (String value) {
                          password = value;
                        },
                        validator: _validatePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Your Password",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12.0)),
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Confirm Password",
                    ),
                    new Container(
                        child: new TextFormField(
                      onSaved: (String value) {
                        confirm = value;
                      },
                      validator: _validateConfirm,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Re-type Password",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12.0)),
                    )),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Gender",
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Container(
                      height: 30,
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _currValue,
                            onChanged: (int i) => setState(() {
                              gender = "Male";
                              _currValue = i;
                            }),
                          ),
                          new Text("Male"),
                          Radio(
                            value: 2,
                            groupValue: _currValue,
                            onChanged: (int i) => setState(() {
                              gender = "Female";
                              _currValue = i;
                            }),
                          ),
                          new Text("Female"),
                        ],
                      ),
                    ),
                    new SizedBox(
                      height: 10,
                    ),
                    new Text(
                      "Birthday",
                    ),
                    new Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            setState(() {
                              eh = "";
                            });
                            _selectDate(context);
                          },
                        ),
                        Text('$yes'),
                      ],
                    ),
                    new Text(eh,
                        style: TextStyle(fontSize: 10, color: Colors.red)),
                    new SizedBox(
                      height: 30,
                    ),
                    new Text(el),
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
        ),
      ),
    );
  }
}
