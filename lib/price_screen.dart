import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'price.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String cur = 'USD';
  String bprice = '?';
  String eprice = '?';
  String lprice = '?';

  CupertinoPicker picker() {
    List<Widget> l = [];
    for (String c in currenciesList) {
      l.add(
        Text(
          c,
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30.0,
      onSelectedItemChanged: (index) {
        print(index);
        getPrice();
      },
      children: l,
    );
  }

  Widget getDropDown() {
    int i;
    List<DropdownMenuItem<String>> l = [];
    for (i = 0; i < currenciesList.length; i++) {
      var item = DropdownMenuItem(
        child: Text(
          currenciesList[i],
          style: TextStyle(color: Colors.white),
        ),
        value: currenciesList[i],
      );
      l.add(item);
    }
    return DropdownButton<String>(
      value: cur,
      items: l,
      onChanged: (value) {
        setState(() {
          bprice = lprice = eprice = '?';
          cur = value;
        });
        getPrice();
      },
    );
  }

  void getPrice() async {
    try {
      var val = await CoinPrice(bitCoin: 'BTC', currency: cur).getPrice();
      var val1 = await CoinPrice(bitCoin: 'ETH', currency: cur).getPrice();
      var val2 = await CoinPrice(bitCoin: 'LTC', currency: cur).getPrice();
      setState(() {
        bprice = val.toStringAsFixed(0);
        eprice = val1.toStringAsFixed(0);
        lprice = val2.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 BTC = $bprice $cur',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 ETH = $eprice $cur',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 LTC = $lprice $cur',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? getDropDown() : picker(),
          ),
        ],
      ),
    );
  }
}
