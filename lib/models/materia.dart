class Materia{
  final int id;
  final String nombre;
  final int mismaHora;
  final int mismoSalon;
  final int color;
  Materia({this.id, this.nombre,this.mismaHora,this.color, this.mismoSalon});

  factory Materia.fromJson(Map<String,dynamic> json) => Materia(
    id: json["id"],
    nombre: json["nombre"],
    mismaHora: json["mismaHora"],
    color: json["color"],
    mismoSalon: json["mismoSalon"],

  );

  Map<String,dynamic> toJson() => {
    "id" : id,
    "nombre" : nombre,
    "mismaHora": mismaHora,
    "color": color,
    "mismoSalon": mismoSalon,
  };
}