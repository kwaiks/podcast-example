import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/player.dart';
import '../services/getcat.dart';
import '../blocs/global.dart';
import 'package:provider/provider.dart';

class AllPodsPage extends StatefulWidget {
  @override
  _AllPodsPage createState() => _AllPodsPage();
}

class _AllPodsPage extends State<AllPodsPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("All Podcasts"),
        ),
        bottomNavigationBar: Player(),
        body: new Center(
          child: new FutureBuilder<List<Pods>>(
            future: downloadPodsJSON(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Pods> data = snapshot.data;
                return new CustomPodsListView(data);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return new CircularProgressIndicator();
            },
          ),
        ));
  }
}

class CustomPodsListView extends StatelessWidget {
  final List<Pods> pods;
  CustomPodsListView(this.pods);

  Widget build(context) {
    return ListView.builder(
      itemCount: pods.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(pods[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Pods pods, BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Card(
        child: InkWell(
          onTap: () {
            _globalBloc.musicPlayerBloc
                .playMusic(pods.audio, pods.title, pods.cat, pods.username);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(pods.pic),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          pods.title,
                          style: new TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(pods.username,
                              style:
                                  new TextStyle(fontWeight: FontWeight.w100)),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: new Icon(Icons.play_circle_outline, size: 40.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
