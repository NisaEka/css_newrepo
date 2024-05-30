import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/material.dart';
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
      margin: const EdgeInsets.only(top: 50),
      height: 50,
      color: Colors.transparent,
      child: Column(
        children: [
          Image.asset(
            ImageConstant.logoJNE,
            height: 30,
            color: CustomTheme().logoColor(context),
          ),
          Text('v $version')
        ],
      ),
    );
  }
}
