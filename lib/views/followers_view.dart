import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/update_profile.dart';
import 'package:tt9_betweener_challenge/views/widgets/following_card.dart';
import 'package:tt9_betweener_challenge/views/widgets/user_image.dart';
import '../constants.dart';
import '../controllers/follow_controller.dart';
import '../controllers/user_controller.dart';

class FollowerView extends StatefulWidget {
  static const String id = '/followersView';
  @override
  State<FollowerView> createState() => _FollowerViewState();
}

class _FollowerViewState extends State<FollowerView> {
  late Future<List<UserClass>> followers;
  String? name = '';
  String? email = '';
  @override
  void initState() {
    followers = getFollowers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder(
            future: followers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 400,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            padding: const EdgeInsets.all(12),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              name = snapshot.data?[index].name;
                              email = snapshot.data?[index].email;

                              print(name);
                              return FollowingCard(name: name, email: email);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: snapshot.data!.length),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(
                child: spinkit,
              );
            },
          ),
        ),
      ),
    );
  }
}
