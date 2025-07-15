import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
              Expanded(
              child: infoColumn('تاريخ الفاتورة', '24/7/2024 - 10:00:00 PM'),
            ),
              Expanded(child: infoColumn('طريقة الدفع', 'نقدي')),
          
            Expanded(child: infoColumn('تاريخ الاستحقاق', '28/7/2024')),
          
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: customInfoContainer(
                title: 'بيانات المورد',
                titleColor: Color(0xFFDC292F),
                alignment: CrossAxisAlignment.end,
                info: [
                  {': الاسم': 'شركة قصر الروابي'},
                                    {': المدينة': ' 3'},

                  {': الدولة': 'السعودية - 1'},
                  {': الرمز البريدي ': '8727'},
                  {': الرقم الضريبي': '8727'},
                  {': السجل التجاري': '3006256961000003'},
                  {': معرف آخر': '10'},
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: customInfoContainer(
                title: 'العميل',
                titleColor: Color(0xFFDC292F),
                alignment: CrossAxisAlignment.end,
                info: [
                  {': الاسم': 'عميل نقدي عام'},
                  {': المدينة': ' 3'},
                  {': الدولة': 'السعودية - 1'},
                    {': الرمز البريدي ': '8727'},
                  {': الرقم الضريبي': '8727'},
                  {': السجل التجاري': '3006256961000003'},
                  {': معرف آخر': '10'},
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

Widget infoColumn(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [CustomText(text: label,style: TextStyle(color: Color(0xFF819AA7),fontSize: 14),), const SizedBox(height: 4), CustomText(text: value, style: TextStyle(color: Color(0xFF000000), fontSize: 14),)],
  );
}

Widget customInfoContainer({
  required String title,
  required Color titleColor,
  required CrossAxisAlignment alignment,
  required List<Map<String, String>> info,
}) {
  return Container(
 
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFF9F9F9)),
      borderRadius: BorderRadius.circular(8),
      color: Color(0xFFF9F9F9),
    ),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    child: Column(
      crossAxisAlignment: alignment,
      children: [
        CustomText(text: title,  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: titleColor)),
        Divider(
          color: Color(0xFFE2E2E2),
          thickness: 2,
        ),
        const SizedBox(height: 4),
        ...info.map((item) {
          final key = item.keys.first;
          final value = item.values.first;
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(text: value, style: TextStyle(color: Color(0xFF000000), fontSize: 16,fontWeight: FontWeight.w500),),
              SizedBox(width: 8),
              CustomText(text: key ,style: TextStyle(color: Color(0xFF474747),fontSize: 14),),
            ],
          );
        }),
      ],
    ),
  );
}
