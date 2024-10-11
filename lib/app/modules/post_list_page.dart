import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/api_service.dart';
import '../data/post_model.dart';
import 'webview_page.dart';

class PostListPage extends StatelessWidget {
  final ApiService apiService = Get.put(ApiService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Codelab'),
        actions: [
          IconButton(
            icon: Icon(Icons.newspaper),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewPage(
                    url: 'https://youtu.be/dQw4w9WgXcQ?si=2SJSiRJBrzjTxyCW',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: apiService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data != null) {
              final Welcome? welcome = Welcome.fromJson(snapshot.data!);
              if (welcome != null) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: welcome.articles.length,
                  itemBuilder: (context, index) {
                    final article = welcome.articles[index];
                    return Card(
                      child: Column(
                        children: [
                          Image.network(article.urlToImage),
                          Text(
                            article.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            article.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('No posts found'));
              }
            } else {
              return Center(child: Text('No data found'));
 }
          }
        },
      ),
    );
  }
}