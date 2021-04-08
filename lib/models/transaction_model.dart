import 'package:flutter/material.dart';
import 'package:uac_token_mobile/app_theme.dart';
import 'package:uac_token_mobile/constants/constants.dart';


class TransactionModel {
  String name;
  String type;
  Color colorType;
  String signType;
  String amount;
  String information;
  String recipient;
  String date;
  String card;

  TransactionModel(this.name, this.type, this.colorType, this.signType,
      this.amount, this.information, this.recipient, this.date, this.card);
}

List<TransactionModel> transactions = transactionData
    .map((item) => TransactionModel(
        item['name'],
        item['type'],
        item['colorType'],
        item['signType'],
        item['amount'],
        item['information'],
        item['recipient'],
        item['date'],
        item['card']))
    .toList();

var transactionData = [
  {
    "name": "Outcome",
    "type": 'assets/icon/outcome_icon.svg',
    "colorType": AppTheme.primaryColor,
    "signType": "-",
    "amount": "200.000",
    "information": "Transfer to",
    "recipient": "Test test",
    "date": "12 Nov 2020",
    "card": "assets/images/logo_1_5x.png"
  },
  {
    "name": "Income",
    "type": 'assets/icon/income_icon.svg',
    "colorType": AppTheme.successColor,
    "signType": "+",
    "amount": "352.000",
    "information": "Received from",
    "recipient": "Test test",
    "date": "10 Nov 2020",
    "card": "assets/images/logo_1_5x.png"
  },
  {
    "name": "Outcome",
    "type": 'assets/icon/outcome_icon.svg',
    "colorType": AppTheme.primaryColor,
    "signType": "-",
    "amount": "53.265",
    "information": "Monthly Payment",
    "recipient": "Test test",
    "date": "09 Nov 2020",
    "card": "assets/images/logo_1_5x.png"
  }
];
