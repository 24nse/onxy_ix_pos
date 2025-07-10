  import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/core/utils/responsive_font_size.dart';

class ProceedToCheckoutButton extends StatelessWidget {
  const ProceedToCheckoutButton({super.key, this.onPressed});
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B5998),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            'Proceed to Checkout',
            style: TextStyle(color: Colors.white, fontSize: getResponsiveFontSize(context, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
