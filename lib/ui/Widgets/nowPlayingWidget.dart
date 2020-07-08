import 'package:first_flutter_app/bloc/getNowPlaying_bloc.dart';
import 'package:first_flutter_app/model/moviePojo/movie_model.dart';
import 'package:first_flutter_app/model/moviePojo/movie_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlaying..getNowPlayingMovie();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: nowPlaying.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildNowPlayingWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
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

  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<MovieModel> movies = data.movies;
    if (movies.length == 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Text("No movies")],
          ));
    } else
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          length: null,
          padding: EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondColor,
          shape: IndicatorShape.circle(size: 5.0),
          pageView: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.take(5).length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/original/" +
                                    movies[index].backposter),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Style.Colors.mainColor.withOpacity(1.0),
                              Style.Colors.mainColor.withOpacity(0.0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.0, 0.9])),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      FontAwesomeIcons.playCircle,
                      color: Style.Colors.secondColor,
                      size: 40,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            movies[index].title,
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
  }
}
