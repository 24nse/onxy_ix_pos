import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:onyx_ix_pos/features/invoice/data/datasource/local/mock_data.dart';
import 'package:onyx_ix_pos/features/invoice/domain/entities/customer.dart';
import 'package:onyx_ix_pos/features/invoice/domain/entities/seller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../domain/entities/invoice_item.dart';

Future<Uint8List> generatePdf({
  required String customerId,
  required String sellerId,
  required List<InvoiceItem> items,
  required double subtotal,
  required double discount,
  required double totalVat,
  required double totalExempt,
  required double totalWithVat,
  required String amountInWords,
  required String paymentMethod,
  required String dueDate,
  required String invoiceDateStr,
}) async {
  final pdf = pw.Document();

  final fontData = await rootBundle.load('fold/fonts/Cairo-Regular.ttf');
  final font = pw.Font.ttf(fontData);

  final boldFontData = await rootBundle.load('fold/fonts/Cairo-Bold.ttf');
  final boldFont = pw.Font.ttf(boldFontData);

  final customer = mockCustomers.first;
  final seller = mockSellers.first;

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Column(
          children: [
            buildHeaderSection(font, boldFont),
            pw.SizedBox(height: 20),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                buildInfoInvoiceSection(
                  customer: customer,
                  seller: seller,
                  invoiceDateStr: invoiceDateStr,
                  dueDate: dueDate,
                  paymentMethod: paymentMethod,
                  font: font,
                  boldFont: boldFont,
                ),
                pw.SizedBox(height: 20),
                buildInvoiceTableSection(
                  items: items,
                  font: font,
                  boldFont: boldFont,
                ),
                buildSummarySection(
                  amountInWords: amountInWords,
                  subtotal: subtotal,
                  discount: discount,
                  totalVat: totalVat,
                  totalExempt: totalExempt,
                  totalWithVat: totalWithVat,
                  font: font,
                  boldFont: boldFont,
                ),  
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return pdf.save();
}






//sections 

pw.Widget buildHeaderSection(pw.Font font, pw.Font boldFont) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(8),
    color: const PdfColor.fromInt(0xFFEBF7FF),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
           pw.Container(
          width: 40,
          height: 40,
          alignment: pw.Alignment.center,
          decoration: const pw.BoxDecoration(color: PdfColors.red),
          child: pw.Text(
            'Logo',
            textDirection: pw.TextDirection.rtl,

            style: pw.TextStyle(font: boldFont, color: PdfColors.white),
          ),
        ),
    
       
        
        pw.SizedBox(width: 10),
            pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              textDirection: pw.TextDirection.rtl,
              'شركة قصر الروابي',
              style: pw.TextStyle(font: boldFont, fontSize: 14),
            ),
            pw.Text(
              textDirection: pw.TextDirection.rtl,
              '3761 طريق الملك فهد الفرعي',
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
            pw.Text(
              textDirection: pw.TextDirection.rtl,
              'حي المعذر - المملكة العربية السعودية',
              style: pw.TextStyle(font: font, fontSize: 12),
            ),
          ],
        ),
      
        pw.Spacer(),
     
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text(
              textDirection: pw.TextDirection.rtl,
              'فاتورة ضريبية',
              style: pw.TextStyle(font: font, fontSize: 14),
            ),
            pw.Text(
              'Tax Invoice',
              style: pw.TextStyle(font: font, fontSize: 14),
            ),
            pw.Text(
              '12411648899',
              style: pw.TextStyle(font: font, fontSize: 14),
            ),
          ],
        ),
       
       
       
        pw.SizedBox(width: 10),
      pw.Container(
          width: 40,
          height: 40,
          alignment: pw.Alignment.center,
          child: pw.Text(
            'QR',
            style: pw.TextStyle(fontSize: 20, font: boldFont),
          ),
        ),
        
      ],
    ),
  );
}

