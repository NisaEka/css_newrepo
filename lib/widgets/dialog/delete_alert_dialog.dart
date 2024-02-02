import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAlertDialog extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onBack;

  const DeleteAlertDialog({
    super.key,
    required this.onDelete,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: const Text('Data akan dihapus '),
      content: const Text(
        'Anda yakin menghapus data ini ? ',
      ),
      actions: <Widget>[
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: onBack,
            child: Text('Tidak'.tr)),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: onDelete,
          child: Text('Hapus'.tr),
        ),
      ],
    );
  }
}
