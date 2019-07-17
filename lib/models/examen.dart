class Examen{
  final int id;
  final int idMateria;
  final String descripcion;
  final String fechaDeEntrega;
  final int acabado;
  
  Examen({this.id,this.idMateria,this.descripcion, this.fechaDeEntrega, this.acabado});

  factory Examen.fromJson(Map<String,dynamic> json) => Examen(
    id: json["id"],
    idMateria: json["idMateria"],
    descripcion: json["descripcion"],
    fechaDeEntrega: json["fechaDeEntrega"],
    acabado: json["acabado"]
  );

  Map<String,dynamic> toJson() => {
    "id": id,
    "idMateria" : idMateria,
    "descripcion": descripcion,
    "fechaDeEntrega": fechaDeEntrega,
    "acabado" : acabado
  };
}