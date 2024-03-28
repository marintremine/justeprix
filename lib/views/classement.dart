import 'package:flutter/material.dart';

class ClassementPage extends StatefulWidget{
  const ClassementPage({Key? key}) : super(key: key);
  @override
  State<ClassementPage> createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage>{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Classement',
              ),
            ],
          ),
        )
    );
  }
}