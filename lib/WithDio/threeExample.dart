import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// const url = "https://jsonplaceholder.typicode.com/users";
const url = "https://api.rootnet.in/covid19-in/stats/latest";

class ThreeExample extends StatefulWidget {
  const ThreeExample({super.key});

  @override
  State<ThreeExample> createState() => _ThreeExampleState();
}

class _ThreeExampleState extends State<ThreeExample> {
  Dio dio = Dio();
  List<dynamic> userList = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      setState(() {
        userList = response.data;
      });
    } else {
      print("Error : 404");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("UserList"),
          centerTitle: true,
        ),
        body: userList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: userList.length,
            itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                    child: Card(
                      child: Column(
                        children: [
                          ReusableRow(title: 'Name', value: userList[index]['data']['regional']['loc'].toString()),
                          // ReusableRow(title: 'Email', value: userList[index]['email'].toString()),
                          // ReusableRow(title: 'Address', value: '${userList[index]['address']['city']}, ${userList[index]['address']['zipcode']}'),
                          // ReusableRow(title: 'lng', value: userList[index]['address']['geo']['lng'].toString())
                        ],
                      ),
                    ),
                  );
        }));
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
