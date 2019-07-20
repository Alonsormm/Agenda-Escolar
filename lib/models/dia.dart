class Dia{
  final int id;
  final int idJornada;
  final int diaActivo;

  Dia({this.id,this.idJornada, this.diaActivo});

  factory Dia.fromJson(Map<String,dynamic> json) => Dia(
    id : json["id"],
    idJornada: json["idJornada"],
    diaActivo: json["diaActivo"],
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "idJornada": idJornada,
    "diaActivo" : diaActivo
  };

}