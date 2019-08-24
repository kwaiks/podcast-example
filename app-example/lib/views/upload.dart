import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import '../services/getcat.dart';
import '../services/const.dart' as url;

class UploadPage extends StatefulWidget {
  UploadPage({this.user});
  final String user;
  @override
  _UploadPage createState() => _UploadPage();
}

class _UploadPage extends State<UploadPage> {
  TextEditingController _title = TextEditingController();
  String _fileExt="";
  String fileName="";
  File file;
  String _mySelection = "Select Category";

  void _openMusic() async {
    try {
      file = await FilePicker.getFile(type: FileType.AUDIO);
      print(file.path);
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      fileName = basename(file.path);
      _fileExt = basename(file.path).replaceAll(' ', '_');
      print(_fileExt);
    });
  }

  Future upload(File file) async {
    Navigator.of(this.context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }));
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse(url.url+"tes.php");

    var request = new http.MultipartRequest("POST", uri);

    var multiPartFile = new http.MultipartFile("berkas", stream, length,
        filename: widget.user + "_" + _fileExt);
    try {
      request.fields['id'] = widget.user;
      print(widget.user);
      request.fields['title'] = _title.text;
      print(_title.text);
      request.fields['cat'] = _mySelection;
      print(_mySelection);
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
      Navigator.pop(this.context);
      setState(() {
        fileName = "Upload Successful";
        _title.text ="";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("Upload Podcast"),
        ),
        body: new Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: new Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: new Text("Judul", style: TextStyle(fontSize: 24),)),
                new Container(
                  width: 400,
                  child: TextFormField(
                    controller: _title,
                    decoration: InputDecoration(
                        hintText: "Masukan Judul",
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                ),
                SizedBox(height: 20,),
                FutureBuilder<List<Categories>>(
                future: downloadCatJSON(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Categories>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<Categories>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<Categories>(
                              child: Text(user.cat),
                              value: user,
                            ))
                        .toList(),
                    onChanged: (Categories value) {
                      setState(() {
                        _mySelection = value.cat;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,
                    hint: Text(_mySelection,style: TextStyle(color: Colors.black),),
                  );
                }),SizedBox(height: 20,),new RaisedButton.icon(
                      label: Text("Pilih File"),
                      onPressed: _openMusic,
                      icon: Icon(Icons.touch_app),
                    ),
                    Text(fileName),
                    FlatButton(onPressed: (){
                      setState(() {
                      upload(file);
                        
                      });
                    },child: Text("Upload"),
                    color: Colors.cyan,)
                  ],
                ),
              
            ),
          ),
        );
  }
}
