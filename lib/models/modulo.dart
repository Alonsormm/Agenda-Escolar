class Modulo{
  final int id;
  final int idMateria;
  final int idLocalizacion;
  final int idDia;
  final String horaDeInicio;
  final String horaDeFinal;

  Modulo({this.id,this.idMateria,this.idLocalizacion,this.idDia,this.horaDeInicio,this.horaDeFinal});

  factory Modulo.fromJson(Map<String,dynamic> json) => Modulo(
    id: json["id"],
    idMateria: json["idMateria"],
    idLocalizacion: json["idLocalizacion"],
    idDia: json["idDia"],
    horaDeInicio: json["horaDeInicio"],
    horaDeFinal : json["horaDeFinal"],
  );
  Map<String,dynamic> toJson() => {
    "id": id,
    "idMateria": idMateria, 
    "idLocalizacion": idLocalizacion,
    "idDia": idDia,
    "horaDeInicio": horaDeInicio,
    "horaDefinal": horaDeFinal
  };
}