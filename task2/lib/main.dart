import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task2/homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options:const  FirebaseOptions(apiKey: "AIzaSyDdvgWez6JlheIt-s34WMDotvH08MTkfQ0",
      projectId: "todolist-2e5a8",
      messagingSenderId: "121644975948",
      appId: "1:121644975948:web:02272468ce9b1b108fb1e9",),
      );
      FirebaseFirestore.instance.settings=Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDO',
      home: const MyHomePage(),
    );
  }
}
