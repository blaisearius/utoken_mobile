import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/screens/welcome_screen.dart';
import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:uac_token_mobile/service_principal.dart';
import 'package:uac_token_mobile/constants/constants.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:uac_token_mobile/models/card_model.dart';
import 'package:uac_token_mobile/models/transaction_model.dart';
import 'package:uac_token_mobile/models/wallet_model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timer;
  static bool checked_account = false;
  String myUsername ="";
  String _myPublic = "";

  static final DateTime now = DateTime. now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy H:m:s ');
  final String _theDate = formatter. format(now);

  final _myPasswordFieldController = TextEditingController();
  bool _validatePasswordField = true;

  _HomePageState() {
    _timer = new Timer(const Duration(milliseconds: 500), () async{
      _myPublic = await managePreferences.getWalletPublicKey();
      myUsername = await managePreferences.getPreferredUsername();
      if(_myPublic==null || _myPublic==""){
        setState(() {
          checked_account = false;
        });
      }
      else{
        setState(() {
          checked_account = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    if(checked_account == true){
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
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              // Card Account Section
              Padding(
                padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
                child: Text(
                  managePreferences.translateText('welcome_text')+' '+ myUsername,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkerText,
                  ),
                ),
              ),
              Container(
                height: 175,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    scrollDirection: Axis.horizontal,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 8),
                        height: 175,
                        width: _width * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: cards[index].bgColor,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x10000000),
                                blurRadius: 10,
                                spreadRadius: 4,
                                offset: Offset(0.0, 8.0))
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 16,
                              top: 12,
                              child: Image.asset(
                                cards[index].type,
                                height: 22,
                                width: 33,
                              ),
                            ),
                            /*Positioned(
                            right: 12,
                            top: 12,
                            child:
                            SvgPicture.asset(cards[index].cardBackground),
                          ),*/
                            Positioned(
                              top: 14,
                              right: 12,
                              child: Text(
                                cards[index].name,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: cards[index].firstColor),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 56,
                              child: Text(
                                managePreferences.translateText('your_balance_text'),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: cards[index].firstColor),
                              ),
                            ),
                            Positioned(
                                left: 16,
                                top: 55,
                                child: Row(
                                  children: [
                                    Text(
                                      'U',
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700,
                                          color: cards[index].secondColor),
                                    ),
                                    Column(
                                      children: [
                                        Padding(padding: EdgeInsets.only(top: 20)),
                                        Text(
                                          'T ',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              color: cards[index].secondColor),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      cards[index].balance,
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w700,
                                          color: cards[index].secondColor),
                                    ),
                                  ],
                                )
                            ),
                            Positioned(
                              left: 16,
                              bottom: 35,
                              child: Text(
                                managePreferences.translateText('last_refresh_text'),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: cards[index].firstColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16,
                              bottom: 12,
                              child: Text(
                                _theDate,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: cards[index].secondColor),
                              ),
                            ),
                            /*Positioned(
                            right: 8,
                            bottom: 8,
                            child: SvgPicture.asset(
                              cards[index].moreIcon,
                              height: 24,
                              width: 24,
                            ),
                          )*/
                          ],
                        ),
                      );
                    }),
              ),

              // Last Transaction Section
              Padding(
                  padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        managePreferences.translateText('last_transactions_text'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.darkerText,
                        ),
                      ),
                      Text(
                        managePreferences.translateText('see_all_transactions_text'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 190,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 190,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.greenColor, width: 1),
                        color: AppTheme.notWhite,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x04000000),
                              blurRadius: 10,
                              spreadRadius: 10,
                              offset: Offset(0.0, 8.0))
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 16,
                            left: 16,
                            child: SvgPicture.asset(transactions[index].type),
                            height: 24,
                            width: 24,
                          ),
                          /*Positioned(
                          right: 8,
                          top: 8,
                          child:
                          SvgPicture.asset('assets/svg/mastercard_bg.svg'),
                        ),*/
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Text(
                              transactions[index].name,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: transactions[index].colorType),
                            ),
                          ),
                          Positioned(
                            top: 64,
                            left: 16,
                            child: Text(
                              transactions[index].signType +
                                  app_symbol + ' '+
                                  transactions[index].amount,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: transactions[index].colorType),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 106,
                            child: Text(
                              transactions[index].information,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.secondaryColor),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 48,
                            child: Text(
                              transactions[index].recipient,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.darkerText),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 22,
                            child: Text(
                              transactions[index].date,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.secondaryColor),
                            ),
                          ),
                          Positioned(
                            right: 14,
                            bottom: 16,
                            child: Image.asset(
                              transactions[index].card,
                              height: 22,
                              width: 33,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Top Up Section
              Padding(
                padding:
                EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                child: Text(
                  managePreferences.translateText('accounts_text'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkerText,
                  ),
                ),
              ),
              Container(
                height: 90,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      height: 68,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.greenColor, width: 0.5),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x04000000),
                                blurRadius: 10,
                                spreadRadius: 10,
                                offset: Offset(0.0, 8.0))
                          ],
                          color: AppTheme.notWhite),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 12,
                              ),
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.nearlyWhite,
                                  image: DecorationImage(
                                    image: AssetImage(wallets[index].walletLogo),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    myUsername+"'s Wallet",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.darkerText),
                                  ),
                                  Text(
                                    _myPublic,
                                    style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.secondaryColor),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )
                            ],
                          ),
                          /*Row(
                            children: <Widget>[
                              Text(
                                "'s Wallet",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.secondaryColor),
                              ),
                              SizedBox(
                                width: 16,
                              )
                            ],
                          )*/
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    else{
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
            padding: EdgeInsets.only(left: 10, top: 1, bottom: 16, right: 10),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                  child: SizedBox(
                    child: Image(
                      image: AssetImage(
                        'assets/images/lock.png',
                      ),
                      width: 20,
                    ),
                  ),
                  margin: EdgeInsets.only(left: 70, right: 70),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 1, bottom: 16),
                  child: Text(
                    managePreferences.translateText('wallet_load_text')+' ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkerText,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
                  child: _entryField(managePreferences.translateText('wallet_password_text'), this._myPasswordFieldController, isPassword: true, validation: this._validatePasswordField),
                ),
                SizedBox(height: 10),
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
                hintText: managePreferences.translateText('wallet_enter_password_text'),
                helperText: managePreferences.translateText('wallet_password_help_text'),
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
        String password = this._myPasswordFieldController.text;
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

        if(this._validatePasswordField){
          bool result = await loadWallet(password);
          if(result==true){
            /*Navigator.pushReplacement(
              //context, MaterialPageRoute(builder: (context) => HomePage()));
                context, MaterialPageRoute(builder: (context) => WelcomePage()));*/
            setState(() {
              checked_account = true;
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


  Future<bool> setupWallet(String wallet_name, String wallet_password) async{
    String register_url = api_url+"/api/wallet/setup";
    //Map<String, String> headers = {"Content-type": "application/json"};
    String data = '{"encryption_password": "'+wallet_password+'", '+'"wallet_name": "'+wallet_name+'"}';
    String access = await managePreferences.getPreferredToken();

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
      print(json.decode(response.body));
      if(response.statusCode ==201){
        await managePreferences.setWalletPrivateKey(json.decode(response.body)['private']);
        await managePreferences.setWalletPublicKey(json.decode(response.body)['address']);
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


  Future<bool> loadWallet(String wallet_password) async{
    String access = await managePreferences.getPreferredToken();
    //print(wallet_password);
    String register_url = api_url+"/api/wallet/load";
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
        //print(json.decode(response.body)['data']);
        String theUsername = await managePreferences.getPreferredUsername() ;
        bool setupResponse = await setupWallet(theUsername+" Wallet", wallet_password);
        if(setupResponse ==true){
          return true;
        }
        else{
          return false ;
        }
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
