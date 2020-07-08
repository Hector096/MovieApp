import 'package:dio/dio.dart';
import 'package:first_flutter_app/Repo/api/api_util.dart';
import 'package:first_flutter_app/Repo/api/apiKey.dart';
import 'package:first_flutter_app/model/genrePojo/genrePojo_response.dart';

class GenreRepo {
  static ApiKey apiKey = ApiKey();
  static ApiUtil apiUtil = ApiUtil();
  final Dio dio = Dio();

  Future<GenrePojoResponse> getGenre() async {
    var params = {
      "api_key": apiKey.apikey(),
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response =
          await dio.get(apiUtil.getGenreUrl(), queryParameters: params);
      return GenrePojoResponse.fromJson(response.data);
    } catch (err, stackTrace) {
      print("Exception occured : $err stackTrace:$stackTrace");
      return GenrePojoResponse.withError("$err");
    }
  }
}
