import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en', ''));

  void setLocale(Locale newLocale) {
    if (state != newLocale) {
      emit(newLocale);
    }
  }

  void toggleLocale() {
    if (state.languageCode == 'en') {
      emit(const Locale('ar', ''));
    } else {
      emit(const Locale('en', ''));
    }
  }
}
