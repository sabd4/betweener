import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/user_image.dart';

import '../../constants.dart';

class FollowingCard extends StatelessWidget {
  const FollowingCard({
    super.key,
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: kLightPrimaryColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            // leading: const UserImage(),
            title: Text(
              name!,
              style: spacingText,
            ),
            subtitle: Text(email!),
          ),
        ],
      ),
    );
  }
}
