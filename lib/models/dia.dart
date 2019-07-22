class Dia{
  final int id;

  Dia({this.id});

  factory Dia.fromJson(Map<String,dynamic> json) => Dia(
    id : json["id"],
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
  };

}