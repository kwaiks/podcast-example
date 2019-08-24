import 'package:flutter/material.dart';
import 'package:podcast/views/upload.dart';
import '../services/getcat.dart';
import '../blocs/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/update.dart' as up;

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key, this.user1}) : super(key: key);
  final String user1;
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  String user="";

  @override
  void initState(){
    user = widget.user1;
    getSharedPrefs();
    super.initState();
  }
  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("username");
    if(name!=null){
      user=name;
    }
    print(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: new Column(
            children: <Widget>[
              Padding( 
                      padding: const EdgeInsets.only(left:20, top:20, right:20),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: new Container(
                        alignment: Alignment.centerLeft,
                        child: new Text("My Podcast", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
                    ),
                    new FlatButton.icon(
                        color: Colors.blue,
                        icon: Icon(Icons.add),
                        label: Text('Upload'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => UploadPage(user: user)));
                        },
                      ),],
                ),
              ),
              Flexible(
                              child: new Container(
                      child: new FutureBuilder<List<Libs>>(
                          future: downloadLibsJSON(user),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Libs> cat = snapshot.data;
                              return new CustomLibView(cat,user);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return new CircularProgressIndicator();
                          }),
                    ),
              ),
            ],
          )
            ,
          ),
        
    );
  }
}



class CustomLibView extends StatelessWidget {
  final List<Libs> lib;
  final String user;
  CustomLibView(this.lib,this.user);


  
  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: lib.length,
          itemBuilder: (context, int currentIndex) {
            return createViewItem(lib[currentIndex], context);
          },
        ));
  }

  
  Widget createViewItem(Libs lib, BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Card(
        child: InkWell(
          onTap: () {
            _globalBloc.musicPlayerBloc.playMusic(lib.audio, lib.title, lib.cat, user);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: new Text(
                              lib.title,
                              style: new TextStyle(
                                fontFamily: "Rock Salt",
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              alignment: Alignment.centerLeft,
                              child: new Text(lib.cat))
                        ],
                      ),
                    ),
                  ),
                ),
                new Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: new Text(
                    lib.view,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){
                        print(lib.id);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Delete Podcast"),
                              content: new Text("Are You Sure Want To Delete "+lib.title+" ?"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    up.delete(lib.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
