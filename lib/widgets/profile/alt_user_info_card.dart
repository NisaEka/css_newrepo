import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AltUserInfoCard extends StatelessWidget {
  final String name;
  final String brand;
  final String mail;
  final String type;
  final bool isLoading;

  const AltUserInfoCard({
    super.key,
    required this.name,
    required this.brand,
    required this.mail,
    required this.type,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: isLoading ? const EdgeInsets.all(2) : null,
            height: isLoading ? 20 : null,
            width: isLoading ? 100 : null,
            decoration: BoxDecoration(
                color: isLoading ? greyColor : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 16),
            ),
          ),
          Container(
              margin: isLoading ? const EdgeInsets.all(2) : null,
              height: isLoading ? 15 : null,
              width: isLoading ? 100 : null,
              decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child:
                  Text(brand, style: Theme.of(context).textTheme.titleSmall)),
          Container(
              margin: isLoading ? const EdgeInsets.all(2) : null,
              height: isLoading ? 15 : null,
              width: isLoading ? 100 : null,
              decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(mail, style: Theme.of(context).textTheme.titleSmall)),
          Container(
            margin: isLoading ? const EdgeInsets.all(2) : null,
            height: isLoading ? 10 : null,
            width: isLoading ? 70 : null,
            decoration: BoxDecoration(
                color: isLoading ? greyColor : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              type.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
