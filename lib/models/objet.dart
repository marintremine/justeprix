
class Objet {
  int id;
  String nom;
  String image;
  String description;
  int prix;

  Objet({required this.id,required this.nom,required this.image,required this.description,required this.prix});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'nom': nom,
      'image': image,
      'description': description,
      'prix': prix,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

Objet.fromMap(Map<String, Object?> map) : this(
    id: map['id'] as int,
    nom: map['nom'] as String,
    image: map['image'] as String,
    description: map['description'] as String,
    prix: map['prix'] as int,
  );

  @override
  String toString() {
    return 'Objet{id: $id, nom: $nom, image: $image, description: $description, prix: $prix}';
  }
}



