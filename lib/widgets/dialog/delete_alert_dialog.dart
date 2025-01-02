import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'default_alert_dialog.dart';

class DeleteAlertDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onBack;

  const DeleteAlertDialog({
    super.key,
    required this.onConfirm,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultAlertDialog(
      title: 'Data akan dihapus'.tr,
      subtitle: 'Anda yakin menghapus data ini ?'.tr,
      confirmButtonTitle: 'Hapus'.tr,
      backButtonTitle: 'Tidak'.tr,
      onConfirm: onConfirm,
      onBack: onBack,
    );
  }
}
