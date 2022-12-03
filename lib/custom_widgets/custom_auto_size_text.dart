import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomAutoSizeText extends StatelessWidget {
  final String text;
  final double maxFontSize, minFontSize;
  final int maxLines;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final double textScaleFactor;
  const CustomAutoSizeText(
      {Key? key,
      required this.text,
      required this.maxFontSize,
      required this.minFontSize,
      required this.maxLines,
      required this.textStyle,
      required this.textScaleFactor, 
      required this.textAlign,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxFontSize: maxFontSize,
      minFontSize: minFontSize,
      maxLines: maxLines,
      style: textStyle,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
    );
  }
}
