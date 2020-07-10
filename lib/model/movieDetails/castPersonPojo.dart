class CastPersonPojo {
  final int id;
  final String character;
  final String name;
  final String img;

  CastPersonPojo(this.id, this.name, this.character, this.img);

  CastPersonPojo.fromJson(Map<String, dynamic> json)
      : id = json["cast_id"],
        character = json["character"],
        name = json["name"],
        img = json["profile_path"];
}
