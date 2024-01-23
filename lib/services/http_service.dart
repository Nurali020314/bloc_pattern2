import 'dart:convert';

import 'package:http/http.dart';
import '../model/post_model.dart';
import 'log_service.dart';


class Network {
  static String BASE = "jsonplaceholder.typicode.com";

  static Map<String, String> headers = {
    "Content-Type": "aplication/json ; charset=UTF-8"
  };

  /* Http Api */

  static String API_LIST = "/posts";
  static String API_CREAT = "/posts";
  static String API_UPDATE = "/posts/"; //{id}
  static String API_DELATE = "/posts/"; //{id}

  /* Http Request */

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    LogService.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    LogService.d(response.body);
    LogService.d(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    LogService.d(response.body);
    LogService.d(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELATE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await delete(uri, headers: headers);
    LogService.d(response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post) {
    Map<String, String> params = Map();
    params.addAll({
      "title": post.title!,
      "body": post.body!,
      "userId": post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String, String> params = Map();
    params.addAll({
      "id": post.id.toString(),
      "title": post.title!,
      "body": post.body!,
      "userId": post.userId.toString(),
    });
    return params;
  }

   /* Http Parsing */

  static List<Post> parsePostList(String response){
    dynamic json =jsonDecode(response);
    var data=List<Post>.from(json.map((x)=>Post.fromJson(x)));
    return data;
  }

  static Post parsePost(String response) {
    dynamic json = jsonDecode(response);
    // Create a Post object from JSON map
    Post post = Post.fromJson(json);
    return post;
  }

}
