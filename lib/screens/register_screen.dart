import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uac_token_mobile/constants/constants.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/screens/home_screen.dart';
import 'package:uac_token_mobile/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:uac_token_mobile/screens/welcome_screen.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int visibleCircularProgress = 0;

  final _myEmailFieldController = TextEditingController();
  final _myUsernameFieldController = TextEditingController();
  final _myPasswordFieldController = TextEditingController();
  bool _validateEmailField = true;
  bool _validateUsernameField = true;
  bool _validatePasswordField = true;
  bool _showPassword = true;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            Text(managePreferences.translateText('back'),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color:Colors.white))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _myEmailFieldController.dispose();
    _myUsernameFieldController.dispose();
    _myPasswordFieldController.dispose();
    super.dispose();
  }

  Widget _entryField(String title, TextEditingController controller, {bool isPassword = false, bool validation}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
              errorText: validation ? null : managePreferences.translateText('value_not_empty_text'),
            ))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      child:  Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
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
      onTap: () async{

        setState(() {
          visibleCircularProgress = 1;
        });

        String username = this._myUsernameFieldController.text;
        String email = this._myEmailFieldController.text;
        String password = this._myPasswordFieldController.text;
        if(username ==null || username==""){
          setState(() {
            this._validateUsernameField=false;
          });
        }
        else{
          setState(() {
            this._validateUsernameField=true;
          });
        }
        if(email ==null || email==""){
          setState(() {
            this._validateEmailField=false;
          });
        }
        else{
          setState(() {
            this._validateEmailField=true;
          });
        }
        if(password ==null || password==""){
          setState(() {
            this._validatePasswordField=false;
          });
        }
        else{
          setState(() {
            this._validatePasswordField=true;
          });
        }

        if(this._validateEmailField && this._validatePasswordField && this._validateUsernameField){
          bool result = await registerUser(email, username, password);
          if(result==true){
            Navigator.pushReplacement(
              //context, MaterialPageRoute(builder: (context) => HomePage()));
                context, MaterialPageRoute(builder: (context) => WelcomePage()));
          }
          else{
            setState(() {
              visibleCircularProgress = 0;
            });
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Connexion échouée"),
                    content: Text("Erreur survenue dans la création de compte. Veuillez réessayer."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Fermer'),
                      )
                    ],
                  );
                });
          }
        }
        else{
          setState(() {
            visibleCircularProgress = 0;
          });
        }
      },
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              managePreferences.translateText('alreay_have_account'),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,

                decoration: TextDecoration.underline
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              managePreferences.translateText('login'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }


  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(managePreferences.translateText('student_number'), this._myUsernameFieldController, validation: this._validateEmailField),
        _entryField(managePreferences.translateText('email'), this._myEmailFieldController, validation: this._validateEmailField),
        _entryField(managePreferences.translateText('password'), this._myPasswordFieldController, isPassword: true, validation: this._validatePasswordField),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Container(
                      child: SizedBox(
                        child: Image(
                          image: AssetImage('assets/images/logo_4x.png'),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 80, right: 80),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    _submitButton(),

                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }



  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: new Text(managePreferences.translateText('exit_tiltle')),
          content: new Text(managePreferences.translateText('exit_content')),
          actions: <Widget>[
            new TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text(managePreferences.translateText('no_stay')),
            ),
            new TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text(managePreferences.translateText('yes_exit')),
            ),
          ],
        );
      },
    ) ??
        false;
  }

  Future<bool> registerUser(String email, String username, String password) async{
    String register_url = api_url+"/api/users/register";
    Map<String, String> headers = {"Content-type": "application/json"};
    String data = '{"username": "'+username+'", '+'"email": "'+email+'", '+'"first_name": "'+username+'", '+'"last_name": "'+username+'", '+'"first_password": "'+password+'", '+'"second_password": "'+password+'"}';

    try {
      var response = await http.post(
          register_url,
          headers: headers,
          body:data
      );

      if(response.statusCode ==201){
        return true;
      }
      else{
        return false;
      }
    } on SocketException catch (e) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Erreur survenue"),
              content: Text("Une erreur s'est produite. Veuillez réessayer plus tard."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fermer'),
                )
              ],
            );
          });
    } on FormatException catch (_) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Erreur survenue"),
              content: Text("Une erreur s'est produite. Veuillez réessayer plus tard."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fermer'),
                )
              ],
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("Erreur survenue"),
              content: Text("Une erreur s'est produite. Veuillez réessayer plus tard."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fermer'),
                )
              ],
            );
          });
    }

    return false;
  }
}
