import 'package:first_flutter_app/model/genrePojo/genre_pojo.dart';

class GenrePojoResponse{



  final List<GenrePojo> genres;
  final String error;

  GenrePojoResponse(this.genres, this.error);

  GenrePojoResponse.fromJson(Map<String,dynamic>json)
      : genres =
  ( json['genres'] as List).map((i)=> new GenrePojo.fromJson(i)).toList(),
        error="";
  GenrePojoResponse.withError(String errorValue)
      :genres  = List(),
        error = errorValue;

}
