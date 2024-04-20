// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:async';

import 'package:crypto_price_news/models/news_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class News extends StatelessWidget {
  News({super.key});

  List<NewsModel> news = [];

  Future getNews() async {
    var response = await http.get(
        Uri.https("real-time-finance-data.p.rapidapi.com", "/market-trends",
            {"trend_type": "CRYPTO", "country": "us", "language": "en"}),
        headers: {
          'X-RapidAPI-Key':
              'f656fcf8a5msh98add628c792a6ep1cc543jsn376ef18bac4b',
          'X-RapidAPI-Host': 'real-time-finance-data.p.rapidapi.com'
        });

    var jsonData = jsonDecode(response.body);

    for (var newsElem in jsonData["data"]["news"]) {
      var newsData = NewsModel(
          articleTitle: newsElem["article_title"],
          articleUrl: newsElem["article_url"],
          articlePhotoUrl: newsElem["article_photo_url"],
          source: newsElem["source"]);

      news.add(newsData);
    }
  }

  @override
  Widget build(BuildContext context) {
    getNews();

    return Scaffold(
        body: FutureBuilder(
      future: getNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(news[index].articlePhotoUrl),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            news[index].articleTitle,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Text(
                        "Source - ${news[index].source}",
                        style: const TextStyle(
                            fontSize: 22, color: Colors.black38),
                      ),
                      TextButton(
                        onPressed: () {
                          launchUrlString(news[index].articleUrl);
                        },
                        child: const Text(
                          "Read more",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ));
            },
          );
        } else {
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
