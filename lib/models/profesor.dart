class Profesor{
  final int id;
  final String nombre;
  final String informacionDeContacto;
  Profesor({this.id,this.nombre,this.informacionDeContacto});

  factory Profesor.fromJson(Map<String,dynamic> json) => Profesor(
    id : json["id"],
    nombre: json["nombre"],
    informacionDeContacto: json["informacionDeContacto"],
  );
  Map<String,dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "informacionDeContacto" : informacionDeContacto,
  };
}