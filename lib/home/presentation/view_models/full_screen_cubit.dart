import 'package:flutter_bloc/flutter_bloc.dart';

class FullScreenCubit extends Cubit<bool> {
  FullScreenCubit() : super(false);

  void toggleFullScreen() => emit(!state);
}
