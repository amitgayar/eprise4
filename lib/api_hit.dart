
import 'dart:convert';
import 'package:http/http.dart';

  const String apiUrl = "https://catfact.ninja/fact";

  Future getData() async {
    Response res = await get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

