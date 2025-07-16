import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/header_section.dart';
import 'package:onyx_ix_pos/features/invoice/data/datasource/local/mock_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_cubit.dart';
import 'package:onyx_ix_pos/features/order/presentation/view_models/cubits/cart_state.dart';
import 'package:onyx_ix_pos/features/order/domain/entities/payment.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = mockCustomers.first;
    final seller = mockSellers.first;
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final paymentMethod = state.paymentMethod?.displayName ?? 'نقدي';
        final invoiceDate = DateTime.now();
        final invoiceDateStr = '${invoiceDate.year}/${invoiceDate.month}/${invoiceDate.day} - ${invoiceDate.hour}:${invoiceDate.minute.toString().padLeft(2, '0')}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(child: infoColumn('طريقة الدفع', paymentMethod)),
                Expanded(child: infoColumn('تاريخ الاستحقاق', '28/7/2024')),
                Expanded(child: infoColumn('تاريخ الفاتورة', invoiceDateStr)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: customInfoContainer(
                    margin: const EdgeInsets.only(left: 16, right: 8),
                    title: 'العميل',
                    titleColor: Color(0xFFDC292F),
                    alignment: CrossAxisAlignment.end,
                    info: [
                      {' الاسم': customer.name},
                      {' المدينة': customer.city},
                      {' الدولة': customer.country},
                      {' الرمز البريدي ': customer.postalCode},
                      {' الرقم الضريبي': customer.vatNumber},
                      {' السجل التجاري': customer.commercialRegister},
                      {' معرف آخر': customer.otherId},
                    ],
                  ),
                ),
                Expanded(
                  child: customInfoContainer(
                    margin: const EdgeInsets.only(left: 8, right: 16),
                    title: 'بيانات المورد',
                    titleColor: Color(0xFFDC292F),
                    alignment: CrossAxisAlignment.end,
                    info: [
                      {' الاسم': seller.name},
                      {' المدينة': seller.city},
                      {' الدولة': seller.country},
                      {' الرمز البريدي ': seller.postalCode},
                      {' الرقم الضريبي': seller.vatNumber},
                      {' السجل التجاري': seller.commercialRegister},
                      {' معرف آخر': seller.otherId},
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  Widget infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: label,
          style: TextStyle(color: Color(0xFF819AA7), fontSize: 14),
        ),
        const SizedBox(height: 4),
        CustomText(
          text: value,
          // style: TextStyle(color: Color(0xFF000000), fontSize: 14),
        ),
      ],
    );
  }
 Widget customInfoContainer({
    required String title,
    required Color titleColor,
    required CrossAxisAlignment alignment,
    required List<Map<String, String>> info,
    EdgeInsetsGeometry? margin ,
  }) {
    return Container(
      margin:margin,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF9F9F9)),
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFF9F9F9),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          CustomText(
            text: title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          Divider(color: Color(0xFFE2E2E2), thickness: 2),
          const SizedBox(height: 4),
          ...info.map((item) {
            final key = item.keys.first;
            final value = item.values.first;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                        alignment: Alignment.centerRight,
                    child: CustomText(
                      text: value,
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width:8),
                Expanded(
                  flex: 1,
                  child: Container(
                                alignment: Alignment.centerRight,
                    child: CustomText(
                      text: key,
                      style: TextStyle(color: Color(0xFF474747), fontSize: 14),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

}
 