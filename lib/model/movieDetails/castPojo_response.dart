import 'package:first_flutter_app/model/movieDetails/castPersonPojo.dart';

class CastResponse {
  final List<CastPersonPojo> cast;
  final String error;

  CastResponse(this.error, this.cast);

  CastResponse.fromJson(Map<String, dynamic> json)
      : cast = (json["casts"] as List)
            .map((i) => new CastPersonPojo.fromJson(i))
            .toList(),
        error = "";

  CastResponse.withError(String errorValue)
      : cast = List(),
        error = errorValue;
}
