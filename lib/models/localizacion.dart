class Localizacion{
  final int id;
  final String edificio;
  final String salon;

  Localizacion({this.id,this.edificio,this.salon});

  factory Localizacion.fromJson(Map<String,dynamic> json) => Localizacion(
    id : json["id"],
    edificio: json["edificio"],
    salon: json["salon"]
  );
  Map<String,dynamic> toJson()=>{
    "id":id,
    "edificio":edificio,
    "salon": salon
  };

}