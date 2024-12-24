import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/widgets/items/user_photo_profile.dart';
import 'package:css_mobile/widgets/profile/alt_user_info_card.dart';
import 'package:flutter/material.dart';

class ProfileUserInfo extends StatelessWidget {
  final UserModel? basicProfile;

  const ProfileUserInfo({super.key, this.basicProfile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AltUserInfoCard(
          isLoading: basicProfile == null,
          name: basicProfile?.name ?? '-',
          brand: basicProfile?.brand ?? '-',
          mail: basicProfile?.email ?? '-',
          type: basicProfile?.userType ?? '-',
        ),
        const UserPhotoProfile()
      ],
    );
  }
}
