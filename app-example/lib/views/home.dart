import 'package:flutter/material.dart';
import 'package:podcast/services/getcat.dart';
import 'categories.dart';
import 'package:provider/provider.dart';
import '../blocs/global.dart';
import './allpodcast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Center(
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: new Text(
                            "TOP PLAYS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24.0),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllPodsPage()));
                          },
                          child: new Container(
                            child: Text("Lihat Semua"),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Container(
                      height: 240.0,
                      child: new FutureBuilder<List<Pods>>(
                          future: downloadPodsJSON(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Pods> pod = snapshot.data;
                              return new CustomPodView(pod);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return new CircularProgressIndicator();
                          })),
                          SizedBox(height: 20,),
                  new Container(
                    padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: new Text(
                      "CATEGORIES",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0),
                    ),
                  ),
                  new Container(
                      height: 240.0,
                      child: new FutureBuilder<List<Categories>>(
                          future: downloadCatJSON(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Categories> cat = snapshot.data;
                              return new CustomCatView(cat);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return new CircularProgressIndicator();
                          })),
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomPodView extends StatelessWidget {
  final List<Pods> pod;
  CustomPodView(this.pod);

  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pod.length < 10 ? pod.length : 10,
          itemBuilder: (context, int currentIndex) {
            return createViewItem(pod[currentIndex], context);
          },
        ));
  }

  Widget createViewItem(Pods pod, BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      child: InkWell(
        onTap: (() {
          _globalBloc.musicPlayerBloc.playMusic(pod.audio, pod.title, pod.cat, pod.username);
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(pod.pic),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 150,
                    padding: const EdgeInsets.only(top: 16.0),
                    child: new Text(
                      pod.title,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCatView extends StatelessWidget {
  final List<Categories> cat;
  CustomCatView(this.cat);

  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: new GridView.count(
          childAspectRatio: 4,
          crossAxisCount: 2,
          children: List.generate(cat.length, (index){
            return createGridItem(cat[index], context);
          }),
        ));
  }
  
  Widget createGridItem(Categories cat, BuildContext context){
    return new Card(
        elevation: 1,
        child: InkWell(
          onTap: ((){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoriesPage(
                        title: cat.cat,
                      )));
          }),
                  child: Container(
            alignment: Alignment.center,
            child: Text(cat.cat)),
        ),
    );
  }

  // Widget createViewItem(Categories cat, BuildContext context) {
  //   return Container(
  //     child: InkWell(
  //       onTap: (() {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => CategoriesPage(
          //               title: cat.cat,
          //             )));
          // upCat(cat.cat);
  //       }),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Column(
  //               children: <Widget>[
  //                 Container(
  //                   height: 140.0,
  //                   width: 140.0,
  //                   decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                         image: NetworkImage(cat.image),
  //                         fit: BoxFit.fitWidth,
  //                       ),
  //                       borderRadius: BorderRadius.circular(10.0)),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 16.0),
  //                   child: new Text(
  //                     cat.cat,
  //                     textAlign: TextAlign.start,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
