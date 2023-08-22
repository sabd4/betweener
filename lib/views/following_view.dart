import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/update_profile.dart';
import 'package:tt9_betweener_challenge/views/widgets/following_card.dart';
import 'package:tt9_betweener_challenge/views/widgets/user_image.dart';
import '../constants.dart';
import '../controllers/follow_controller.dart';
import '../controllers/user_controller.dart';

class FollowingView extends StatefulWidget {
  static const String id = '/followingView';
  @override
  State<FollowingView> createState() => _FollowingViewState();
}

class _FollowingViewState extends State<FollowingView> {
  late Future<List<UserClass>> following;
  String? name = '';
  String? email = '';
  @override
  void initState() {
    following = getFollowing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Following'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder(
            future: following,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 800,
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
                              return GestureDetector(
                                  onTap: () {},
                                  child:
                                      FollowingCard(name: name, email: email));
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
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
              return spinkit;
            },
          ),
        ),
      ),
    );
  }
}
