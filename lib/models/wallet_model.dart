class WalletModel {
  String name;
  String wallet;
  String walletLogo;
  String walletNumber;

  WalletModel(this.name, this.wallet, this.walletLogo, this.walletNumber);
}

List<WalletModel> wallets = walletData
    .map((item) => WalletModel(
        item['name'], item['wallet'], item['walletLogo'], item['walletNumber']))
    .toList();

var walletData = [
  {
    "name": "Compte 1",
    "wallet": "Jupiter wallet",
    "walletLogo": 'assets/images/logo_1_5x.png',
    "walletNumber": '+62*** **** 1932'
  },
];
