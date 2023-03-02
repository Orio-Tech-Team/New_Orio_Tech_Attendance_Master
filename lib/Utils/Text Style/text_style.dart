import 'package:flutter/material.dart';

import 'dimensions.dart';

TextStyle kTitleStyle = const TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins',
  fontSize: 19.0,
);

TextStyle kBodyStyle = const TextStyle(
  color: Colors.black87,
  fontFamily: 'Poppins',

  fontSize: 15.0,
);

TextStyle kWhiteTitleStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontFamily: 'Poppins',
  fontSize: 12,
);

const rubikRegular = TextStyle(
  fontFamily: 'Rubik',
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

const rubikMedium = TextStyle(
  fontFamily: 'Rubik',
  overflow: TextOverflow.ellipsis,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w500,
);

const rubikBold = TextStyle(
  fontFamily: 'Rubik',
  overflow: TextOverflow.ellipsis,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
  fontWeight: FontWeight.w700,
);