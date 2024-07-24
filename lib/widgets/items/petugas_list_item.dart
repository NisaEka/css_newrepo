import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class PetugasListItem extends StatelessWidget {
  final int index;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget icon;
  final void Function(BuildContext)? onDelete;
  final bool isLoading;

  const PetugasListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.icon,
    required this.index,
    this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor),
        ),
        child: Shimmer(
          isLoading: isLoading,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: isLoading ? const Icon(Icons.shield) : icon,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: isLoading ? greyLightColor2 : Colors.transparent,
                    width: isLoading ? 100 : null,
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  isLoading
                      ? Column(
                          children: [
                            Container(
                              color: isLoading ? greyLightColor2 : Colors.transparent,
                              width: isLoading ? 150 : null,
                              height: 10,
                              margin: const EdgeInsets.only(bottom: 2),
                            ),
                            Container(
                              color: isLoading ? greyLightColor2 : Colors.transparent,
                              width: isLoading ? 150 : null,
                              height: 10,
                              margin: const EdgeInsets.only(bottom: 2),
                            ),
                            Container(
                              color: isLoading ? greyLightColor2 : Colors.transparent,
                              width: isLoading ? 150 : null,
                              height: 10,
                              margin: const EdgeInsets.only(bottom: 2),
                            ),
                          ],
                        )
                      : Text(
                          subtitle ?? '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
