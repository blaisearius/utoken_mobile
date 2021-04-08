import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:uac_token_mobile/service_principal.dart';
import 'package:uac_token_mobile/constants/constants.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:uac_token_mobile/models/card_model.dart';
import 'package:uac_token_mobile/models/transaction_model.dart';
import 'package:uac_token_mobile/models/wallet_model.dart';


class SendTokenPage extends StatefulWidget {
  @override
  _SendTokenPageState createState() => _SendTokenPageState();
}

class _SendTokenPageState extends State<SendTokenPage> {

  final _myAddressFieldController = TextEditingController();
  bool _validateAddressField = true;

  final _myPasswordFieldController = TextEditingController();
  bool _validatePasswordField = true;

  final _myAmountFieldController = TextEditingController();
  bool _validateAmountField = true;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppTheme.white,
        appBar: AppBar(
          backgroundColor: AppTheme.headerBGColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.transparent,
            ),
            onPressed: () {},
            padding: EdgeInsets.only(left: 8),
          ),
          title: Text(
            managePreferences.translateText("app_title"),
            style: TextStyle(
                fontSize: 25.0,
                color:AppTheme.white,
                fontFamily: AppTheme.fontName
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 16, right: 10),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 1, bottom: 16),
                  child: Text(
                    managePreferences.translateText('transfert_description_text')+' ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkerText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 2, bottom: 2),
                  child: _entryField(managePreferences.translateText('wallet_address_text'), this._myAddressFieldController, isPassword: false, validation: this._validatePasswordField),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 2, bottom: 16),
                  child: _entryField(managePreferences.translateText('amount_text'), this._myAmountFieldController, isPassword: false, validation: this._validatePasswordField),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 2, bottom: 16),
                  child: _entryField(managePreferences.translateText('wallet_password_text'), this._myPasswordFieldController, isPassword: true, validation: this._validatePasswordField),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 2, bottom: 5, right: 20),
                  child: _submitButton(),
                )
              ],
            ),
          ),
        )
    );
  }



  Widget _entryField(String title, TextEditingController controller, {bool isPassword = false, bool validation}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                //border: InputBorder.none,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: AppTheme.greenColor)),
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff235D1F).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff235D1F), Color(0xff235D1F)])),
        child: Text(
          "Send",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async{
        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
        */
        String address = this._myAddressFieldController.text;
        String password = this._myPasswordFieldController.text;
        String amount = this._myAmountFieldController.text;

        if(address ==null || address==""){
          setState(() {
            this._validateAddressField=false;
          });
        }
        else{
          setState(() {
            this._validateAddressField=true;
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

        if(amount ==null || amount==""){
          setState(() {
            this._validateAmountField=false;
          });
        }
        else{
          setState(() {
            this._validateAmountField=true;
          });
        }

        if(this._validateAddressField && this._validatePasswordField && this._validateAmountField){
          bool result = await sendTransaction(address, password, amount);
          if(result==true){
            /*Navigator.pushReplacement(
              //context, MaterialPageRoute(builder: (context) => HomePage()));
                context, MaterialPageRoute(builder: (context) => WelcomePage()));*/
            setState(() {

            });
          }
          else{
            setState(() {

            });
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Error while loading"),
                    content: Text("Can't load account."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      )
                    ],
                  );
                });
          }
        }
        else{
          setState(() {
            //visibleCircularProgress = 0;
          });
        }
      },
    );
  }


  Future<bool> sendTransaction(String address, String wallet_password, String amount) async{
    return false;
    String access = await managePreferences.getPreferredToken();
    //print(wallet_password);
    String register_url = api_url+"/api/666666/load";
    String data = '{"encryption_password": "'+wallet_password+'"}';

    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': "Bearer " + access
    };

    try {
      var response = await http.post(
          register_url,
          headers: headers,
          body:data
      );

      /*print(response.statusCode);
      print(data);
      print(json.decode(response.body)); */
      if(response.statusCode ==200){
        print(json.decode(response.body)['data']['decryptedWallet']);
        await managePreferences.setWalletPrivateKey(json.decode(response.body)['data']['decryptedWallet'][0]['private']);
        await managePreferences.setWalletPublicKey(json.decode(response.body)['data']['decryptedWallet'][0]['address']);
        return true ;
      }
      else if(response.statusCode ==404 || response.statusCode ==500){
        return false ;
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
