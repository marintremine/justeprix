import 'package:flutter/material.dart';
import 'package:justeprix2/controllers/router.dart';

class AccueilPage extends StatefulWidget{
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
        title: Text('Entrez votre nom'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Nom :',
              style: TextStyle(fontSize: 20.0),
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
            ElevatedButton(
              onPressed: () {
                String nom = _nomController.text;
                if (nom.isNotEmpty) {
                  // Ici vous pouvez envoyer le nom à où vous le souhaitez
                  print('Nom saisi : $nom');
                  NavigationHelper.router.pushNamed('jeu', pathParameters: {'nom': nom});
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
              child: Text('Valider'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                RadioListTile(
                  title: Text('Personnalisé'),
                  value: 'Personnalisé',
                  groupValue: _selectedDifficulty,
                  onChanged: _handleRadioValueChanged,
                ),
              ],
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


