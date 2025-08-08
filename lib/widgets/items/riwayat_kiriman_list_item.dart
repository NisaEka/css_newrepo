import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class RiwayatKirimanListItem extends StatelessWidget {
  final String? tanggalEntry;
  final String? service;
  final String? noResi;
  final String? apiType;
  final String? penerima;
  final String? status;
  final String? orderID;
  final TransactionModel? data;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final int? index;
  final void Function(BuildContext)? onDelete;
  final bool isLoading;
  final bool isDelete;

  const RiwayatKirimanListItem({
    super.key,
    this.tanggalEntry,
    this.service,
    this.noResi,
    this.apiType,
    this.penerima,
    this.status,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.orderID,
    this.index,
    this.onDelete,
    this.isLoading = false,
    this.data,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index ?? 0),
      startActionPane: isDelete
          ? ActionPane(
              dragDismissible: false,
              motion: const DrawerMotion(),
              children: [
                isDelete
                    ? SlidableAction(
                        onPressed: onDelete,
                        foregroundColor: errorColor,
                        icon: Icons.delete,
                        label: 'Hapus'.tr,
                        borderRadius: BorderRadius.circular(8),
                      )
                    : const SizedBox(),
              ],
            )
          : null,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? secondaryColor(context) : greyDarkColor1,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Shimmer(
            isLoading: isLoading,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: isLoading ? greyLightColor3 : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                      width: isLoading ? Get.width / 5 : null,
                      child: Text(
                        data?.createdDateSearch?.toLongDateTimeFormat() ?? tanggalEntry?.toLongDateTimeFormat() ?? '-',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: primaryColor(context),
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(color: isLoading ? greyLightColor3 : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                          child: Image.asset(
                            fit: BoxFit.contain,
                            data?.statusAwb == "MASIH DI KAMU" || apiType == "MASIH DI KAMU"
                                ? ImageConstant.boxPackage
                                : data?.statusAwb == "SUDAH DI JEMPUT" || apiType == "SUDAH DI JEMPUT"
                                    ? ImageConstant.boxSudahDiJemput
                                    : data?.statusAwb == "DALAM PERJALANAN" ||
                                            apiType == "DALAM PERJALANAN" ||
                                            data?.statusAwb == "SUDAH DI GUDANG JNE" ||
                                            apiType == "SUDAH DI GUDANG JNE"
                                        ? ImageConstant.boxSudahDiGudang
                                        : data?.statusAwb == "SUKSES DITERIMA" || apiType == "SUKSES DITERIMA"
                                            ? ImageConstant.boxSuksesDiterima
                                            : data?.statusAwb == "DIBATALKAN OLEH KAMU" || apiType == "DIBATALKAN OLEH KAMU"
                                                ? ImageConstant.boxDibatalkan
                                                : data?.statusAwb == "SUDAH DI KOTA TUJUAN" || apiType == "SUDAH DI KOTA TUJUAN"
                                                    ? ImageConstant.boxSudahDiKotaTujuan
                                                    : data?.statusAwb == "DALAM PROSES" || apiType == "DALAM PROSES"
                                                        ? ImageConstant.boxDalamProses
                                                        : data?.statusAwb == "BUTUH DICEK" || apiType == "BUTUH DICEK"
                                                            ? ImageConstant.boxButuhDicek
                                                            : data?.statusAwb == "SUKSES DIKEMBALIKAN KEKAMU" ||
                                                                    apiType == "SUKSES DIKEMBALIKAN KEKAMU"
                                                                ? ImageConstant.boxSuksesReturn
                                                                : data?.statusAwb == "PROSES PENGEMBALIAN KEKAMU" ||
                                                                        apiType == "PROSES PENGEMBALIAN KEKAMU"
                                                                    ? ImageConstant.boxProsesReturn
                                                                    : data?.statusAwb == "DALAM PENINJAUAN" || apiType == "DALAM PENINJAUAN"
                                                                        ? ImageConstant.boxDalamPeninjauan
                                                                        : ImageConstant.boxPackage,
                            height: Get.width / 8,
                            color: iconColor(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (data?.apiType?.isNotEmpty ?? false)
                                ? Container(
                                    padding: const EdgeInsets.all(5),
                                    width: isLoading ? 50 : null,
                                    decoration: BoxDecoration(
                                      color: data?.apiType == "COD" || apiType == "COD"
                                          ? successDarkColor
                                          : data?.apiType == "NON COD" || apiType == "NON COD"
                                              ? infoDarkColor
                                              : data?.codFlag == "COD ONGKIR" || apiType == "COD ONGKIR"
                                                  ? warningDarkColor
                                                  : errorDarkColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      data?.codFlag == 'YES' && data?.codOngkir == 'YES' ? 'COD ONGKIR' : data?.apiType ?? apiType ?? '-',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: whiteColor,
                                            fontSize: 10,
                                          ),
                                    ),
                                  )
                                : const SizedBox(),
                            data?.apiType?.isNotEmpty ?? false ? const SizedBox(width: 5) : const SizedBox(width: 0),
                            Column(
                              children: [
                                (data?.statusAwb?.isNotEmpty ?? false)
                                    ? Container(
                                        padding: const EdgeInsets.all(6),
                                        width: isLoading ? Get.width / 5 : null,
                                        decoration: BoxDecoration(
                                          color: data?.statusAwb == "MASIH DI KAMU" ||
                                                  apiType == "MASIH DI KAMU" ||
                                                  data?.statusAwb == "PROSES PENGEMBALIAN KEKAMU" ||
                                                  apiType == "PROSES PENGEMBALIAN KEKAMU" ||
                                                  data?.statusAwb == "BELUM TERKUMPUL DARI PEMBELI" ||
                                                  apiType == "BELUM TERKUMPUL DARI PEMBELI" ||
                                                  data?.statusAwb == "BUTUH DICEK" ||
                                                  apiType == "BUTUH DICEK"
                                              ? warningColor
                                              : data?.statusAwb == "SUDAH DI JEMPUT" ||
                                                      apiType == "SUDAH DI JEMPUT" ||
                                                      data?.statusAwb == "DALAM PERJALANAN" ||
                                                      apiType == "DALAM PERJALANAN" ||
                                                      data?.statusAwb == "SUDAH DI GUDANG JNE" ||
                                                      apiType == "SUDAH DI GUDANG JNE" ||
                                                      data?.statusAwb == "SUDAH DI KOTA TUJUAN" ||
                                                      apiType == "SUDAH DI KOTA TUJUAN" ||
                                                      data?.statusAwb == "DALAM PROSES" ||
                                                      apiType == "DALAM PROSES"
                                                  ? infoColor
                                                  : data?.statusAwb == "Success" ||
                                                          apiType == "Success" ||
                                                          data?.statusAwb == "SUKSES DIKEMBALIKAN KEKAMU" ||
                                                          apiType == "SUKSES DIKEMBALIKAN KEKAMU" ||
                                                          data?.statusAwb == "SUKSES DITERIMA" ||
                                                          apiType == "SUKSES DITERIMA"
                                                      ? successColor
                                                      : data?.statusAwb == "DIBATALKAN OLEH KAMU" ||
                                                              apiType == "DIBATALKAN OLEH KAMU" ||
                                                              data?.statusAwb == "DALAM PENINJAUAN" ||
                                                              apiType == "DALAM PENINJAUAN"
                                                          ? errorColor
                                                          : errorDarkColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          data?.statusAwb?.capitalize?.tr.toUpperCase() ?? status?.capitalize?.tr.toUpperCase() ?? '',
                                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                color: whiteColor,
                                                fontSize: 8,
                                              ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(color: isLoading ? greyLightColor3 : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                          width: isLoading ? Get.width / 3 : null,
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            data?.awb ?? noResi ?? '-',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: primaryColor(context),
                                ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: isLoading ? greyLightColor3 : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                          width: isLoading ? Get.width / 5 : null,
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(data?.receiverName ?? penerima ?? '-', style: Theme.of(context).textTheme.titleSmall),
                        ),
                        Container(
                          decoration: BoxDecoration(color: isLoading ? greyLightColor3 : Colors.transparent, borderRadius: BorderRadius.circular(5)),
                          width: isLoading ? Get.width / 10 : null,
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Text(data?.serviceCode ?? service ?? '-', style: Theme.of(context).textTheme.titleSmall),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
