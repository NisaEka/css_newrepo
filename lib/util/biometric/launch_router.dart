// lib/app/launch_router.dart
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/biometric/app_session.dart';
import 'package:css_mobile/util/biometric/locked_screen.dart';
import 'package:flutter/material.dart';

class LaunchRouter extends StatefulWidget {
  const LaunchRouter({super.key});
  @override
  State<LaunchRouter> createState() => _LaunchRouterState();
}

class _LaunchRouterState extends State<LaunchRouter> {
  final storage = StorageCore();
  Widget _target = const SizedBox();

  @override
  void initState() {
    super.initState();
    _decide();
  }

  Future<void> _decide() async {
    final token = await storage.readAccessToken();
    final isLogin = (token?.isNotEmpty ?? false);

    final flag = await storage.readString(StorageCore.biometricLock);
    final biometricOn = flag == '1';

    final alreadyChecked = AppSession.lockCheckedThisRun;

    setState(() {
      if (isLogin && biometricOn && !alreadyChecked) {
        _target = const LockedScreen();
      } else {
        _target = const DashboardScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _target is SizedBox
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : _target;
  }
}
