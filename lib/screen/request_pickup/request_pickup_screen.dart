import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupScreen extends StatefulWidget {
  const RequestPickupScreen({ super.key });

  @override
  State<StatefulWidget> createState() => _RequestPickupScreenState();
}

class _RequestPickupScreenState extends State<RequestPickupScreen> {

  bool _checkMode = false;
  bool _checkAll = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
      init: RequestPickupController(),
      builder: (controller) {
        return Scaffold(
          appBar: _requestPickupAppBar(),
          body: _requestPickupBody(controller),
        );
      },
    );
  }

  PreferredSizeWidget _requestPickupAppBar() {
    return CustomTopBar(
      title: "Minta Dijemput".tr
    );
  }

  Widget _requestPickupBody(RequestPickupController controller) {
    if (controller.showLoadingIndicator) {
      return const Center(
        child: CircularProgressIndicator()
      );
    }

    if (controller.showEmptyContent) {
      return const Center(
        child: Text("Tidak ada data tersedia")
      );
    }

    if (controller.showErrorContent) {
      return Center(
        child: Column(
          children: [
            Text("Terjadi kesalahan ketika mengambil data"),
            Padding(padding: EdgeInsets.only(top: 16)),
            FilledButton(onPressed: () => controller.requireRetry(), child: Text("Muat ulang"))
          ],
        )
      );
    }

    if (controller.showMainContent) {
      return _mainContent(controller.requestPickups);
    }

    return Text("No Content");
  }

  Widget _mainContent(List<RequestPickupModel> requestPickups) {
    return Column(
      children: [
        _checkAllItemBox(),
        Expanded(child: ListView(
          children: requestPickups.map((requestPickup) {
            return RequestPickupItem(
              data: requestPickup,
              onTap: () {
                if (_checkMode) {
                  setState(() {
                    _checkMode = false;
                    _checkAll = false;
                  });
                }
              },
              onLongTap: () {
                setState(() {
                  _checkMode = true;
                });
              },
              checkMode: _checkMode,
            );
          }).toList(),
        ))
      ],
    );
  }

  Widget _checkAllItemBox() {
    if (_checkMode) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Checkbox(
              value: _checkAll,
              onChanged: (newValue) {
                setState(() {
                  _checkAll = newValue ?? _checkAll;
                });
              },
            ),
            Text(
              "Pilih Semua".tr,
              style: inputTextStyle,
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

}