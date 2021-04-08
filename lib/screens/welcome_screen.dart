import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/screens/login_screen.dart';
import 'package:uac_token_mobile/screens/register_screen.dart';
import 'package:uac_token_mobile/screens/home_screen.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:uac_token_mobile/screens/navigation_home_screen.dart';
import 'package:uac_token_mobile/services/login_service.dart';
import 'package:uac_token_mobile/service_principal.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Timer _timer;
  bool checking = true;

  _WelcomePageState() {
    _timer = new Timer(const Duration(milliseconds: 500), () {
      setState(() {

      });
      _timer = new Timer(const Duration(seconds: 1), () async {
        bool stateLogin = await service_principal<LoginService>()
            .verifyAccessToken(context);

        if (stateLogin == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavigationHomeScreen())
          );
        }
        else {
          setState(() {
            this.checking=false;
          });
          /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
          );*/
        }
      });
    });
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff235D1F).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          managePreferences.translateText('login'),
          style: TextStyle(fontSize: 20, color: Color(0xff235D1F)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          managePreferences.translateText('register'),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          children: <Widget>[
            Text(
              managePreferences.translateText('slogan'),
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
             SizedBox(
              height: 5,
            ),
            this.checking ?
            CircularProgressIndicator(
              backgroundColor: AppTheme.white,
              strokeWidth:5.0,
            ) :
            Text(""),
            SizedBox(
              height: 10,
            ),
            Container(
              child: SizedBox(
                child: Image(
                  image: AssetImage(
                      'assets/images/uac_logo_trans.png',
                  ),
                  width: 80,
                ),
              ),
              margin: EdgeInsets.only(left: 70, right: 70),
            ),
            Text(
              managePreferences.translateText('author'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: managePreferences.translateText('title_first_letter'),
          style: TextStyle(color: AppTheme.primaryColor, fontFamily:AppTheme.fontName, fontWeight: FontWeight.w500, fontSize: 50),
          children: [

            TextSpan(
              text: managePreferences.translateText('title_after_first_letter'),
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.loginBG2Color, AppTheme.loginBG1Color])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: SizedBox(
                  child: Image(
                    image: AssetImage('assets/images/logo_4x.png'),
                    width: 200,
                  ),
                ),
                margin: EdgeInsets.only(left: 40, right: 40),
              ),
              SizedBox(
                height: 40,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 20,
              ),
              _label()
            ],
          ),
        ),
      ),
    );
  }
}
