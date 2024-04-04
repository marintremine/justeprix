
class Resultat {
  int? id;
  String user;
  String difficulte;
  String datetime;
  int temps;
  int victoire;
  int id_O;

  Resultat({this.id,required this.user,required this.difficulte,required this.datetime,required this.temps,required this.victoire,required this.id_O});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'user': user,
      'difficulte': difficulte,
      'datetime': datetime,
      'temps': temps,
      'victoire': victoire,
      'id_O': id_O,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Resultat.fromMap(Map<String, Object?> map) : this(
    id: map['id'] as int,
    user: map['user'] as String,
    difficulte: map['difficulte'] as String,
    datetime: map['datetime'] as String,
    temps: map['temps'] as int,
    victoire: map['victoire'] as int,
    id_O: map['id_O'] as int,
  );

  @override
  String toString() {
    return 'Resultat{id: $id, user: $user, niveau: $difficulte, datetime: $datetime, id_O: $id_O}';
  }

}