import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<List<UserClass>> getFollowing() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print(jsonDecode(response.body)['following']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['following'] as List<dynamic>;

    List<UserClass> followingList =
        data.map((e) => UserClass.fromJson(e)).cast<UserClass>().toList();
    return followingList;
  }

  return Future.error('Something wrong');
}

Future<List<UserClass>> getFollowers() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print(jsonDecode(response.body)['followers']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['followers'] as List<dynamic>;

    List<UserClass> followerList =
        data.map((e) => UserClass.fromJson(e)).cast<UserClass>().toList();
    return followerList;
  }

  return Future.error('Something wrong');
}