pw.Widget buildInfoInvoiceSection({
  required Customer customer,
  required Seller seller,
  required String invoiceDateStr,
  required String dueDate,
  required String paymentMethod,
  required pw.Font font,
  required pw.Font boldFont,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          infoColumnPdf('طريقة الدفع', paymentMethod, font, boldFont),
          infoColumnPdf('تاريخ الاستحقاق', dueDate, font, boldFont),
          infoColumnPdf('تاريخ الفاتورة', invoiceDateStr, font, boldFont),
        ],
      ),
      pw.SizedBox(height: 16),

      pw.Row(
        children: [
          pw.Expanded(
            child: customInfoContainerPdf(
              title: 'بيانات المورد',
              titleColor: PdfColors.red,
              alignment: pw.CrossAxisAlignment.start,
              font: font,
              boldFont: boldFont,
              info: [
                {'الاسم': seller.name},
                {'الرمز': seller.postalCode},
              ],
            ),
          ),
          pw.SizedBox(width: 16),

          pw.Expanded(
            child: customInfoContainerPdf(
              title: 'العميل',
              titleColor: PdfColors.red,
              alignment: pw.CrossAxisAlignment.start,
              font: font,
              boldFont: boldFont,
              info: [
                {'الاسم': customer.name},
                {'الرمز': customer.postalCode},
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

pw.Widget buildInvoiceTableSection({
  required List<InvoiceItem> items,
  required pw.Font font,
  required pw.Font boldFont,
}) {
  final headers = [
    '#',
    'اسم الصنف',
    'الوحدة',
    'السعر',
    'الكمية',
    'الكمية المجانية',
    'ضريبة %',
    'قيمة ضريبة',
    'الإجمالي',
  ];

  return pw.Container(
    padding: const pw.EdgeInsets.all(8),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.grey),
      borderRadius: pw.BorderRadius.circular(8),
      color: PdfColors.white,
    ),
    child: pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey),
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
      columnWidths: {
        0: const pw.FixedColumnWidth(30),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(1),
        3: const pw.FlexColumnWidth(1),
        4: const pw.FlexColumnWidth(1),
        5: const pw.FlexColumnWidth(1.5),
        6: const pw.FlexColumnWidth(1.2),
        7: const pw.FlexColumnWidth(1.5),
        8: const pw.FlexColumnWidth(1.5),
      },
      children: [
        // Header Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColor.fromInt(0xFFDC292F),
          ),
          children: headers.map((header) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(6),
              child: pw.Text(
                header,
                style: pw.TextStyle(
                  font: boldFont,
                  fontSize: 12,
                  color: PdfColors.white,
                ),
                textAlign: pw.TextAlign.center,
                textDirection: pw.TextDirection.rtl,
              ),
            );
          }).toList(),
        ),
        // Data Rows
        ...items.asMap().entries.map((entry) {
          final i = entry.key + 1;
          final item = entry.value;
          return pw.TableRow(
            children: [
              pw.Center(
                child: pw.Text(
                  i.toString(),
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Text(
                item.name,
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(font: font, fontSize: 10),
              ),
              pw.Center(
                child: pw.Text(
                  item.unit,
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  item.price.toStringAsFixed(2),
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  item.quantity.toString(),
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  item.freeQuantity.toString(),
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  '${(item.vatPercent * 100).toStringAsFixed(0)}%',
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  item.vatValue.toStringAsFixed(2),
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
              pw.Center(
                child: pw.Text(
                  item.total.toStringAsFixed(2),
                  style: pw.TextStyle(font: font, fontSize: 10),
                ),
              ),
            ],
          );
        }),
      ],
    ),
  );
}


pw.Widget buildSummarySection({
  required String amountInWords,
  required double subtotal,
  required double discount,
  required double totalVat,
  required double totalExempt,
  required double totalWithVat,
    required pw.Font font,
  required pw.Font boldFont,
}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(24),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        summaryRow(
          'الإجمالي',
          subtotal.toStringAsFixed(2),
          border: true,
          font: font,
          boldFont: boldFont,
        ),
        summaryRow(
          'الخصم',
          discount.toStringAsFixed(2),
          border: true,
          font: font,
          boldFont: boldFont,
        ),
        summaryRow(
          'إجمالي الضريبة',
          totalVat.toStringAsFixed(2),
          border: true,
          font: font,
          boldFont: boldFont,
        ),
        summaryRow(
          'إجمالي الإعفاء',
          totalExempt.toStringAsFixed(2),
          border: true,
          font: font,
          boldFont: boldFont,
        ),
        summaryRow(
          'الإجمالي بالضريبة',
          '${totalWithVat.toStringAsFixed(2)} SAR',
          bold: true,
          font: font,
          boldFont: boldFont,
        ),
      ],
    ),
  );
}






