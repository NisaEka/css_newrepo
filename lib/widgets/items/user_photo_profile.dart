import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';

class UserPhotoProfile extends StatelessWidget {
  final String? img;

  const UserPhotoProfile({super.key, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // border: Border.all(color: primaryColor(context)),
          color: Colors.white60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            img ?? ImageConstant.userPic,
            height: 50,
          ),
        ],
      ),
    );
  }
}
