import 'package:first_flutter_app/model/movieDetails/movieDetailPojo.dart';
import 'package:flutter/cupertino.dart';

class MovieDetailResponse{
  final MovieDetails movieDetail;
  final String error;



   MovieDetailResponse(this.error,this.movieDetail);



   MovieDetailResponse.fromJson(Map<String,dynamic> json)
  : movieDetail = MovieDetails.fromJson(json),
  error = "";


   MovieDetailResponse.withError(String errorValue)
  : movieDetail = MovieDetails(null,null,null,null,"",null),
  error = errorValue;

}