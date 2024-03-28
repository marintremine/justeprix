import 'package:flutter/material.dart';

class JeuPage extends StatefulWidget {


  final String nom; // Declare nom as a property

  const JeuPage({Key? key, required this.nom}) : super(key: key);


  @override
  State<JeuPage> createState() => _JeuPageState();
}

class _JeuPageState extends State<JeuPage>{

  @override
  Widget build(BuildContext context){


    return Scaffold(
        appBar: AppBar(
          title: Text('Jeu : Juste Prix'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
              //get nom
                'Bonjour ${widget.nom} !',
              ),
            ],
          ),
        )
    );
  }
}