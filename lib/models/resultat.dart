// lib/models/resultat.dart
class Resultat {
  int id;
  String user;
  String niveau;
  String datetime;
  int Id_O;

  Resultat({required this.id,required this.user,required this.niveau,required this.datetime,required this.Id_O});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'user': user,
      'niveau': niveau,
      'datetime': datetime,
      'Id_O': Id_O,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Resultat.fromMap(Map<String, Object?> map) : this(
    id: map['id'] as int,
    user: map['user'] as String,
    niveau: map['niveau'] as String,
    datetime: map['datetime'] as String,
    Id_O: map['Id_O'] as int,
  );

  @override
  String toString() {
    return 'Resultat{id: $id, user: $user, niveau: $niveau, datetime: $datetime, Id_O: $Id_O}';
  }

}