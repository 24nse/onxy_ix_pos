import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';

class ProceedToCheckoutButton extends StatelessWidget {
  const ProceedToCheckoutButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B5998),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          minimumSize:  Size(
            double.infinity,height*0.06),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Proceed to Checkout',
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 12),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
