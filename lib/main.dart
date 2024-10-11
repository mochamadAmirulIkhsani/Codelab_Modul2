import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/modules/post_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Codelab Modul 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListPage(),
    );
  }
}