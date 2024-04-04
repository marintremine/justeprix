import 'package:flutter/material.dart';
import '../models/objet.dart';
import '../models/resultat.dart';
import '../data/database_helper.dart';

class ClassementPage extends StatefulWidget {
  final String nom;

  const ClassementPage({Key? key, required this.nom}) : super(key: key);



  @override
  State<ClassementPage> createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage> {
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classement'),
      ),
      body: FutureBuilder<List<Resultat>>(
        future: dbHelper.getResultatByUser(widget.nom),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final results = snapshot.data!;
            return ListView.builder(

              itemCount: results.length,
              itemBuilder: (context, index) {
                final resultat = results[index];

                return ListTile(
                  title: Text('${resultat.victoire == 1 ? 'Victoire' : 'Défaite'} - ${resultat.difficulte}'),
                  subtitle: Text('${resultat.datetime.substring(0, 10)} - ${resultat.user}'),
                  trailing: Text('${resultat.temps} secondes'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
