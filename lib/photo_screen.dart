import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/photoApi_model.dart';

const link = "https://jsonplaceholder.typicode.com/photos";

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  Dio dio = Dio();
  List<String> title = <String>[];
  List<String> url = <String>[];
  int index = 0;

  @override
  void initState() {
    super.initState();
    fetchPhoto();
  }

  Future<void> fetchPhoto() async {
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      List<String> result = List<String>.empty(growable: true);
      List<String> result2 = List<String>.empty(growable: true);
      for (final photos in response.data) {
        result.add(photos['title']);
      }
      for (final photos in response.data) {
        result2.add(photos['url']);
      }
      setState(() {
        title = result;
        url = result2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Photos"),
        ),
        body: ListView.builder(
          itemCount: title.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(title[index]),
              leading: Image.network(url[index]),
            );
          },
        ));
  }
}
