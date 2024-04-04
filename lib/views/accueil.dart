import 'package:flutter/material.dart';
import 'package:justeprix2/controllers/router.dart';
import 'package:justeprix2/data/database_helper.dart';
import 'package:justeprix2/models/objet.dart';
import 'package:justeprix2/models/resultat.dart';


class AccueilPage extends StatefulWidget {
  const AccueilPage({Key? key}) : super(key: key);

  @override
  State<AccueilPage> createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  TextEditingController _nomController = TextEditingController();

  String _selectedDifficulty = 'Facile';

  void _handleRadioValueChanged(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedDifficulty = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juste Prix'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage('assets/logo.png')),
            Text(
              'Nom',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                hintText: 'Entrez votre nom',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Difficulté',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                RadioListTile(
                  title: Text('Facile'),
                  value: 'Facile',
                  groupValue: _selectedDifficulty,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile(
                  title: Text('Normal'),
                  value: 'Normal',
                  groupValue: _selectedDifficulty,
                  onChanged: _handleRadioValueChanged,
                ),
                RadioListTile(
                  title: Text('Difficile'),
                  value: 'Difficile',
                  groupValue: _selectedDifficulty,
                  onChanged: _handleRadioValueChanged,
                ),
              ],
            ),
            SizedBox(height: 20.0),

            ElevatedButton(
              onPressed: () {
                String nom = _nomController.text;
                if (nom.isNotEmpty) {
                  print('Nom saisi : $nom');
                  NavigationHelper.router.goNamed('jeu', pathParameters: {'nom': nom, 'difficulty': _selectedDifficulty});
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erreur'),
                        content: Text('Veuillez entrer votre nom.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Jouer'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.router.pushNamed('regles');
              },
              child: const Text('Règles'),
            ),
            ElevatedButton(
              onPressed: () {
                String nom = _nomController.text;
                if (nom.isNotEmpty) {
                  print('Nom saisi : $nom');
                  NavigationHelper.router.pushNamed('classement', pathParameters: {'nom': nom});
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erreur'),
                        content: Text('Veuillez entrer votre nom.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Classement'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }
}