import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomLinkCard extends StatelessWidget {
  const CustomLinkCard({
    super.key,
    required this.link,
  });

  final String? link;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: kLightSecondaryColor, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          '$link',
          style: TextStyle(color: kOnLightDangerColor),
        ),
      ),
    );
  }
}
