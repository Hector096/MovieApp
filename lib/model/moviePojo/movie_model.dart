class MovieModel {
  final int id;
  final String title;
  final double popularity;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;

  //Constructor

  MovieModel(this.id, this.title, this.popularity, this.backPoster,
      this.poster, this.overview, this.rating);


  //Maping

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        popularity = json["popularity"].toDouble(),
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}
