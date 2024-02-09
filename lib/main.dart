import 'package:api_learn/SignUp/ImageUpload.dart';
import 'package:api_learn/SignUp/Upload_image.dart';
import 'package:api_learn/SignUp/signUp.dart';
import 'package:api_learn/WithDio/cat.dart';
import 'package:api_learn/WithDio/threeExample.dart';
import 'package:api_learn/exampleFour.dart';
import 'package:api_learn/exampleThree.dart';
import 'package:api_learn/home_screen.dart';
import 'package:api_learn/photo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ThreeExample(),
    );
  }
}

