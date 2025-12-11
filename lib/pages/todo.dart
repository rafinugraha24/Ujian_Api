import 'package:flutter/material.dart';

class todo extends StatelessWidget {
  const todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO LIST'), backgroundColor: Colors.amber),
    );
  }
}
