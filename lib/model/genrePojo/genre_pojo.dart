class GenrePojo {
  final int id;
  final String name;

  GenrePojo(this.id, this.name) ;


  GenrePojo.fromJson(Map <String, dynamic> json)
  : id = json["id"],
  name = json["name"];

}
