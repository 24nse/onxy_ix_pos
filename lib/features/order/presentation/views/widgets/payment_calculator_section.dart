import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onyx_ix_pos/core/utils/functions/key_action.dart';

class PaymentCalculatorSection extends HookWidget {
  const PaymentCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
      final paymentAmount = useState<String>('0.00');

    void onKeyPressed(KeyAction action) {
      paymentAmount.value = action.execute(paymentAmount.value);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Enter Payment Amount:'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:   Text(
                paymentAmount.value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: ()=>onKeyPressed(BackspaceKey()),
              child: Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                child: Icon(Icons.backspace_outlined,
                      color: Colors.black),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
           _buildCalcButton(context, '7', () => onKeyPressed(DigitKey('7')),),
            _buildCalcButton(context, '8', () => onKeyPressed(DigitKey('8')),),
            _buildCalcButton(context, '9', () => onKeyPressed(DigitKey('9')),),
            _buildCalcButton(context, '4', ()=> onKeyPressed(DigitKey('4')),),
            _buildCalcButton(context, '5', () => onKeyPressed(DigitKey('5')),),
            _buildCalcButton(context, '6', () => onKeyPressed(DigitKey('6')),),
            _buildCalcButton(context, '1', () => onKeyPressed(DigitKey('1')),),
            _buildCalcButton(context, '2', () => onKeyPressed(DigitKey('2')),),
            _buildCalcButton(context, '3', () => onKeyPressed(DigitKey('3')),),
            _buildCalcButton(context, '0', () => onKeyPressed(DigitKey('0')),),
            _buildCalcButton(context, '.', () => onKeyPressed(DecimalKey()),),
            ElevatedButton(
    onPressed: ()=>onKeyPressed(ClearKey()),
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: Icon(Icons.backspace_outlined, color: Theme.of(context).colorScheme.onPrimary, size: 24),
  ),

        
            
          ],
        ),
        const SizedBox(height: 16),
          _buildCalcButtonWidget(
    context,
    const Text('Payment', style: TextStyle(fontSize: 18)),
    () {
      
    },
            ),
  
          
      ],
    );
  }

  ElevatedButton _buildCalcButton(BuildContext context , String text, VoidCallback onPressed) {
    return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: Text(text, style: const TextStyle(fontSize: 18,color: Colors.black),),
  );
  }
}
Widget _buildCalcButtonWidget(
      BuildContext context, Widget child, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: (true)?onPressed:null,
     
      style: ElevatedButton.styleFrom(
        
        backgroundColor:  Color(0xFF3B5998),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: child,
    );
  }