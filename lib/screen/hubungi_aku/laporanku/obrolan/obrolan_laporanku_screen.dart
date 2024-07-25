import 'package:bubble/bubble.dart';
import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/laporanku/chat_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/obrolan/obrolal_laporanku_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObrolanLaporankuScreen extends StatelessWidget {
  const ObrolanLaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ObrolanLaporankuController>(
        init: ObrolanLaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Obrolan".tr,
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(ObrolanLaporankuController c, BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Text(
            DateTime.now().toString().toShortDateFormat(),
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Flexible(
          child: ListView(
            reverse: true,
            children: c.messsages
                .mapIndexed(
                  (index, e) => chat(e, context),
                )
                .toList().reversed.toList(),
          ),
          // child: ListView.builder(
          //   reverse: true,
          //   itemCount: c.messsages.length,
          //   itemBuilder: (e, index) => chat(
          //     e,
          //     index % 2 == 0 ? 0 : 1,
          //     context,
          //   ),
          // ),
        ),
        ListTile(
          title: TextFormField(
            controller: c.messageInsert,
            autofocus: true,
            decoration: InputDecoration(
                hintText: "Tulis Pesan".tr,
                hintStyle: hintTextStyle,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: greyColor)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: greyColor))),
            // style: const TextStyle(fontSize: 16, color: Colors.black),
            onFieldSubmitted: (value) => c.sendMessage(),
          ),
          trailing: GestureDetector(
            onTap: () {
              if (c.messageInsert.text.isEmpty) {
              } else {
               c.sendMessage();
              }
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(50)),
              padding: const EdgeInsets.only(left: 5),
              child: const Center(
                child: Icon(
                  Icons.send_rounded,
                  size: 30.0,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chat(ChatModel msg, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: msg.data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          msg.data == 0 ? avatar("Developer", context) : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: msg.data == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Bubble(
                  radius: const Radius.circular(8),
                  color: msg.data == 0 ? blueJNE : redJNE,
                  elevation: 0.0,
                  showNip: true,
                  nip: msg.data == 0 ? BubbleNip.leftBottom : BubbleNip.rightBottom,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            msg.message ?? '',
                            style: listTitleTextStyle.copyWith(color: whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  '17.00',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
          msg.data == 1 ? avatar("Customer", context) : Container(),
        ],
      ),
    );
  }

  Widget avatar(String name, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 55,
          width: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: greyLightColor3, borderRadius: BorderRadius.circular(50)),
          child: Text(
            name.split(" ").first.substring(0, 1).toUpperCase(),
            style: listTitleTextStyle,
          ),
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
