import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'const.dart' as url;

class Categories {
  final String cat,id;

  Categories({this.cat, this.id});

  factory Categories.fromJson(Map<String, dynamic> jsonData) {
    return Categories(
      id: jsonData['id'],
      cat: jsonData['cat'],
    );
  }
}

Future<List<Categories>> downloadCatJSON() async {
  final jsonEndPoint = url.url+"getcat.php";

  final response = await get(jsonEndPoint);

  if (response.statusCode == 200) {
    List cat = json.decode(response.body);
    return cat.map((cat) => new Categories.fromJson(cat)).toList();
  } else {
    throw Exception('Error');
  }
}


class Pods {
  final String cat, pic, audio, username, title, id;

  Pods({this.cat, this.pic, this.audio, this.username, this.title, this.id});

  factory Pods.fromJson(Map<String, dynamic> jsonData) {
    return Pods(
      id: jsonData['id'],
      cat: jsonData['cat'],
      pic: url.url+"image/user/" + jsonData['pic'],
      audio: jsonData['audio'],
      username: jsonData['username'],
      title: jsonData['title']
    );
  }
}

Future<List<Pods>> downloadPodsJSON() async {
  final jsonEndPoint = url.url+"getpod.php";

  final response = await get(jsonEndPoint);

  if (response.statusCode == 200) {
    List<dynamic> pod = json.decode(response.body);
    return pod.map((pod) => new Pods.fromJson(pod)).toList();
  } else {
    throw Exception('Error');
  }
}

class PodCat {
  final String cat, pic, audio, username, title;

  PodCat({this.cat, this.pic, this.audio, this.username, this.title});

  factory PodCat.fromJson(Map<String, dynamic> jsonData) {
    return PodCat(
      cat: jsonData['cat'],
      pic: url.url+"image/user/" + jsonData['pic'],
      audio: jsonData['audio'],
      username: jsonData['username'],
      title: jsonData['title']
    );
  }
}

Future<List<PodCat>> downloadPodCatJSON(String cat) async {
  final jsonEndPoint = url.url+"getpodcat.php?cat="+cat;
  print(jsonEndPoint);

  final response = await get(jsonEndPoint);

  if (response.statusCode == 200) {
    List<dynamic> podCat = json.decode(response.body);
    return podCat.map((podCat) => new PodCat.fromJson(podCat)).toList();
  } else {
    throw Exception('Error');
  }
}

class Libs {
  final String cat, audio, title, view, id;

  Libs({this.cat, this.audio, this.title, this.view, this.id});

  factory Libs.fromJson(Map<String, dynamic> jsonData) {
    return Libs(
      id: jsonData['podid'],
      cat: jsonData['cat'],
      audio: jsonData['audio'],
      view: jsonData['click'],
      title: jsonData['title']
    );
  }
}

Future<List<Libs>> downloadLibsJSON(String username) async {
  final jsonEndPoint = url.url+"getlib.php?id="+username;

  final response = await get(jsonEndPoint);

  if (response.statusCode == 200) {
    List<dynamic> podCat = json.decode(response.body);
    return podCat.map((podCat) => new Libs.fromJson(podCat)).toList();
  } else {
    throw Exception('Error');
  }
}

class Users {
  final String birthdate, username, email, pic, pass;

  Users({this.birthdate, this.username,this.pass, this.email, this.pic});

  factory Users.fromJson(Map<String, dynamic> jsonData) {
    return Users(
      birthdate: jsonData['birthdate'],
      username: jsonData['username'],
      email: jsonData['email'],
      pass : jsonData['pass'],
      pic: jsonData['pic']
    );
  }
}

Future<List<Users>> downloadUserJSON(String username) async {
  final jsonEndPoint = url.url+"getuser.php?id="+username;
  final response = await get(jsonEndPoint);

  if (response.statusCode == 200) {
    List<dynamic> podUser = json.decode(response.body);
    return podUser.map((podUser) => new Users.fromJson(podUser)).toList();
  } else {
    throw Exception('Error');
  }
}

