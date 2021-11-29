import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '3D510B26-610A-460C-B0D1-7A80780E2450';

class CoinData {
  Future<String> getCryptoRate(String cryptoType, String currencyType) async {
    var response = await http.get(Uri.parse(
        "$coinAPIURL$cryptoType/$currencyType?apikey=3D510B26-610A-460C-B0D1-7A80780E2450"));

    var data = await jsonDecode(response.body);

    Duration duration = const Duration(milliseconds: 100);

    print("$cryptoType $currencyType");
    if (data["rate"] == null) {
      print(response.statusCode);
    } else {
      print(data["rate"]);
    }

    double rate = data["rate"];
    //double rate = 123.222;
    return rate.toStringAsFixed(2);
  }
}
