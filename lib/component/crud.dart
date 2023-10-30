import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Curd {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print('000000000Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error cache $e');
    }
  }

//**********************
  postRequest(String url, Map data) async {
    var response = await http.post(Uri.parse(url), body: data);
    print('${response.statusCode}');
    Map responsebody = jsonDecode(response.body);
    print(responsebody.values);
    return responsebody;
  }

  /// **************************

  postRequestFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartfile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(
        file.path,
      ),
    );
    request.files.add(multipartfile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error ${myrequest.statusCode}');
    }
  }
}
