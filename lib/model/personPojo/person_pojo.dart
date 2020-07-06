class PersonPojo {
  final int id;
  final String name;
  final double popularity;
  final String profileImg;
  final String known;


  //Constructor

  PersonPojo(this.id, this.name, this.popularity, this.profileImg,
      this.known) {}

  //Maping

  PersonPojo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        popularity = json["popularity"],
        profileImg = json["profile_path"],
        known = json["known_for_department"].toDouble();
}
