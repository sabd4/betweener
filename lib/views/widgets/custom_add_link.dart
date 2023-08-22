import 'package:flutter/material.dart';

import '../../constants.dart';
import '../new_link_view.dart';

class CustomAddLink extends StatelessWidget {
  const CustomAddLink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: kLightPrimaryColor, borderRadius: BorderRadius.circular(15)),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, NewLinkView.id);
          },
          child: const Column(
            children: [
              Icon(
                Icons.add,
                color: kPrimaryColor,
              ),
              Text(
                'Add Link',
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
