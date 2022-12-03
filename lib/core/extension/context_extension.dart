import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double screenWidth(double val) => MediaQuery.of(this).size.width * val;
  double screenHeight(double val) => MediaQuery.of(this).size.height * val;
}

extension PaddingExtension on BuildContext {
  EdgeInsets  paddingAll(double val) => EdgeInsets.all(val);
}

extension NumberExtension on BuildContext {
  double get lowValue => screenWidth(0.01);
  double get mediumValue => screenHeight(0.03);
  double get highValue => screenHeight(0.06);
}
extension EmptyWidget on BuildContext {
  Widget customSizeBoxWidgetWidth(double val) => SizedBox(
        width: val,
      );
  Widget customSizeBoxWidgetHeight(double val) => SizedBox(
        height: val,
      );
  Widget get lowWidgetHeight => SizedBox(
        height: lowValue,
      );
  Widget get lowWidgetWidth => SizedBox(
        width: lowValue,
      );
  Widget get mediumWidgetHeight => SizedBox(
        height: mediumValue,
      );
  Widget get mediumWidgetWidth => SizedBox(
        width: mediumValue,
      );
  Widget get highWidgetHeight => SizedBox(
        height: highValue,
      );
  Widget get highWidgetWidth => SizedBox(
        width: highValue,
      );
}
