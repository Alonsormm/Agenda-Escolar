class Materia{
  final int id;
  final String nombre;
  final int idProfesor;
  Materia({this.id, this.nombre,this.idProfesor});

  factory Materia.fromJson(Map<String,dynamic> json) => Materia(
    id: json["id"],
    nombre: json["nombre"],
    idProfesor: json["idProfesor"],
  );

  Map<String,dynamic> toJson() => {
    "id" : id,
    "idNombre" : nombre,
    "idProfesor": idProfesor,
  };
}