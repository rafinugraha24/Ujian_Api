import 'package:flutter/material.dart';
import 'package:rafi_2407810040008_ujian_api/pages/register.dart';


void main(List<String> args) {
    runApp(MyApp());  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/" : (context)=>register(),                                                              
        // "/halaman2" : (context)=>Page2()
        },
      // initialRoute: "/", 
      // home: Login()
      );
  }
}