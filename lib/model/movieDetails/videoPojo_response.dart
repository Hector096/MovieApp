


import 'package:first_flutter_app/model/movieDetails/videoPojo.dart';

class VideoResponse {
  final List<VideoPojo> video;
  final String error;

  VideoResponse(this.error, this.video);

  VideoResponse.fromJson(Map<String, dynamic> json)
      : video = (json["results"] as List).map((i) => VideoPojo.fromJson(i)).toList(),
        error = "";

  VideoResponse.withError(String errorValue)
      : video = List(),
        error = errorValue;
}
