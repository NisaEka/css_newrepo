import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Multiplesearchfield extends StatelessWidget {
  const Multiplesearchfield({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return Scaffold(
      appBar: CustomTopBar(
        title: 'Lacak Kiriman'.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: Get.height * 0.65,
          child: TextField(
            controller: search,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: " Masukan List Nomor resi disini...",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFilledButton(
        color: primaryColor(context),
        title: "Submit",
        margin: const EdgeInsets.all(16),
        onPressed: () => Get.back(result: search.text),
      ),
    );
  }
}
