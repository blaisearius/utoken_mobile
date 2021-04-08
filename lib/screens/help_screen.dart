import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/services/execute_request.dart';
import 'package:uac_token_mobile/manage_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uac_token_mobile/constants/constants.dart';




class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
            Container(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16),
              child: Image.asset('assets/images/helpImage.png', width: 50,),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    managePreferences.translateText("help_content_text"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    managePreferences.translateText('utoken_help_content'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Container(
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.greenColor,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          final link = WhatsAppUnilink(
                            phoneNumber: app_phone_number,
                            text: "",
                          );
                          await launch('$link');
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(Icons.message, color: AppTheme.white,),
                                Padding( padding: const EdgeInsets.only(right: 2.0),),
                                Text(
                                  "  "+managePreferences.translateText('chat_whatsapp'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
