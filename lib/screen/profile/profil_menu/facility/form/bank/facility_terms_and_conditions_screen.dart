import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class FacilityTermsAndConditionsScreen extends StatelessWidget {
  final String contentText;

  const FacilityTermsAndConditionsScreen(
      {super.key, required this.contentText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _termsAndConditionsAppBar(),
      body: _termsAndConditionsBody(),
      bottomNavigationBar: _termsAndConditionsBottomBar(),
    );
  }

  PreferredSizeWidget _termsAndConditionsAppBar() {
    return CustomTopBar(title: 'Syarat dan Ketentuan'.tr);
  }

  Widget _termsAndConditionsBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Html(data: contentText, style: {
            'ol': Style(
              margin: Margins(
                left: Margin.zero(),
              ),
              padding: HtmlPaddings(
                left: HtmlPadding(16),
              ),
            ),
          }),
        )
      ],
    );
  }

  Widget _termsAndConditionsBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomFilledButton(
        title: 'Tutup'.tr,
        onPressed: () => Get.back(),
        color: redJNE,
      ),
    );
  }
}
