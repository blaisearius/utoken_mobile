import 'package:flutter/material.dart';
import 'package:uac_token_mobile/constants/constants.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:uac_token_mobile/screens/login_screen.dart';
import 'package:uac_token_mobile/screens/welcome_screen.dart';
import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:uac_token_mobile/service_principal.dart';


class LoginService {
  String user_info_url = api_url+"/api/users/me";
  Future<bool> verifyAccessToken(BuildContext context) async {
    String access = await managePreferences.getPreferredToken();
    print(access);
    if((access=="") || (access==null)){
      return false;
      /*Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomePage())); */
    }
    else{
      try {
        var response = await http.get(user_info_url,
            headers: {HttpHeaders.authorizationHeader: "Bearer " + access});
        print(response.statusCode);
        if (response.statusCode == 200) {
          return true;
        }
        else if (response.statusCode == 401) {
          return false;
          /*Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomePage()));*/
        }
        else if (response.statusCode == 403) {
          return false;
          /*Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomePage()));*/
        }
        else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Erreur survenue"),
                  content: Text(
                      "Une erreur s'est produite. Veuillez réessayer plus tard."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Fermer'),
                    )
                  ],
                );
              });
          return false;
        }
      } on SocketException catch (e) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Erreur survenue !"),
                content: Text("Une erreur s'est produite. Veuillez réessayer plus tard."),
                actions: <Widget>[
                  FlatButton(
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
                  FlatButton(
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
                content: Text(
                    "Une erreur s'est produite. Veuillez réessayer plus tard."),
                actions: <Widget>[
                  FlatButton(
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
  }

}
