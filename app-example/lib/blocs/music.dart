import '../models/playerstate.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/update.dart';
import '../services/const.dart' as url;


typedef void OnError(Exception exception);


class MusicPlayerBloc {
  BehaviorSubject<String> _song;
  BehaviorSubject<PlayerState> _playerState$;
  BehaviorSubject<Duration> _position;
  BehaviorSubject<List<String>> _favorites$;
  BehaviorSubject<bool> _isAudioPlaying;
  AudioPlayer _audioPlayer = AudioPlayer();

  BehaviorSubject<String> get song => _song;
  BehaviorSubject<PlayerState> get playerState => _playerState$;
  BehaviorSubject<Duration> get position => _position;
  BehaviorSubject<List<String>> get favorites => _favorites$;

  String songBefore="";
  String username="";
  String password="";

  MusicPlayerBloc(){
    _initStreams();
    _song.add("");
    getSharedPrefs();
  }


  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("username");
    String pass = prefs.getString("password");
    if(name!=null&&pass!=null){
      username=name;
      password=pass;
    }
    print(pass);
  }

  void playMusic(String song, String title, String cat, String user){
    _audioPlayer.play(url.url+"audio/"+song);
    updatePlayerState(PlayerState.playing);
    print(username);
    print("user"+user);
    _song.add(title);
    if(song!=songBefore&&username!=user){
      upClicksSong(song);
      upCat(cat);
      songBefore = song;
    }
    print(songBefore);
    print(song);
  }

  void pauseMusic(){
    _audioPlayer.pause();
    updatePlayerState(PlayerState.paused);
  }

  void stopMusic(){
    _audioPlayer.stop();
    updatePlayerState(PlayerState.stopped);
  }

  void resumeMusic(){
    _audioPlayer.resume();
    updatePlayerState(PlayerState.playing);
  }

  void updatePlayerState(PlayerState state){
    _playerState$.add(state);
  }

  void updatePosition(Duration duration){
    _position.add(duration);
  }

  void addToFavorites(String song)async{
    List<String> _favorites = _favorites$.value;
    _favorites.add(song);
    _favorites$.add(_favorites);
    await saveFavorites();
  }

  void removeFromFavorites(String song)async{
    List<String> _favorites = _favorites$.value;
    _favorites.remove(song);
    _favorites$.add(_favorites);
    await saveFavorites();
  }

  Future<void> saveFavorites() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final List<String> _favorites = _favorites$.value;
    _prefs.setStringList("favorites", _favorites);
  }

  void retrieveFavorites() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> _savedStrings = _prefs.getStringList("favorites");
    List<String> _favorites = _savedStrings;
    _favorites$.add(_favorites);
  }

  void _initStreams(){
    _isAudioPlaying = BehaviorSubject<bool>.seeded(false);
    _song = BehaviorSubject<String>();
    _position = BehaviorSubject<Duration>();
    _playerState$ = BehaviorSubject<PlayerState>.seeded(PlayerState.stopped);
    _favorites$ = BehaviorSubject<List<String>>.seeded([]);
  }

    void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    _audioPlayer.seek(newDuration);
  }

  void dispose(){
    stopMusic();
    _isAudioPlaying.close();
    _favorites$.close();
    _playerState$.close();
    _position.close();
    _song.close();
  }
}