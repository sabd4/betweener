import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

import '../models/link.dart';

Future<Link> updateLink(Map<String, String> body, int id) async {
  String url = linksUrl;

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.put(
    Uri.parse('$url/$id'),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: body,
  );
  print('Request URL: ${Uri.parse('$url/$id')}');
  print('Request Headers: ${{'Authorization': 'Bearer ${user.token}'}}');
  print('Request Body: ${jsonEncode(body)}');
  print('Response Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['link'];
    print(data);
    return Link.fromJson(data);
  } else {
    final errorMessage = 'Failed to update link.';
    throw Exception(errorMessage);
  }
}
