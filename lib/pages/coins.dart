// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:async';

import 'package:crypto_price_news/models/coin_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Coins extends StatelessWidget {
  Coins({super.key});

  List<CoinModel> coins = [];

  Future getCoins() async {
    var response = await http.get(
        Uri.https("api.coingecko.com", "/api/v3/coins/markets",
            {"vs_currency": "usd"}),
        headers: {
          "x-cg-demo-api-key": "CG-HiM3eQii6kgXXUgJgSXJPJ9J",
        });

    var jsonData = jsonDecode(response.body);

    for (var coin in jsonData) {
      final coinData = CoinModel(
          symbol: coin["symbol"],
          name: coin["name"],
          currentPrice: coin["current_price"],
          image: coin["image"]);

      coins.add(coinData);
    }
  }

  @override
  Widget build(BuildContext context) {
    getCoins();

    return Scaffold(
        body: FutureBuilder(
      future: getCoins(),
      builder: (context, snapshot) {
        // if coins data present? then display them
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: coins.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                color: Colors.black12,
                child: Row(children: [
                  Image.network(
                    coins[index].image,
                    height: 70,
                    width: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${coins[index].name}(${coins[index].symbol})",
                        style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "\$${coins[index].currentPrice.toString()}",
                        style: const TextStyle(
                            color: Colors.black38,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ]),
              );
            },
          );
        }
        // coins data is not fetched yet? then show circular loader
        else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black87,
            ),
          );
        }
      },
    ));
  }
}
