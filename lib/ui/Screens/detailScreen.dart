import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:first_flutter_app/bloc/getMovieDetails_bloc.dart';
import 'package:first_flutter_app/bloc/getMovieVideo_bloc.dart';
import 'package:first_flutter_app/model/movieDetails/videoPojo.dart';
import 'package:first_flutter_app/model/movieDetails/videoPojo_response.dart';
import 'package:first_flutter_app/model/moviePojo/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieModel movie;
  MovieDetailScreen({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final MovieModel movie;
  _MovieDetailScreenState(this.movie);
  @override
  void initState(){
    super.initState();
    movieVideoBloc..getMovieVideo(movie.id);
  }
  @override
  void dispose(){
    super.dispose();
    movieVideoBloc..drainStream();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.Colors.mainColor,
        body: Builder(
          builder: (context) {
            return SliverFab(
              floatingPosition: FloatingPosition(right: 20.0),
               floatingWidget: StreamBuilder<VideoResponse>(
                   stream: movieVideoBloc.subject.stream,
                   builder: (context, AsyncSnapshot<VideoResponse> snapshot){
                     if (snapshot.hasData) {
                       if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                         return _buildErrorWidget(snapshot.data.error);
                       }
                       return _buildVideoWidget(snapshot.data);
                     } else if (snapshot.hasError) {
                       return _buildErrorWidget(snapshot.error);
                     } else {
                       return _buildLoadingWidget();
                     }
                   }
               ),

              expandedHeight: 200.0,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Style.Colors.mainColor,
                  expandedHeight: 200.0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(movie.title.length>40 ? movie.title.substring(0,37)+"..."
                    : movie.title,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold
                    ),),
                      background: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(image:NetworkImage(
                                "https://images.tmdb.org/t/p/original/"+ movie.backPoster
                              ))
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5)
                              ),
                            ),

                          ),
                          Container(

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.9),
                                  Colors.black.withOpacity(0.0)
                                ]
                              )
                            ),
                          ),
                        ],
                      )
                    ,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(0.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                        padding: EdgeInsets.only(left: 10.0,top:20.0 ),
                          child: Row(

                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  movie.rating.toString(),
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                                ),

                              ),
                              SizedBox(
                                  width:5.0
                              ),
                              RatingBar(
                                itemSize: 10.0,
                                initialRating: movie.rating / 2,
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
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0,top: 20.0),
                          child: Text("OVERVIEW",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Style.Colors.titleColor,
                            fontSize: 12.0

                          ),),

                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            movie.overview,
                            style: TextStyle(
                              color: Colors.white,fontSize: 12.0,height: 1.5
                            ),
                          ),

                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            );
          },
        ));
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
  Widget _buildVideoWidget (VideoResponse data){

        List<VideoPojo> list  = data.video;
        return FloatingActionButton(
          backgroundColor: Style.Colors.secondColor,
          child: Icon(Icons.play_arrow),
          onPressed: null,
        );


  }
}
