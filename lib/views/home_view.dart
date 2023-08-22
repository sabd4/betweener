import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/controllers/link_controller.dart';
import 'package:tt9_betweener_challenge/controllers/user_controller.dart';
import 'package:tt9_betweener_challenge/views/search_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_add_link.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_link_card.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeView extends StatefulWidget {
  static const id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;
  bool search = false;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SearchView.id);
                },
                child: const Icon(Icons.search_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(Icons.document_scanner_outlined)
            ],
          ),
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'Hello, ${snapshot.data?.user?.name}!',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                );
              }
              return Text('loading');
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Stack(children: [
              Image.asset('assets/imgs/qr_code.png'),
            ]),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.all(8),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final link = snapshot.data?[index].title;
                                return CustomLinkCard(link: link);
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                              itemCount: snapshot.data!.length),
                        ),
                        CustomAddLink(),
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
        ],
      ),
    );
  }
}
