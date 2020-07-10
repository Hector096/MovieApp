
import 'package:first_flutter_app/model/genrePojo/genre_pojo.dart';

class MovieDetails{
  final int id;
  final bool adult;
  final int budget;
  final List<GenrePojo> genres;
  final String releaseDate;
  final int runTime;

MovieDetails(this.id,this.budget,this.adult,this.genres,this.releaseDate,this.runTime);

MovieDetails.fromJson(Map<String,dynamic> json):
      id = json["id"],
  adult = json["adult"],
  budget = json["budget"],
  genres = (json["genres"] as List).map((i) => new GenrePojo.fromJson(i)).toList(),
  releaseDate = json["release_date"],
  runTime = json["runtime"];


}