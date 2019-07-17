class Dia{
  final int id;
  final int idJornada;

  Dia({this.id,this.idJornada});

  factory Dia.fromJson(Map<String,dynamic> json) => Dia(
    id : json["id"],
    idJornada: json["idJornada"],
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "idJornada": idJornada
  };

}