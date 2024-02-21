import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/value_item.dart';
import 'package:flutter/material.dart';

class ReportListItem extends StatelessWidget {
  final String? status;

  const ReportListItem({
    super.key,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          child: status != null
              ? Container(
                  padding: const EdgeInsets.only(top: 5, right: 5, left: 20, bottom: 2),
                  decoration: const BoxDecoration(
                      color: successLightColor2,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(20),
                      )),
                  child: Text(
                    status ?? '',
                    style: listTitleTextStyle.copyWith(color: whiteColor),
                  ),
                )
              : const SizedBox(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyDarkColor1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: blueJNE, width: 2),
                    ),
                    child: const Icon(
                      Icons.playlist_add_check_rounded,
                      color: blueJNE,
                      size: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "04-01-2024 19:37:17",
                        style: sublistTitleTextStyle,
                      ),
                      Text(
                        "# JNEPWD2400000662",
                        style: listTitleTextStyle.copyWith(color: blueJNE),
                      ),
                    ],
                  )
                ],
              ),
              const Divider(thickness: 0.5),
              const ValueItem(
                title: "CUST GROUP",
                value: "BDOCODCCNC",
              ),
              const ValueItem(
                title: "CUST ID",
                value: "80563321",
              ),
              const ValueItem(
                title: "CUST NAME",
                value: "SETIAP HARI DIPAKAI PT / EVERPRO COD DROP OFF OKE",
              ),
              const Divider(thickness: 0.5),
              const ValueItem(
                title: "COD AMOUNT",
                value: "RP. 5.016.000",
              ),
              const ValueItem(
                title: "COD FEE ( ONGKIR DLL )",
                value: "RP. 799.044",
                valueFontColor: errorColor,
              ),
              const ValueItem(
                title: "NET AMOUNT",
                value: "RP. 4.216.956",
              ),
              const Divider(thickness: 0.5),
              ValueItem(
                title: "PAID AMOUNT",
                value: "RP. 4.216.956",
                titleTextStyle: listTitleTextStyle.copyWith(fontSize: 8),
                valueFontColor: successColor,
              ),
              ValueItem(
                title: "PAID DATE",
                value: "04-01-2024",
                valueTextStyle: sublistTitleTextStyle.copyWith(fontSize: 8),
              ),
              ValueItem(
                title: "PAID REFF NO",
                value: "ST240104202642154374802",
                valueTextStyle: sublistTitleTextStyle.copyWith(fontSize: 8),
              ),
              ValueItem(
                title: "REMARKS",
                value: "JNE CNCWDR BDO80563321 SLA 04-JAN-24",
                valueTextStyle: sublistTitleTextStyle.copyWith(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
