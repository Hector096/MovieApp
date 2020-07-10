import 'package:dio/dio.dart';
import 'package:first_flutter_app/model/movieDetails/castPojo_response.dart';
import 'package:first_flutter_app/model/movieDetails/movieDetailsPojo_response.dart';
import 'package:first_flutter_app/model/movieDetails/videoPojo_response.dart';

import 'api/apiKey.dart';
import 'api/api_util.dart';

class MovieDetailRepo {
  static ApiKey apiKey = ApiKey();
  static ApiUtil apiUtil = ApiUtil();
  final Dio dio = Dio();

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {"api_key": apiKey.apikey(), "language": "en-US"};
    try {
      Response response = await dio.get(apiUtil.getMovieDetail() + "/$id",
          queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (err, stackTrace) {
      print("Exception occured : $err stackTrace:$stackTrace");
      return MovieDetailResponse.withError("$err");
    }
  }

  Future<CastResponse> getCastPerson(int id) async {
    var params = {"api_key": apiKey.apikey(), "language": "en-US"};
    try {
      Response response = await dio.get(
          apiUtil.getMovieDetail() + "/$id" + "/credits",
          queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (err, stackTrace) {
      print("Exception occured : $err stackTrace:$stackTrace");
      return CastResponse.withError("$err");
    }
  }

  Future<VideoResponse> getMovieVideo(int id) async {
    var params = {"api_key": apiKey.apikey(), "language": "en-US"};
    try {
      Response response = await dio.get(
          apiUtil.getMovieDetail() + "/$id" + "/videos",
          queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (err, stackTrace) {
      print("Exception occured : $err stackTrace:$stackTrace");
      return VideoResponse.withError("$err");
    }
  }
}
