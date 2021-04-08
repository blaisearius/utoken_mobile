import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:uac_token_mobile/screens/help_screen.dart';
import 'package:uac_token_mobile/screens/send_token_screen.dart';
import 'package:uac_token_mobile/screens/setting_screen.dart';
import 'package:uac_token_mobile/screens/transaction_screen.dart';
import 'package:uac_token_mobile/widgets/custom_drawer/drawer_user_controller.dart';
import 'package:uac_token_mobile/widgets/custom_drawer/home_drawer.dart';
import 'package:uac_token_mobile/screens/home_screen.dart';
import 'package:flutter/material.dart';


class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: WillPopScope(
          onWillPop: () => _exitApp(context),
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
                //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
              },
              screenView: screenView,
              //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = HomePage();
        });
      } else if (drawerIndex == DrawerIndex.SendToken) {
        setState(() {
          screenView = SendTokenPage();
        });
      } else if (drawerIndex == DrawerIndex.Transaction) {
        setState(() {
          screenView = TransactionPage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = HelpPage();
        });
      } else if (drawerIndex == DrawerIndex.Setting) {
        setState(() {
          screenView = SettingPage();
        });
      } else {
        //do in your way......
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: new Text(managePreferences.translateText('exit_tiltle')),
          content: new Text(managePreferences.translateText('exit_content')),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text(managePreferences.translateText('no_stay')),
            ),
            new FlatButton(
              onPressed: _removeAllKeys,
              child: new Text(managePreferences.translateText('yes_exit')),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  _removeAllKeys() async {
    await managePreferences.setWalletPrivateKey("");
    await managePreferences.setWalletPublicKey("");
    Navigator.of(context).pop(true);
  }
}
