import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

import 'package:http/http.dart' as http;

Future<List<UserClass>> searchUsers(String name) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(
    Uri.parse(searchUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: {'name': name},
  );

  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    final List<dynamic> userDataList = jsonDecode(response.body)['user'];
    // Convert the list of dynamic data to a list of UserClass objects
    List<UserClass> userList =
        userDataList.map((userData) => UserClass.fromJson(userData)).toList();

    // Filter the users based on the search query
    List<UserClass> filteredUsers = userList
        .where((user) => user.name != null && user.name!.contains(name))
        .toList();

    return filteredUsers;
  }
  throw Exception('Something wrong');
}
