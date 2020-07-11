import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:first_flutter_app/bloc/getMovies_bloc.dart';
import 'package:first_flutter_app/model/moviePojo/movie_model.dart';
import 'package:first_flutter_app/model/moviePojo/movie_response.dart';
import 'package:first_flutter_app/ui/Screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopMoviesList extends StatefulWidget {
  @override
  _TopMoviesListState createState() => _TopMoviesListState();
}

class _TopMoviesListState extends State<TopMoviesList> {
  @override
  void initState() {
    super.initState();
    movieBloc..getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 10.0),
          child: Text(
            "Top Rated Movies",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
            stream: movieBloc.subject.stream,
            builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildTopMovieWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            })
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10),
        SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            )),
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Text("Error occured: $error")],
    ));
  }

  Widget _buildTopMovieWidget(MovieResponse data) {
    List<MovieModel> list = data.movies;

    if (list.length == 0) {
      return Container(
        child: Text("no Movies"),
      );
    } else {
      return Container(
        height: 270.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: list[index])));
                  },
                  child: Column(
                    children: <Widget>[
                      list[index].poster == null
                          ? Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  color: Style.Colors.secondColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0))),
                              child: Column(
                                children: <Widget>[
                                  Icon(EvaIcons.filmOutline,
                                      color: Colors.white, size: 50.0)
                                ],
                              ),
                            )
                          : Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                color: Style.Colors.secondColor,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200/" +
                                            list[index].poster),
                                    fit: BoxFit.cover),
                              )),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 100.0,
                        child: Text(
                          list[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            list[index].rating.toString(),
                            style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          RatingBar(
                            itemSize: 8.0,
                            initialRating: list[index].rating / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, index) => Icon(EvaIcons.star,
                                color: Style.Colors.secondColor),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ));
          },
        ),
      );
    }
  }
}
