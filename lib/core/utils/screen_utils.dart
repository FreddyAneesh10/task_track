import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

/// Height
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

/// Width
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

/// Height percentage (0–100)
double screenHeightPercent(BuildContext context, double percent) {
  return screenSize(context).height * (percent / 100);
}

/// Width percentage (0–100)
double screenWidthPercent(BuildContext context, double percent) {
  return screenSize(context).width * (percent / 100);
}

/// Top padding (status bar)
double topPadding(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// Bottom padding
double bottomPadding(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

/// Check keyboard
bool isKeyboardOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}