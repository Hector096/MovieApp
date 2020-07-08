import 'package:dio/dio.dart';
import 'package:first_flutter_app/Repo/api/api_util.dart';
import 'package:first_flutter_app/Repo/api/apiKey.dart';
import 'package:first_flutter_app/model/personPojo/personPojo_response.dart';

class PersonsRepo {
  static ApiKey apiKey = ApiKey();
  static ApiUtil apiUtil = ApiUtil();
  final Dio dio = Dio();

  Future<PersonPojoResponse> getPersons() async {
    var params = {
      "api_key": apiKey.apikey(),
    };
    try {
      Response response =
          await dio.get(apiUtil.getPersonsUrl(), queryParameters: params);
      return PersonPojoResponse.fromJson(response.data);
    } catch (err, stackTrace) {
      print("Exception occured : $err stackTrace:$stackTrace");
      return PersonPojoResponse.withError("$err");
    }
  }
}
