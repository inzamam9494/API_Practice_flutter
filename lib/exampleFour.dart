import 'dart:convert';

import 'package:flutter/material.dart';
import 'Models/productModels.dart';
import 'package:http/http.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  
  Future<ProductModel> getProductApi() async{
    final response = await get(Uri.parse('https://webhook.site/6434a8e8-d3b1-4675-aa54-e175cde94428'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductModel.fromJson(data);
    }else{
      return ProductModel.fromJson(data);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Api'),
        centerTitle: true,
      ),
      body: FutureBuilder<ProductModel>(
          future: getProductApi(),
           builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index){
                  return Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data!.data![index].shop!.name.toString()),
                        subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*.2,
                        width: MediaQuery.of(context).size.width* 1,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.data![index].images!.length,
                            itemBuilder: (context,position){
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height* .20,
                                  width: MediaQuery.of(context).size.width* .5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                    )
                                  ),
                                ),
                              );
                            }),
                      ),
                      Icon(snapshot.data!.data![index].inWishlist! == true? Icons.favorite_outline:Icons.favorite)
                    ],
                  );
                  });
            }else{
              return const Center(child: CircularProgressIndicator());
            }
      }),
    );
  }
}
