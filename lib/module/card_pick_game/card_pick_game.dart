import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoryGameScreen(),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<String> emojis = [
    "🍎",
    "🍌",
    "🍒",
    "🍇",
    "🍉",
    "🍓",
    "🍎",
    "🍌",
    "🍒",
    "🍇",
    "🍉",
    "🍓"
  ];
  List<bool> revealed = [];
  List<int> selectedCards = [];
  bool allowSelection = true;

  @override
  void initState() {
    super.initState();
    _shuffleCards();
  }

  void _shuffleCards() {
    emojis.shuffle(Random());
    revealed = List.generate(emojis.length, (index) => false);
  }

  void _selectCard(int index) {
    if (revealed[index] || !allowSelection) return;

    setState(() {
      revealed[index] = true;
      selectedCards.add(index);
    });

    if (selectedCards.length == 2) {
      allowSelection = false;
      Future.delayed(const Duration(seconds: 1), () {
        _checkMatch();
      });
    }
  }

  void _checkMatch() {
    if (emojis[selectedCards[0]] == emojis[selectedCards[1]]) {
      // Keep the cards revealed
    } else {
      // Hide the cards again
      setState(() {
        revealed[selectedCards[0]] = false;
        revealed[selectedCards[1]] = false;
      });
    }
    setState(() {
      selectedCards.clear();
      allowSelection = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Game'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(20),
          itemCount: emojis.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _selectCard(index),
              child: Card(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    revealed[index] ? emojis[index] : "❓",
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _shuffleCards();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
