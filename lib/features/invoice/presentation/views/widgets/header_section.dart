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
      decoration: BoxDecoration(color: const Color(0xFFEBF7FF) ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainerImage(
            
            child: Icon(
              
              Icons.qr_code, size: 40, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Column(
            children: [
              Text('فاتورة ضريبية',
               style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                        ),
              ),
              Text('Tax Invoice',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text('12411648899',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Title and address
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
           spacing: 7,
            children: [
              CustomText(
              text:   'شركة قصر الروابي', style: TextStyle(
                          color: const Color(
                            0xFF000000,
                          ) ,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
              ),
              CustomText(
                
                text: '3761 طريق الملك فهد الفرعي',
                style: TextStyle(
                  color: const Color(0xFF474747),
                  fontSize: 9,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                ),
              ),
              CustomText(
                text: 'حي المعذر - المملكة العربية السعودية',
                style: TextStyle(
                  color: const Color(0xFF474747),
                  fontSize: 9,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
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
    return Text(
      text,
      style: style ?? TextStyle(
        color: color ?? const Color(0xFF474747),
        fontSize: fontSize ?? 12,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
