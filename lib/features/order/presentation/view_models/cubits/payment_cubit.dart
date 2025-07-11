import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx_ix_pos/features/order/domain/entities/key_action.dart';

class PaymentCubit extends Cubit<String> {
  PaymentCubit() : super('0.00');

  void onKeyPressed(KeyAction action) {
    final newValue = action.execute(state);
    emit(newValue);
  }

  void reset() {
    emit('0.00');
  }
}
