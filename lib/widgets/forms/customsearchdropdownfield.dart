import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSearchDropdownField extends StatefulWidget {
  final List<DropdownMenuItem>? items;

  CustomSearchDropdownField({
    super.key,
    this.items,
  });

  @override
  State<CustomSearchDropdownField> createState() => _CustomSearchDropdownFieldState();
}

class _CustomSearchDropdownFieldState extends State<CustomSearchDropdownField> {
  // const List<Widget> list = [Text('One'), Text('Two'), Text('Three'), Text('Four')];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      child: DropdownButtonFormField(
        items: widget.items,
        onChanged: (value) {},
        menuMaxHeight: 200,
      ),
    );
  }
}
