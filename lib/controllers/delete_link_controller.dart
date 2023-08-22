import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/user.dart';

Future<void> deleteLink(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  String url = linksUrl;
  final response = await http.delete(
    Uri.parse('$url/$id'),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    print('Link with ID $id deleted successfully');
  } else {
    throw Exception(
        'Failed to delete link. Status code: ${response.statusCode}');
  }
}
