import 'package:flutter/material.dart';

class ReglesPage extends StatefulWidget {
  const ReglesPage({Key? key}) : super(key: key);

  @override
  State<ReglesPage> createState() => _ReglesPageState();
}

class _ReglesPageState extends State<ReglesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Règles'),
      ),
      body: const Center(
        child: Text('Voici les règles du jeu'),
      ),
    );
  }
}