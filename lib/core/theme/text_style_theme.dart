import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/constants.dart';

TextStyle getTextStyle(color, fontWeight) {
  return GoogleFonts.getFont(appFontFamily,
      color: color, fontWeight: fontWeight,
      );
}

