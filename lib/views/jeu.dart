import 'dart:math';

import 'package:flutter/material.dart';
import 'package:justeprix2/controllers/router.dart';
import 'dart:async';

import 'package:justeprix2/models/resultat.dart';

import '../data/database_helper.dart';
import '../models/objet.dart';

class JeuPage extends StatefulWidget {
  final String nom;
  final String difficulty;

  const JeuPage({Key? key, required this.nom, required this.difficulty})
      : super(key: key);

  @override
  State<JeuPage> createState() => _JeuPageState();
}

class _JeuPageState extends State<JeuPage> {
  late Objet randomObject;
  late int _objectPrice;
  late String _objectName;
  late String _objectDescription;
  late String _objectImage;
  late int _timeLeft;
  late int _time;

  Future<Objet> getRandomObject() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<Objet> objets = await dbHelper.getAllObjet();
    int randomIndex = Random().nextInt(objets.length);
    Objet randomObject = objets[randomIndex];
    return randomObject;
  }

  Future<void> _initializeRandomObject() async {
    randomObject = await getRandomObject();
    setState(() {
      _objectPrice = randomObject.prix;
      _objectName = randomObject.nom;
      _objectDescription = randomObject.description;
      _objectImage = randomObject.image;
    });
  }
  void _initializeDifficulty() {
    if (widget.difficulty == 'Facile') {
      _timeLeft = 60;
      _time = 60;
    } else if (widget.difficulty == 'Moyen') {
      _timeLeft = 45;
      _time = 45;
    } else {
      _timeLeft = 30;
      _time = 30;
    }
  }




  int _countdown = 3;




  bool _gameOver = false;
  bool _gameWon = false;

  TextEditingController _controller = TextEditingController();
  String _hintText = '';



  @override
  void initState() {
    super.initState();
    _initializeRandomObject();
    _initializeDifficulty();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();
          startTimer();
        }
      });
    });
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0 && !_gameOver && !_gameWon) {
          _timeLeft--;
        } else {
          timer.cancel();
          if (!_gameOver && !_gameWon) {
            endGame();
            storeResult();
          }
        }
      });
    });
  }

  void storeResult() {
    Resultat resultat = Resultat(
      user: widget.nom,
      difficulte: widget.difficulty,
      datetime: DateTime.now().toString(),
      victoire: _gameWon ? 1 : 0,
      temps: _timeLeft,
      id_O: 1,
    );

    DatabaseHelper dbHelper = DatabaseHelper();
    dbHelper.insertResultat(resultat);
  }

  void checkPrice() {
    if (_gameOver || _gameWon) return;

    int userPrice = int.tryParse(_controller.text) ?? 0;
    if (userPrice > _objectPrice) {
      setState(() {
        _hintText = 'Le prix est plus bas';
      });
    } else if (userPrice < _objectPrice) {
      setState(() {
        _hintText = 'Le prix est plus haut';
      });
    } else {
      setState(() {
        _gameWon = true;
      });
    }
  }

  void endGame() {
    setState(() {
      _gameOver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Jeu'),
      ),
      body: Center(
        child:
        _gameOver || _gameWon
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _gameWon
                  ? 'Félicitations ! Vous avez trouvé le juste prix en ${_time - _timeLeft} secondes !'
                  : 'Désolé, vous avez perdu ! Le juste prix était $_objectPrice euros.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.router.goNamed('accueil');
              },
              child: Text('Accueil'),
            ),
            ElevatedButton(
              onPressed: () {
                NavigationHelper.router.pushNamed('classement', pathParameters: {'nom': widget.nom});
              },
              child: Text('Classement'),
            ),
            //ElevatedButton(
            //  onPressed: () {
            //    print(widget.nom);
            //    print(widget.difficulty);
            //    NavigationHelper.router.goNamed('jeu', pathParameters: {'nom': widget.nom, 'difficulty': widget.difficulty});
            //    print('Rejouer');
            //  },
            //  child: Text('Rejouer'),
            //),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _countdown > 0 ? '$_countdown' : '',
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            _countdown == 0
                ? Column(
              children: [
                Image(image: AssetImage('assets/$_objectImage'),
                  width: 200,
                  height: 200,
                ),
                Text(_objectName, style: TextStyle(fontSize: 24)),
                Text(_objectDescription, style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Padding(padding: EdgeInsets.all(20)
                  ,child:
                    TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Entrez le prix',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    checkPrice();
                    if (_gameWon){
                      storeResult();
                    };
                    _controller.text = '';
                  },
                  child: Text('Valider'),
                ),
                SizedBox(height: 10),
                Text(_hintText),
                SizedBox(height: 20),
                Text('Temps restant: $_timeLeft secondes'),
              ],
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
