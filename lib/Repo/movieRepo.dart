import 'package:dio/dio.dart';
import 'package:first_flutter_app/Repo/api/api_util.dart';
import 'package:first_flutter_app/Repo/api/apiKey.dart';
import 'package:first_flutter_app/model/moviePojo/movie_response.dart';



 class MovieRepo {

  static ApiKey apiKey = ApiKey();
  static ApiUtil apiUtil = ApiUtil();
  final Dio dio = Dio();

  Future<MovieResponse> getMovie() async{
    var params = {
      "api_key": apiKey.apikey(),
      "language": "en-US",
      "page:":1
    };
    try{
      Response response = await dio.get(apiUtil.getPopularUrl(), queryParameters: params);
      return MovieResponse.fromJson(response.data);


    } catch (err, stackTrace){
          print("Exception occured : $err stackTrace:$stackTrace" );
          return  MovieResponse.withError("$err");
    }
  }


  Future<MovieResponse> getMovieByGenre(int id) async{
    var params = {
      "api_key": apiKey.apikey(),
      "language": "en-US",
      "page:":1,
      "with_genre": id
    };
    try{
      Response response = await dio.get(apiUtil.getMoviesUrl(), queryParameters: params);
      return MovieResponse.fromJson(response.data);


    } catch (err, stackTrace){
      print("Exception occured : $err stackTrace:$stackTrace" );
      return  MovieResponse.withError("$err");
    }
  }


  Future<MovieResponse> getNowPlayingMovie() async{
    var params = {
      "api_key": apiKey.apikey(),
      "language": "en-US",
      "page:":1
    };
    try{
      Response response = await dio.get(apiUtil.getNowPlayingUrl(), queryParameters: params);
      return MovieResponse.fromJson(response.data);


    } catch (err, stackTrace){
      print("Exception occured : $err stackTrace:$stackTrace" );
      return  MovieResponse.withError("$err");
    }
  }


}