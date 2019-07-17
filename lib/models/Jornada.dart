class Jornada{
  final int id;
  final int duracion;
  final int numeroDias;

  Jornada({this.id,this.duracion,this.numeroDias});

  factory Jornada.fromJson(Map<String,dynamic> json) => Jornada(
    id : json["id"],
    duracion : json["duraicon"],
    numeroDias : json["numeroDias"],

  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "duracion":duracion,
    "numeroDias":numeroDias,
  };

}