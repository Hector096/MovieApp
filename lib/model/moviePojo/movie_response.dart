import 'package:first_flutter_app/model/moviePojo/movie_model.dart';

class MovieResponse {
  final List<MovieModel> movies;
  final String error;

  MovieResponse(this.movies, this.error) {}

  MovieResponse.fromJson(Map<String,dynamic>json)
     : movies =
                ( json['results'] as List).map((i)=> new MovieModel.fromJson(i)).toList(),
                  error="";
  MovieResponse.withError(String errorValue)
  :movies  = List(),
  error = errorValue;

}
