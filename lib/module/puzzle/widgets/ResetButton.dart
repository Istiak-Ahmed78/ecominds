import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  VoidCallback reset;
  String text;

  ResetButton(this.reset, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: reset,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
      child: const Text("Reset"),
    );
  }
}
