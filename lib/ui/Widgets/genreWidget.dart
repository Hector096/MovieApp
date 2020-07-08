import 'package:first_flutter_app/model/genrePojo/genrePojo_response.dart';
import 'package:first_flutter_app/model/genrePojo/genre_pojo.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/bloc/getGenre_bloc.dart';
import 'package:first_flutter_app/ui/Widgets/genreListwidget.dart';

class GetGenre extends StatefulWidget {
  @override
  _GetGenreState createState() => _GetGenreState();
}

class _GetGenreState extends State<GetGenre> {
  @override
  void initState() {
    super.initState();
    genreBloc..getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenrePojoResponse>(
        stream: genreBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenrePojoResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildGenreWidget(snapshot.data);
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

  Widget _buildGenreWidget(GenrePojoResponse data) {
    List<GenrePojo> list = data.genres;
    if (list.length == 0) {
      return Container(
        child: Text("no genre"),
      );
    } else {
      return GenreList(genres: list);
    }
  }
}
