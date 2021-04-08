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


class TransactionPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TransactionPage> {
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
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            // Card Account Section
            Padding(
              padding: EdgeInsets.only(left: 24, top: 20, bottom: 16),
              child: Text(
                'List all transactions here !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.darkerText,
                ),
              ),
            ),
            Container(
              height: 175,

            ),

            // Last Transaction Section
            /*Padding(
                padding:
                EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Last Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.darkerText,
                      ),
                    ),

                  ],
                )),*/
          ],
        ),
      ),
    );
  }
}
