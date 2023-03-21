import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WindowScrollBehavior extends MaterialScrollBehavior {
  // ignore: non_constant_identifier_names
  Set<PointerDeviceKind> get DragDevices =>
      {PointerDeviceKind.mouse, PointerDeviceKind.touch};
}
