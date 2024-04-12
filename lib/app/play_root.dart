import 'package:flutter/material.dart';
import 'package:playxenos/app/pages/home_page.dart';

class PlayRoot extends StatelessWidget {
  const PlayRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlAY XENOS MUSIC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
