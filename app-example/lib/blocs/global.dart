import 'music.dart';

class GlobalBloc{
  MusicPlayerBloc _musicPlayerBloc;
  MusicPlayerBloc get musicPlayerBloc => _musicPlayerBloc;

  GlobalBloc(){
    _musicPlayerBloc = MusicPlayerBloc();
  }

  void dispose(){
    _musicPlayerBloc.dispose();
  }
}