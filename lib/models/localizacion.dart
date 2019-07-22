class Localizacion{
  final int id;
  final String salon;

  Localizacion({this.id,this.salon});

  factory Localizacion.fromJson(Map<String,dynamic> json) => Localizacion(
    id : json["id"],
    salon: json["salon"]
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "salon": salon
  };

}