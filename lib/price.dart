import 'package:bitcoin_ticker/network.dart';

const coinApi = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '04428AB8-E652-4E5A-B8DD-1F95D300000C';

class CoinPrice {
  final String bitCoin, currency;
  CoinPrice({this.bitCoin, this.currency});

  Future getPrice() async {
    var data = await Network(url: '$coinApi/$bitCoin/$currency?apikey=$apiKey')
        .getData();
    return data['rate'];
  }
}
