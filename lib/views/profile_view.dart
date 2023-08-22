import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tt9_betweener_challenge/controllers/follow_controller.dart';
import 'package:tt9_betweener_challenge/views/followers_view.dart';
import 'package:tt9_betweener_challenge/views/following_view.dart';
import 'package:tt9_betweener_challenge/views/update_profile.dart';
import 'package:tt9_betweener_challenge/views/update_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/user_image.dart';

import '../constants.dart';
import '../controllers/delete_link_controller.dart';
import '../controllers/link_controller.dart';
import '../controllers/user_controller.dart';
import '../models/link.dart';
import '../models/user.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<User> user;
  late Future<List<Link>> links;

  late Future<List<UserClass>> following;
  late Future<List<UserClass>> followers;

  int count = 0;
  String? name;
  String? email;
  late Color color;
  late Color fontColor;

  linkDelete(int linkId) {
    setState(() {
      deleteLink(linkId);
    });
  }

  void updateUi() {
    setState(() {
      user = getLocalUser();
      links = getLinks(context);
      following = getFollowing();
      followers = getFollowers();
    });
  }

  @override
  void initState() {
    updateUi();

    name = '';
    email = '';
    color = kLightDangerColor;
    fontColor = kOnLightDangerColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Profile ',
          style: TextStyle(
              color: kPrimaryColor, fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.all(
            24.0,
          ),
          child: Card(
            color: kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Column(
                    children: [
                      UserImage(),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateProfileView(
                                      name: '',
                                      email: '',
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                FutureBuilder(
                                  future: user,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      name = snapshot.data?.user?.name;
                                      email = snapshot.data?.user?.email;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text('$name',
                                                style: profileText),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              '$email',
                                              style: profileText,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              '00970000000000',
                                              style: profileText,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, FollowerView.id);
                                                },
                                                child: Card(
                                                  color: kSecondaryColor,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: FutureBuilder(
                                                      future: followers,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Center(
                                                              child: Text(
                                                                  'Followers ${snapshot.data!.length}'));
                                                        }
                                                        if (snapshot.hasError) {
                                                          return Text(snapshot
                                                              .error
                                                              .toString());
                                                        }
                                                        return const SizedBox(
                                                          width: 80,
                                                          height: 20,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      FollowingView.id);
                                                },
                                                child: Card(
                                                  color: kSecondaryColor,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child: FutureBuilder(
                                                      future: following,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Center(
                                                              child: Text(
                                                                  'Following ${snapshot.data!.length}'));
                                                        }
                                                        if (snapshot.hasError) {
                                                          return Text(snapshot
                                                              .error
                                                              .toString());
                                                        }
                                                        return const SizedBox(
                                                          width: 80,
                                                          height: 20,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                    return spinkit;
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder(
            future: links,
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
                              final link = snapshot.data?[index].title;
                              final linkId = snapshot.data?[index].id;
                              final linklINK = snapshot.data?[index].link;
                              return Slidable(
                                startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: ScrollMotion(),
                                  // All actions are defined in the children parameter.
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: (context) {
                                        linkDelete(linkId!);
                                        updateUi();
                                        // Phoenix.rebirth(context);
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      backgroundColor: kDangerColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateLinkView(
                                              linkId: linkId,
                                              title: link!,
                                              link: linklINK!,
                                            ),
                                          ),
                                        );
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      backgroundColor: kSecondaryColor,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: index % 2 == 0
                                          ? color = kLightDangerColor
                                          : kLightPrimaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '$link',
                                        style: TextStyle(
                                          letterSpacing: 3.0,
                                          color: index % 2 == 0
                                              ? fontColor = kOnLightDangerColor
                                              : kPrimaryColor,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data?[index].link}',
                                        style: TextStyle(
                                          color: index % 2 == 1
                                              ? fontColor = kLinksColor
                                              : kOnLightDangerFontColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
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
        )
      ],
    );
  }
}
