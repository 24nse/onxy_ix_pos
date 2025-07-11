import 'package:flutter/material.dart';
import 'package:onyx_ix_pos/onyx_ix_pos_app.dart';
import 'package:onyx_ix_pos/core/utils/service_locator.dart';


void main() {
  setupServiceLocator();
  runApp(const OnyxIxPosApp());
}
