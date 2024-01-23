import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Models/userModel.dart';

const url = "https://jsonplaceholder.typicode.com/users";

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUser() async {
    final response = await get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map<String,dynamic> i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User ID"),
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
           if(!snapshot.hasData){
             return const CircularProgressIndicator();
           }
           else{
             return ListView.builder(
               itemCount: userList.length,
                 itemBuilder: (context,index){
                 return Card(
                   child: Column(
                     children: [
                       ReusableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                       ReusableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                       ReusableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()),
                       ReusableRow(title: 'lng', value: snapshot.data![index].address!.geo!.lng.toString())
                     ],
                   ),
                 );
                 });
           }
        },
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
   const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),),
          Text(value)
        ],
      ),
    );
  }
}
