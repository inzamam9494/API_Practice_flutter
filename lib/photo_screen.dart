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
 final photos = [];

  @override
  void initState() {
    super.initState();
    fetchPhoto();
  }

  Future<void> fetchPhoto() async {
    final response = await dio.get(link);
    if (response.statusCode == 200) {
      for (final item in response.data) {
        photos.add(item);
      }
      setState(() {});
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
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${photos[index]['title']}"),
              leading: Image.network("${photos[index]['url']}"),
            );
          },
        ));
  }
}
