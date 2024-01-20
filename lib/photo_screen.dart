import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/photoApi_model.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhotos() async {
    const url = "https://jsonplaceholder.typicode.com/photos";
    const url2 = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(Uri.parse(url2));
    var data = JsonDecoder(response.body.toString());
    if (response.statusCode == 200) {
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Photos"),
      ),
    );
  }
}
