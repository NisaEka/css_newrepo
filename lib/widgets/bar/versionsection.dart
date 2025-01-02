import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionApp extends StatefulWidget {
  const VersionApp({super.key});

  @override
  State<VersionApp> createState() => _VersionAppState();
}

class _VersionAppState extends State<VersionApp> {
  String? version;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width / 2,
      // padding: const EdgeInsets.all(15),
      // // color: Colors.green,
      // height: 60,
      // child: Stack(
      //   fit: StackFit.passthrough,
      width: Get.width,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 50, bottom: 10),
      height: 50,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            ImageConstant.logoJNE,
            height: 30,
            color: CustomTheme().logoColor(context),
          ),
          // SizedBox(width: 10),
          // Positioned(
          SizedBox(
            // left: Get.width / 5,
            // bottom: 0,
            // top: 0,
            child: Text('v $version'),
          )
        ],
      ),
    );
  }
}
