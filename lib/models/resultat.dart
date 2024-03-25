// lib/models/resultat.dart
class Resultat {
  String id;
  String userId;
  String niveau;
  String datetime;
  String objetId;

  Resultat({required this.id,required this.userId,required this.niveau,required this.datetime,required this.objetId});

  factory Resultat.fromJson(Map<String, dynamic> json) {
    return Resultat(
      id: json['id_R'],
      userId: json['user'],
      niveau: json['niveau'],
      datetime: json['datetime'],
      objetId: json['id_O'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id_R': id,
      'user': userId,
      'niveau': niveau,
      'datetime': datetime,
      'id_O': objetId,
    };
  }
}