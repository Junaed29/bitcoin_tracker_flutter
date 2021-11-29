import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = "https://rest.coinapi.io/v1/exchangerate/";

class NetworkHelper {
  Future<String> getCryptoRate(String cryptoType, String currencyType) async {
    var response = await http.get(Uri.parse(
        "$baseUrl$cryptoType/$currencyType?apikey=3D510B26-610A-460C-B0D1-7A80780E2450"));

    var data = await jsonDecode(response.body);

    Duration duration = const Duration(milliseconds: 100);

    print("$cryptoType $currencyType");
    if (data["rate"] == null) {
      print(response.statusCode);
    } else
      print(data["rate"]);

    var rate = data["rate"];
    //double rate = 123.222;
    return rate.toString() /*.toStringAsFixed(2)*/;
  }
}
