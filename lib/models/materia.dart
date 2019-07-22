class Materia{
  final int id;
  final String nombre;
  final int mismaHora; 
  final int color;
  Materia({this.id, this.nombre,this.mismaHora,this.color});

  factory Materia.fromJson(Map<String,dynamic> json) => Materia(
    id: json["id"],
    nombre: json["nombre"],
    mismaHora: json["mismaHora"],

    color: json["color"],
  );

  Map<String,dynamic> toJson() => {
    "id" : id,
    "nombre" : nombre,
    "mismaHora": mismaHora,
    "color": color,
  };
}