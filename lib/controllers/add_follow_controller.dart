import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

import '../models/link.dart';

Future<UserClass> addFollow(Map<String, int> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(
    Uri.parse(followUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: body,
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    print('add following success');
    return UserClass.fromJson(data);
  }

  return Future.error('Somthing wrong');
}
