import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/features/invoice/presentation/views/widgets/custom_container_image.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFEBF7FF) ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainerImage(
            
            child: Icon(
              
              Icons.qr_code, size: 40, color: Colors.black),
          ),
          SizedBox(width: 10),
          Column(
            children: [
              CustomText(text:  'فاتورة ضريبية',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomText(text:  'Tax Invoice',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomText(text:  '12411648899',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          // Title and address
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 7,
            children: [
              CustomText(
              text:   'شركة قصر الروابي', style: TextStyle(
                          color: Color(
                            0xFF000000,
                          ) ,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomText(
                
                text: '3761 طريق الملك فهد الفرعي',
                style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 12,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomText(
                text: 'حي المعذر - المملكة العربية السعودية',
                style: TextStyle(
                  color: Color(0xFF474747),
                  fontSize: 12,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          // Logo
          CustomContainerImage(
            child: Center(
              child: Text(
                'Logo',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextStyle? style;
  const CustomText({
    required this.text,
    this.color,
    this.fontSize,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      
        style: style ?? TextStyle(
          color: color ?? const Color(0xFF474747),
          fontSize: fontSize ?? 12,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
