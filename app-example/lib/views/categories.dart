import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/player.dart';
import '../services/getcat.dart';
import '../blocs/global.dart';
import 'package:provider/provider.dart';


class CategoriesPage extends StatefulWidget{
  final String title;
  CategoriesPage({this.title});
  @override
  _CategoriesPage createState()=> _CategoriesPage();
}

class _CategoriesPage extends State<CategoriesPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text(widget.title),
        ),bottomNavigationBar: Player(),
        body: new Center(
            child: Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: new FutureBuilder<List<PodCat>>(
          future: downloadPodCatJSON(widget.title),
          builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PodCat> data = snapshot.data;
                return new CustomPodCatListView(data);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return new CircularProgressIndicator();
          },
        ),
            )));
  }
}

class CustomPodCatListView extends StatelessWidget {
  final List<PodCat> podCat;
  CustomPodCatListView(this.podCat);

  Widget build(context) {
    return ListView.builder(
      itemCount: podCat.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(podCat[currentIndex], context);
      },
    );
  }

  Widget createViewItem(PodCat podCat, BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Card(
        child: InkWell(
          onTap: () {
            _globalBloc.musicPlayerBloc.playMusic(podCat.audio, podCat.title, podCat.cat, podCat.username);
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
                        image: NetworkImage(podCat.pic),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          podCat.title,
                          style: new TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20.0),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(podCat.username,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w100)),
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
