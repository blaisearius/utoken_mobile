import 'package:flutter/material.dart';
import 'package:uac_token_mobile/widgets/setting/settings_tile.dart';
import 'package:uac_token_mobile/widgets/setting/settings_section.dart';
import 'package:uac_token_mobile/widgets/setting/settings_list.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:uac_token_mobile/screens/welcome_screen.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen>
    with TickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> topBarAnimation;

  String languageValue;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  //List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState(){
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    //languageValue = await managePreferences.setNewLanguage('fr', true);

    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();

  }

  void addAllListData() async{
    const int count = 9;
    languageValue = await managePreferences.getPreferredLanguage();

    listViews.add(
      SettingsSection(tiles: [
        SettingsTile(
          title: managePreferences.translateText('english_text'),
          trailing: (languageValue=='en') ? Icon(Icons.check, color: AppTheme.greenColor) : Icon(null),
          onTap: () async{
            await managePreferences.setNewLanguage('en', true);
            /*setState(() {
              languageValue = 'en';
            });*/
            //Navigator.pop(context, 'Go back');
            /*Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WelcomePage()));
            */
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
                  (Route<dynamic> route) => false,
            );
          },
        ),
        SettingsTile(
          title: managePreferences.translateText('french_text'),
          trailing: (languageValue=='fr') ? Icon(Icons.check, color: AppTheme.greenColor) : Icon(null),
          onTap: () async{
            await managePreferences.setNewLanguage('fr', true);
            /*setState(() {
              languageValue = 'fr';
            });*/
            //Navigator.pop(context, 'Go back');
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WelcomePage()));
          },
        ),
      ]),
    );

  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  ExpeditionContent()
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    return true;
  }

  Widget ExpeditionContent() {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            MyAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  15,
              bottom: 15 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget MyAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.headerBGColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                child: Icon(Icons.keyboard_backspace, color: Colors.white,),
                              ),
                              onTap: (){
                                Navigator.pop(context, 'Go back');
                              },
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  managePreferences.translateText('language_text'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

/*
  Widget trailingWidget(String lang) {
    return (languageValue == lang)
        ? Icon(Icons.check, color: Colors.blue)
        : Icon(null);
  }
 */
}
