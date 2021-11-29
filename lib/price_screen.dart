import 'package:bitcoin_tracker_flutter/coin_data.dart';
import 'package:bitcoin_tracker_flutter/network_helper.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  NetworkHelper networkHelper = NetworkHelper();
  String selectedCurrency = currenciesList.first;
  List<Widget> circularButtonList = [];

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> itemList = [];
    for (var i = 0; i < currenciesList.length; i++) {
      var item = DropdownMenuItem(
        child: Text(currenciesList[i]),
        value: currenciesList[i],
      );
      itemList.add(item);
    }
    return itemList;
  }

  void getCurrencyData(String selectedCrypto, String selectedCurrency) async {
    String rate =
        await networkHelper.getCryptoRate(selectedCrypto, selectedCurrency);
    setState(() {
      circularButtonList
          .add(buildCircularButton(selectedCrypto, selectedCurrency, rate));
    });
  }

  void addDataToUI(String selectedCurrency) async {
    for (String cryptoType in cryptoList) {
      getCurrencyData(cryptoType, selectedCurrency);
    }
  }

  @override
  void initState() {
    addDataToUI(selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    getDropDownItems();
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: circularButtonList,
          )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                circularButtonList.clear();
                setState(() {
                  selectedCurrency = value!;
                });
                addDataToUI(selectedCurrency);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircularButton(
      String selectedCrypto, String selectedCurrency, String rate) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $selectedCrypto = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
