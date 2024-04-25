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
        Uri.https(
          "crypto-news34.p.rapidapi.com",
          "/news",
        ),
        headers: {
          'X-RapidAPI-Key':
              'f656fcf8a5msh98add628c792a6ep1cc543jsn376ef18bac4b',
          'X-RapidAPI-Host': 'crypto-news34.p.rapidapi.com'
        });

    var jsonData = jsonDecode(response.body);

    for (var newsElem in jsonData) {
      var newsData = NewsModel(
          articleTitle: newsElem["title"],
          articleUrl: newsElem["url"],
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
              return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      // Image.network(
                      //   news[index].articlePhotoUrl,
                      // ),
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
                            fontSize: 20, color: Colors.black45),
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
