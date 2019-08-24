import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../blocs/global.dart';
import 'package:provider/provider.dart';
import '../models/playerstate.dart';

typedef void OnError(Exception exception);

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => new _PlayerState();
}

class _PlayerState extends State<Player> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  String url = "";


  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();

    advancedPlayer.durationHandler = (d) => setState(() {
          _duration = d;
        });

    advancedPlayer.positionHandler = (p) => setState(() {
          _position = p;
        });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  Widget slider() {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<Duration>(
      stream: _globalBloc.musicPlayerBloc.position,
      builder: (context, snapshot){
        return Slider(
        value: snapshot.data.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            _globalBloc.musicPlayerBloc.seekToSecond(value.toInt());
            value = value;
          });
        });
      }
    );
    
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<String>(
        stream: _globalBloc.musicPlayerBloc.song,
        builder: (context, snapshot) {
          return Container(
            color: Colors.black87,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Expanded(
                    flex: 1,
                    child: Container(
                      height: 70,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("${snapshot.data}", style: TextStyle(color: Colors.white),),
                          //slider()
                        ],
                      ),
                    )),
                Expanded(
                    flex: 0,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0, 20.0, 20.0),
                        child: StreamBuilder<PlayerState>(
                          stream: _globalBloc.musicPlayerBloc.playerState,
                          builder: (context, lol) {
                            return IconButton(
                                icon: lol.data==PlayerState.playing
                                    ? Icon(
                                        Icons.pause_circle_outline,
                                        size: 50.0,
                                        color: Colors.white
                                      )
                                    : Icon(
                                        Icons.play_circle_outline,
                                        size: 50.0,
                                        color: Colors.white
                                      ),
                                onPressed: (() {
                                  setState(() {
                                    if (lol.data == PlayerState.paused) {
                                      _globalBloc.musicPlayerBloc
                                          .resumeMusic();
                                      _globalBloc.musicPlayerBloc
                                          .updatePlayerState(PlayerState.playing);
                                    } else {
                                      _globalBloc.musicPlayerBloc.pauseMusic();
                                      _globalBloc.musicPlayerBloc
                                          .updatePlayerState(PlayerState.paused);
                                    }
                                  });
                                }));
                          }
                        )))
              ],
            ),
          );
        });
  }
}
