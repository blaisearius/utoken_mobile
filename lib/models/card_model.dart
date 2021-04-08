import 'package:flutter/material.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/constants/constants.dart';


class CardModel {
  String name;
  String type;
  String balance;
  String valid;
  String lastUpdated;
  String moreIcon;
  String cardBackground;
  Color bgColor;
  Color firstColor;
  Color secondColor;

  CardModel(this.name, this.type, this.balance, this.valid, this.lastUpdated, this.moreIcon,
      this.cardBackground, this.bgColor, this.firstColor, this.secondColor);
}

List<CardModel> cards = cardData
    .map((item) => CardModel(
        item['name'],
        item['type'],
        item['balance'],
        item['valid'],
        item['lastUpdated'],
        item['moreIcon'],
        item['cardBackground'],
        item['bgColor'],
        item['firstColor'],
        item['secondColor']))
    .toList();

var cardData = [
  {
    "name": "",
    "type": "assets/images/logo_1_5x.png",
    "balance": "48.000",
    "valid": "06/24",
    "lastUpdated": "04/12/2020 11h:38",
    "bgColor": AppTheme.greenColor,
    "firstColor": AppTheme.white,
    "secondColor": AppTheme.white
  }
];
