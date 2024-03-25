// lib/models/objet.dart
class Objet {
  String id;
  String nom;
  String image;
  String description;
  int prix;

  Objet({required this.id,required this.nom,required this.image,required this.description,required this.prix});

  factory Objet.fromJson(Map<String, dynamic> json) {
    return Objet(
      id: json['id_O'],
      nom: json['nom'],
      image: json['image'],
      description: json['description'],
      prix: json['prix'],
    );
  }
}

