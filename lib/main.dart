import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:uac_token_mobile/screens/home_screen.dart';
import 'package:uac_token_mobile/screens/welcome_screen.dart';
import 'package:uac_token_mobile/service_principal.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes the translation module
  await managePreferences.init();

  setupServicePrincipal();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();

    // Initializes a callback should something need
    // to be done when the language is changed
    managePreferences.onLocaleChangedCallback = _onLocaleChanged;
  }

  ///
  /// If there is anything special to do when the user changes the language
  ///
  _onLocaleChanged() async {
    // do anything you need to do if the language changes
    print('Language has been changed to: ${managePreferences.currentLanguage}');
  }

  ///
  /// Main initialization
  ///
  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Tells the system which are the supported languages
      supportedLocales: managePreferences.supportedLocales(),
      title: managePreferences.translateText('main_title'),
      theme: ThemeData(
        primarySwatch: AppTheme.cryptoMaterialColor,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
        primaryColorDark: AppTheme.greenColor,
        primaryColor: AppTheme.greenColor,
      ),
      home: WelcomePage(),
    );
  }

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

