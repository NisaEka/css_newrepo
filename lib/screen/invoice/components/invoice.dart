import 'dart:typed_data';

import 'package:css_mobile/const/image_const.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> generateInvoice(
    PdfPageFormat pageFormat, Invoice data) async {
  return await data.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.top,
    required this.dueDate,
    required this.period,
    required this.customerId,
    required this.customerName,
    required this.address,
    required this.phone,
    required this.email,
    required this.zipCode,
    required this.taxNumber,
    required this.npwpId,
    required this.npwpName,
    required this.npwpAddress,
    required this.description,
    required this.grossTotal,
    required this.discount,
    required this.totalAfterDiscount,
    required this.vat,
    required this.insurance,
    required this.stamp,
    required this.totalPaid,
  }) {
    address1 = address.isNotEmpty
        ? address.substring(
            0, address.length < chunkSize ? address.length : chunkSize)
        : '';
    address2 = address.length > chunkSize
        ? address.substring(chunkSize,
            address.length < (chunkSize * 2) ? address.length : chunkSize * 2)
        : '';
    address3 = address.length > (chunkSize * 2)
        ? address.substring(chunkSize * 2,
            address.length < (chunkSize * 3) ? address.length : chunkSize * 3)
        : '';
  }

  final String invoiceNumber;
  final String invoiceDate;
  final String top;
  final String dueDate;
  final String period;
  final String customerId;
  final String customerName;
  final String address;
  final String phone;
  final String email;
  final String zipCode;
  final String taxNumber;
  final String npwpId;
  final String npwpName;
  final String npwpAddress;
  final String description;
  final num grossTotal;
  final num discount;
  final num totalAfterDiscount;
  final num vat;
  final num insurance;
  final num stamp;
  final num totalPaid;

  // This creates the descriptions list dynamically
  List<Description> get descriptions => [
        Description('1', description, grossTotal),
        const Description('', '', null),
        const Description('', '', null),
        const Description('', '', null),
        const Description('', '', null),
        const Description('', '', null),
      ];
  late String address1;
  late String address2;
  late String address3;
  final int chunkSize = 30;

  static const _darkColor = PdfColors.blueGrey800;

  String? _logo;
  String? _redRectangle;
  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    _logo = await rootBundle.loadString(ImageConstant.logoJNESvg);
    _redRectangle = await rootBundle.loadString(ImageConstant.redRectangle);
    _bgShape = await rootBundle.loadString(ImageConstant.footerInvoice);

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 10),
          _contentFooter(context),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.DefaultTextStyle(
      style: const pw.TextStyle(
        fontSize: 8,
      ),
      child: pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.topLeft,
                            padding:
                                const pw.EdgeInsets.only(bottom: 0, left: 0),
                            height: 40,
                            child: _logo != null
                                ? pw.SvgImage(svg: _logo!)
                                : pw.PdfLogo(),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Container(
                            alignment: pw.Alignment.topLeft,
                            child: pw.BarcodeWidget(
                              barcode: pw.Barcode.qrCode(),
                              data:
                                  "{\"field_ui_key\": \"invoice_number_text\",\"value\":\"$invoiceNumber\"}",
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ]),
                    pw.SizedBox(height: 3),
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'JNE BANDUNG',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Expanded(
                child: pw.Column(
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.topLeft,
                      margin: const pw.EdgeInsets.only(left: 35),
                      child: pw.Text(
                        'INVOICE',
                        style: pw.TextStyle(
                            fontSize: 11, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text('Invoice Number'),
                        ),
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(': $invoiceNumber'),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 1),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text('Invoice Date'),
                        ),
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(': $invoiceDate'),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 1),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text('TOP'),
                        ),
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(': $top Days'),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 1),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text('Due Date'),
                        ),
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(': $dueDate'),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 1),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text('Periode'),
                        ),
                        pw.Expanded(
                          flex: 7,
                          child: pw.Text(': $period'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 2),
                    pw.Text(
                      'Jl. Soekarno Hatta No. 452 Bandung',
                    ),
                    pw.SizedBox(height: 7),
                    pw.Text(
                        'NPWP : 01.539.710.2.038.000 - PT. TIKI JALUR NUGRAHA EKA KURIR'),
                  ],
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.BarcodeWidget(
                      barcode: pw.Barcode.code128(
                        useCode128A: true,
                      ),
                      color: PdfColors.black,
                      data: invoiceNumber,
                      drawText: false,
                      height: 25,
                      width: 140,
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Container(
                  margin: pw.EdgeInsets.zero,
                  padding: pw.EdgeInsets.zero,
                  alignment: pw.Alignment.center,
                  width: double.infinity,
                  height: 15,
                  child: _redRectangle != null
                      ? pw.SvgImage(svg: _redRectangle!)
                      : pw.PdfLogo(),
                ),
              ),
            ],
          ),
          if (context.pageNumber > 1) pw.SizedBox(height: 20)
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 45),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 8,
            color: PdfColors.black,
          ),
        ),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: false,
        child: pw.SvgImage(svg: _bgShape!),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.DefaultTextStyle(
      style: const pw.TextStyle(fontSize: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 3),
                pw.Text('BILLED TO',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Customer ID'),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text(': $customerId'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Customer Name'),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text(': $customerName'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Address'),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text(': $address1'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(''),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text('  $address2'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(''),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text('  $address3'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Phone'),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text(': $phone'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Email'),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text(': $email'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 1),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text('Zip Code'),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Text(': $zipCode'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 15),
              ],
            ),
          ),
          pw.Expanded(
            flex: 2,
            child: pw.Row(
              children: [
                pw.SizedBox(width: 30),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: 3),
                      pw.Text('Nomor Seri Faktur Pajak :',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 1),
                      pw.Text(taxNumber),
                      pw.SizedBox(height: 2),
                      pw.Text('NPWP ID :',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 1),
                      pw.Text(npwpId),
                      pw.SizedBox(height: 2),
                      pw.Text('NPWP Name :',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 1),
                      pw.Text(npwpName),
                      pw.SizedBox(height: 2),
                      pw.Text('NPWP Address :',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 1),
                      pw.Text(npwpAddress),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.DefaultTextStyle(
      style: const pw.TextStyle(fontSize: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 1,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Term and Conditions',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 20),
                    pw.Text('1. '),
                    pw.Expanded(
                      child: pw.Text(
                          'Please pay within due date. Any late payment will have an Discount ${_formatCurrency(discount)} interest charge in acccordance with contract'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 2),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 20),
                    pw.Text('2. '),
                    pw.Expanded(
                      child: pw.Text(
                          'Please confirm invoice numbers within 3 days after payment VAT ${_formatCurrency(vat)} execution'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 2),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(width: 20),
                    pw.Text('3. '),
                    pw.Expanded(
                      child: pw.Text(
                          'Invoices are valid & automatically generated by system. No Stamp ${_formatCurrency(stamp)} manual approval required.'),
                    ),
                  ],
                ),
                pw.SizedBox(height: 30),
                pw.Text(
                  'Please Pay to Our Bank Account',
                  style: pw.TextStyle(
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          pw.Expanded(
            flex: 1,
            child: pw.DefaultTextStyle(
              style: const pw.TextStyle(
                fontSize: 9,
                color: _darkColor,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text('Gross Total',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text(
                        _formatCurrency(grossTotal),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text('Discount',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text(
                        _formatCurrency(discount),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text('Total After Discount',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text(
                        _formatCurrency(totalAfterDiscount),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text('VAT',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text(
                        _formatCurrency(vat),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text('Insurance',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text(
                        _formatCurrency(insurance),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text('Stamp',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Text(
                        _formatCurrency(stamp),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerLeft,
                      width: 150,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                        color: const PdfColor.fromInt(0xffFEC91C),
                      ),
                      child: pw.Text('Total Paid',
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      alignment: pw.Alignment.centerRight,
                      width: 91,
                      height: 12,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                        color: const PdfColor.fromInt(0xffFEC91C),
                      ),
                      child: pw.Text(
                        _formatCurrency(totalPaid),
                        style: const pw.TextStyle(color: PdfColors.black),
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                          right: 3, bottom: 1, left: 3, top: 1),
                      width: 241,
                      alignment: pw.Alignment.centerLeft,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: .5,
                        ),
                      ),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Be Regarded As:',
                              style: pw.TextStyle(
                                  color: PdfColors.black,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(_numberToWords(totalPaid),
                              style:
                                  const pw.TextStyle(color: PdfColors.black)),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = ['No', 'Description', 'Amount'];

    return pw.TableHelper.fromTextArray(
      cellPadding:
          const pw.EdgeInsets.only(right: 3, bottom: 1, left: 3, top: 1),
      border: pw.TableBorder.all(
        color: PdfColors.black,
        width: .5,
      ),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        color: PdfColor.fromInt(0xff4B5B91),
      ),
      headerHeight: 30,
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FixedColumnWidth(50),
        1: const pw.FlexColumnWidth(300),
        2: const pw.FlexColumnWidth(80),
      },
      headerStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 9,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 9,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border.all(
          color: PdfColors.black,
          width: .5,
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        descriptions.length,
        (row) => List<String>.generate(
          tableHeaders.length,
          (col) => descriptions[row].getIndex(col),
        ),
      ),
      headerAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
      },
    );
  }
}

String _formatCurrency(num amount) {
  // Use the NumberFormat class to format the amount
  var formatter = NumberFormat("#,##0.00", "ID");

  // Format the number and return it as a string
  return formatter.format(amount);
}

class Description {
  const Description(
    this.no,
    this.description,
    this.amount,
  );

  final String no;
  final String description;
  final num? amount;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return no;
      case 1:
        return description;
      case 2:
        return amount != null ? _formatCurrency(amount!) : '';
    }
    return '';
  }
}

String _numberToWords(num number) {
  final List<String> units = [
    '',
    'Satu',
    'Dua',
    'Tiga',
    'Empat',
    'Lima',
    'Enam',
    'Tujuh',
    'Delapan',
    'Sembilan'
  ];
  final List<String> scales = ['', 'Ribu', 'Juta', 'Miliar', 'Triliun'];

  if (number == 0) return 'Nol Rupiah';

  String convertThreeDigit(num number) {
    String result = '';
    final hundreds = (number ~/ 100).toInt();
    final tens = ((number % 100) ~/ 10).toInt();
    final ones = (number % 10).toInt();

    if (hundreds > 0) {
      if (hundreds == 1) {
        result += 'Seratus ';
      } else {
        result += '${units[hundreds]} Ratus ';
      }
    }

    if (tens > 0) {
      if (tens == 1) {
        if (ones == 0) {
          result += 'Sepuluh ';
        } else if (ones == 1) {
          result += 'Sebelas ';
        } else {
          result += '${units[ones]} Belas ';
        }
      } else {
        result += '${units[tens]} Puluh ';
      }
    }

    if (ones > 0 && tens != 1) {
      if (ones == 1 && result.isEmpty) {
        result += 'Se';
      } else {
        result += '${units[ones]} ';
      }
    }

    return result.trim();
  }

  String result = '';
  int scaleIndex = 0;

  while (number > 0) {
    final threeDigitPart = (number % 1000).toInt();
    if (threeDigitPart > 0) {
      final prefix = convertThreeDigit(threeDigitPart);
      if (scaleIndex == 1 && threeDigitPart == 1) {
        result = 'Seribu $result';
      } else {
        result = '$prefix ${scales[scaleIndex]} $result';
      }
    }
    number ~/= 1000;
    scaleIndex++;
  }

  return '${result.trim()} Rupiah';
}
