import 'dart:convert';

import 'package:api_learn/Models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<Map>?> postList ;


  @override
  void initState() {
    super.initState();
    postList = getPostApi();
  }

  Future<List<Map>?> getPostApi () async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    List<Map<String, dynamic>> data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Practice"),
      ),
      body: Column(
        children: [
          FutureBuilder(future: postList,
              builder: (context,snapshot){
                if(snapshot.hasData && snapshot.data != null){
                  return ListView.builder(itemBuilder: (context,index){
                    PostsModel postModel = PostsModel.fromJson(snapshot.data?[index]);
                    return ListTile(title: Text(postModel.title));
                  }
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              })
        ],
      ),
    );;
  }
}
