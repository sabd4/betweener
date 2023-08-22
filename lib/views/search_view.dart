import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/search_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/new_link_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/following_card.dart';

import '../constants.dart';
import '../controllers/add_follow_controller.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'main_app_view.dart';

class SearchView extends StatefulWidget {
  static const id = '/searchView';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late Future<User> user;
  late Future<User> local;
  late int localId;

  late Future<Link> follow;
  late Future<List<UserClass>> searchResult;
  final TextEditingController searchController =
      TextEditingController(); // Initialize the TextEditingController
  addFollowUser(int id) {
    final body = {'followee_id': id};
    addFollow(body).then((user) async {
      if (mounted) {
        Navigator.pushNamed(context, MainAppView.id);
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  void initState() {
    user = getLocalUser();
    local = getLocalUser();

    searchResult = Future.value([]); // Initialize with an empty list
    super.initState();
  }

  //trigger search based on user input
  void performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        // Show empty list if the search query is empty
        searchResult = Future.value([]);
      } else {
        // Call searchUsers function with the search query
        searchResult = searchUsers(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLightPrimaryColor,
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Search input field
            TextFormField(
              controller: searchController,
              onChanged: performSearch, // Call search on user input change
              decoration: InputDecoration(
                labelText: 'Search users',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(50), // Set the circular radius
                ),
                prefixIcon: Icon(Icons.search), // Add the search icon
              ),
            ),
            // Display search results using ListView.builder
            Expanded(
              child: FutureBuilder<List<UserClass>>(
                future: searchResult,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 50,
                      width: 50,
                      child: spinkit,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<UserClass> users =
                        snapshot.data ?? []; // Handle null case
                    if (users.isEmpty) {
                      return Text('');
                    }

                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        UserClass user = users[index];
                        // Build the UI for each user in the list
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              FollowingCard(
                                  name: '${user.name ?? 'No Name'}',
                                  email: '${user.email ?? 'No Email'}'),
                              Opacity(
                                opacity: user == local ? 0 : 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        int id = user.id!;
                                        addFollowUser(id);
                                      });
                                    },
                                    child: Text('Follow'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
