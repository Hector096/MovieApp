class MovieModel {
  final int id;
  final String title;
  final double popularity;
  final String backposter;
  final String poster;
  final String overview;
  final double rating;

  //Constructor

  MovieModel(this.id, this.title, this.popularity, this.backposter,
      this.poster, this.overview, this.rating) {}

//  //SETTERS
//
//  set id(int id) {
//    this._id = id;
//  }
//
//  set name(String name) {
//    this._name = name;
//  }
//
//  set popularity(double popularity) {
//    this._popularity = popularity;
//  }
//
//  set backposter(String backposter) {
//    this._backposter = backposter;
//  }
//
//  set poster(String poster) {
//    this._poster = poster;
//  }
//
//  set overview(String overview) {
//    this._overview = overview;
//  }
//
//  set rating(double rating) {
//    this._rating = rating;
//  }
//
//  //GETTERS
//
//  int get id => this._id;
//  String get name => this._name;
//  double get popularity => this._popularity;
//  String get backposter => this._backposter;
//  String get poster => this._poster;
//  String get overview => this._overview;
//  double get rating => this._rating;

  //Maping

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        popularity = json["popularity"],
        backposter = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}
