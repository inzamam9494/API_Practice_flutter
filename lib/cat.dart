import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CatPage extends StatefulWidget {
  const CatPage({super.key});

  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  Dio dio = Dio();
  List<String> text = <String>[];
  int index = 0;

  @override
  void initState() {
    super.initState();
    fetchCatFact();
  }

  Future<void> fetchCatFact() async {
    const String url = 'https://cat-fact.herokuapp.com/facts';
    final response = await dio.get(url);
    if(response.statusCode == 200) {
      List<String> result = List<String>.empty(growable: true);
      for(final fact in response.data) {
        result.add(fact['text']);
      }
      setState(() {
        text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Facts'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
    setState(() {
    index = index + 1 < text.length ? index + 1 : 0;
    });
    },
      child: const Icon(Icons.refresh),
    ),
    body: Padding(
    padding: const EdgeInsets.all(64.0),
    child: Center(
    child: text.isNotEmpty
    ? Text(text[index])
        : const CircularProgressIndicator(),
    ),
    ),
    );
  }
}
