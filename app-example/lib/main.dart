import 'dart:async';

import 'package:flutter/material.dart';
import 'package:podcast/views/home.dart';
import 'package:podcast/views/library.dart';
import 'package:podcast/services/player.dart';
import 'package:podcast/blocs/global.dart';
import 'package:podcast/views/setting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/login.dart';
import './views/register.dart';


void main() => runApp(MyApp());

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MyApp extends StatelessWidget {
  final GlobalBloc _globalBloc = GlobalBloc();
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>(
      builder: (BuildContext context){
        return _globalBloc;
      },dispose: (BuildContext context, GlobalBloc value)=> value.dispose(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
      '/LoginScreen': (BuildContext context) => new LoginPage(),
      '/RegisterPage': (BuildContext context) => new RegisterPage(),
      '/HomeScreen' : (BuildContext context) => new MyHomePage()
    },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _selectedIndex = 0;
  String _name="";

  final drawerItems =[
    new DrawerItem("Home", Icons.home),
    new DrawerItem("My Podcast", Icons.library_music),
    new DrawerItem("Setting", Icons.settings)
  ];

  @override
  void initState(){
    super.initState();
    getSharedPrefs();
  }

  _getDrawerItemScreen(int pos) {
    switch (pos){
      case 0:
        return new HomePage();
      case 1:
        return new LibraryPage(user1: _name,);
      default:
        return new SettingPage(user1: _name);
    }
  }


  _onSelectItem(int index) {
    setState(()=> _selectedIndex = index);
    Navigator.of(context).pop();
  }

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("username");
    if(name!=null){
      _name=name;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    Navigator.of(context).pushReplacementNamed('/LoginScreen');
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(
          d.title,
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        ),
        selected: i == _selectedIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    drawerOptions.add(new ListTile(
      leading: new Icon(Icons.exit_to_app),
      title: new Text("Logout", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400)),
      onTap: (){
        logout();
      },
    ));
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Podcast"),
      ),bottomNavigationBar: Player(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(_name),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemScreen(_selectedIndex)
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreen createState()=> _SplashScreen();
}
class _SplashScreen extends State<SplashScreen>{
  
  String _name;

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("username");
  }

  void navigationPage() {
    if(_name==null){
      Navigator.of(context).pushReplacementNamed('/LoginScreen');
    }else{
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    }
}

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }
  @override
  void initState(){
    super.initState();
    startTime();
    getSharedPrefs();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: new Image.asset("image/logo.png"),
      ),
    );
  }
}