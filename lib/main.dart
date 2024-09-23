import 'package:ecominds/binding.dart';
import 'package:ecominds/module/card_pick_game/card_pick_game.dart';
import 'package:ecominds/module/mcq/view/mcq_view.dart';
import 'package:ecominds/module/puzzle/view/Board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: GlobalBinding(),
      home: MemoryGameScreen(),
    );
  }
}
