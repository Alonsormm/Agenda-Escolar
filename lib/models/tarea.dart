class Tarea{
  final int id;
  final int idMateria;
  final String nombre;
  final String descripcion;
  final String fechaDeEntrega;
  final int acabado;
  
  Tarea({this.id,this.idMateria,this.nombre,this.descripcion, this.fechaDeEntrega, this.acabado});

  factory Tarea.fromJson(Map<String,dynamic> json) => Tarea(
    id: json["id"],
    idMateria: json["idMateria"],
    nombre: json["nombre"],
    descripcion: json["descripcion"],
    fechaDeEntrega: json["fechaDeEntrega"],
    acabado: json["acabado"]
  );

  Map<String,dynamic> toJson() => {
    "id": id,
    "idMateria" : idMateria,
    "nombre": nombre,
    "descripcion": descripcion,
    "fechaDeEntrega": fechaDeEntrega,
    "acabado" : acabado
  };

}