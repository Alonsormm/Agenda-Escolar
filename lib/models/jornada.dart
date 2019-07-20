class Jornada{
  final int id;
  final int duracion;

  Jornada({this.id,this.duracion});

  factory Jornada.fromJson(Map<String,dynamic> json) => Jornada(
    id : json["id"],
    duracion : json["duracion"],
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "duracion":duracion,
  };

}