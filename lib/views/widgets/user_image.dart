import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/imgs/img.png'),
      radius: 50,
    );
  }
}
