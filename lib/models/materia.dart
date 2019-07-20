class Materia{
  final int id;
  final String nombre;
  final int color;
  Materia({this.id, this.nombre,this.color});

  factory Materia.fromJson(Map<String,dynamic> json) => Materia(
    id: json["id"],
    nombre: json["nombre"],
    color: json["color"],
  );

  Map<String,dynamic> toJson() => {
    "id" : id,
    "nombre" : nombre,
    "color": color,
  };
}