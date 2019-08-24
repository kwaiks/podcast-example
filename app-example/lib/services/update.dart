import 'package:http/http.dart' show get;
import 'const.dart' as url;


Future upClicksSong(String song) async{
  final jsonEndPoint = url.url+"upclicks.php?id="+song;

  final response = await get(jsonEndPoint);

  if (response.statusCode == 200) {
    print("Success");
  } else {
    throw Exception('Error');
  }
}

Future upCat(String cat)async{
  String catBefore = "";
  if(cat != catBefore){
    final jsonEndPoint = url.url+"upcat.php?id="+cat;

    final response = await get(jsonEndPoint);

    if (response.statusCode == 200) {
      print("Success");
    } else {
      throw Exception('Error');
    }
  }
}

Future delete(String id) async {
  final jsonEndPoint = url.url+"delete.php?id="+id;
  final response = await get(jsonEndPoint);
  print(jsonEndPoint);
  if (response.statusCode == 200){
    print("Success");
  }else {
    throw Exception('Error');
  }
}

/*Future upload(File file) async {
    Navigator.of(this.context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }));
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var uri = Uri.parse("http://172.20.10.14:8080/cetak/upload.php");

    var request = new http.MultipartRequest("POST", uri);

    var multiPartFile = new http.MultipartFile("berkas", stream, length,
        filename: widget.name+"_"+basename(file.path));
    try {
      request.fields['nama'] = nama;
      request.fields['email'] = email;
      request.fields['file'] = basename(file.path);
      request.fields['store'] = widget.name;
      request.fields['total'] = sumTot.toString();
      request.fields['hitam'] = prcBw.toString();
      request.fields['warna'] = prcCl.toString();
      if(jilVal == true){
        request.fields['jilid'] = "biru";
      }
      request.fields['status'] = "unpaid";
      request.files.add(multiPartFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Success");
      } else {
        throw Exception('Error');
      }
    } catch (Exception) {
      //Handle Exception
    } finally {
      Navigator.pushAndRemoveUntil(this.context, MaterialPageRoute(builder: (BuildContext context) => TransPage(email:email)), (Route<dynamic> route) => false);
    }
  }*/