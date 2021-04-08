import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Map<int, Color> cryptoColor = const <int, Color> {
    50: Color.fromRGBO(28,108,22, .1),
    100: Color.fromRGBO(28,108,22,  .2),
    200: Color.fromRGBO(28,108,22, .3),
    300: Color.fromRGBO(28,108,22,  .4),
    400: Color.fromRGBO(28,108,22,  .5),
    500: Color.fromRGBO(28,108,22,  .6),
    600: Color.fromRGBO(28,108,22,  .7),
    700: Color.fromRGBO(28,108,22,  .8),
    800: Color.fromRGBO(28,108,22,  .9),
    900: Color.fromRGBO(28,108,22,  1),
  };

  static const Color loginBG1Color = const Color.fromRGBO(35,93,32,  1);
  static const Color loginBG2Color = const Color.fromRGBO(10,100,94,  1);
  static const Color headerBGColor = const Color.fromRGBO(28,108,22,  1);

  static const MaterialColor cryptoMaterialColor = MaterialColor(0xFF005a87, cryptoColor);

  static const Color cryptoLightColor = const Color.fromRGBO(59, 196, 49,  1);
  static const Color cryptoDarkColor = const Color.fromRGBO(28,108,22,  1);


  static const Color greenColor = Color(0xFF235D1F);
  static const Color primaryColor = Color(0xFF005A87);
  static const Color secondaryColor = Color(0xFF727a9a);
  static const Color successColor = Color(0xFF438880);
  static const Color dangerColor = Color(0xFFe53242);
  static const Color warningColor = Color(0xFFffb133);
  static const Color infoColor = Color(0xFF2d55a6);

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Ubuntu';

  static const TextTheme textTheme = TextTheme(
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,


  );

  static const TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline2 = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 35,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle headline3 = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 25,
    letterSpacing: 0.27,
    color: primaryColor,
  );

  static const TextStyle headline4 = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.27,
    color: darkerText,
  );


  static const TextStyle headline5 = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle headline6 = TextStyle( // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    letterSpacing: 0.27,
    color: darkerText,
  );


  static const TextStyle title = TextStyle( // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle( // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle( // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

}