// custom
pw.Widget infoColumnPdf(
  String label,
  String value,
  pw.Font font,
  pw.Font boldFont,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(
        label,
        style: pw.TextStyle(
          font: font,
          fontSize: 14,
          color: const PdfColor.fromInt(0xFF819AA7),
        ),
        textDirection: pw.TextDirection.rtl, // لدعم اللغة العربية
      ),
      pw.SizedBox(height: 4),
      pw.Text(
        value,
        style: pw.TextStyle(
          font: boldFont,
          fontSize: 14,
          color: const PdfColor.fromInt(0xFF000000),
          fontWeight: pw.FontWeight.bold,
        ),
        textDirection: pw.TextDirection.rtl,
      ),
    ],
  );
}

pw.Widget summaryRow(
  String label,
  String value, {
  bool bold = false,
  bool border = false,
  required pw.Font font,
  required pw.Font boldFont,
}) {
  return pw.Container(
    decoration: border
        ? const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.grey, width: 0.5),
            ),
          )
        : null,
    padding: const pw.EdgeInsets.symmetric(vertical: 4),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text(
          textDirection: pw.TextDirection.rtl,
          label,
          style: pw.TextStyle(fontSize: 12, font: font),
        ),
        pw.SizedBox(width: 8),
        pw.Text(
          textDirection: pw.TextDirection.rtl,
          value,
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

pw.Widget customInfoContainerPdf({
  required String title,
  required PdfColor titleColor,
  required pw.CrossAxisAlignment alignment,
  required List<Map<String, String>> info,
  required pw.Font font,
  required pw.Font boldFont,
  pw.EdgeInsets? margin,
}) {
  return pw.Container(
    margin: margin ?? pw.EdgeInsets.zero,
    decoration: pw.BoxDecoration(
      color: const PdfColor.fromInt(0xFFF9F9F9),
      borderRadius: pw.BorderRadius.circular(8),
      border: pw.Border.all(color: const PdfColor.fromInt(0xFFF9F9F9)),
    ),
    padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: pw.Column(
      crossAxisAlignment: alignment,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(font: boldFont, fontSize: 16, color: titleColor),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.Divider(color: const PdfColor.fromInt(0xFFE2E2E2), thickness: 2),
        pw.SizedBox(height: 4),
        ...info.map((item) {
          final key = item.keys.first;
          final value = item.values.first;

          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 2,
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    key,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 14,
                      color: const PdfColor.fromInt(0xFF474747),
                    ),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ),
              ),
              pw.Expanded(
                flex: 4,
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    value,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 14,
                      // fontWeight: mediumFont,
                      color: PdfColors.black,
                    ),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ),
              ),
              pw.SizedBox(width: 8),
            ],
          );
        }),
      ],
    ),
  );
}

pw.Widget infoColumn(
  String title,
  String value, {
  required pw.Font font,
  required pw.Font boldFont,
}) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.Text(title, style: pw.TextStyle(font: boldFont, fontSize: 12)),
      pw.SizedBox(height: 4),
      pw.Text(value, style: pw.TextStyle(font: font, fontSize: 10)),
    ],
  );
}

pw.Widget customInfoContainer({
  required String title,
  required List<Map<String, String>> info,
  required pw.Font font,
  required pw.Font boldFont,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(8),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.grey),
      borderRadius: pw.BorderRadius.circular(8),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            font: boldFont,
            fontSize: 14,
            color: PdfColors.red,
          ),
        ),
        pw.SizedBox(height: 8),
        ...info.map((item) {
          final key = item.keys.first;
          final value = item.values.first;
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text('$key: ', style: pw.TextStyle(font: font, fontSize: 10)),
              pw.Text(value, style: pw.TextStyle(font: boldFont, fontSize: 10)),
            ],
          );
        }),
      ],
    ),
  );
}

