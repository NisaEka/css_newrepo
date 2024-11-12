import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionAccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback onTap;

  const TransactionAccountCard({
    super.key,
    required this.account,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            // alignment: Alignment.topRight,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: redJNE,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(12))),
            child: Text(account.accountService ?? '',
                style: listTitleTextStyle.copyWith(color: whiteColor)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: AccountListItem(
              data: account,
              isSelected: true,
              width: Get.width,
              onTap: onTap,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: CustomFormLabel(label: 'Services'.tr),
          ),
          const SizedBox(height: 10),
          // controller.state.isServiceLoad
          //     ? const Center(
          //         child: Text('Loading services...'),
          //       )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}
