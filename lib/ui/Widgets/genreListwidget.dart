import 'package:first_flutter_app/bloc/getMovieByGenre_bloc.dart';
import 'package:first_flutter_app/model/genrePojo/genre_pojo.dart';
import 'package:first_flutter_app/ui/Widgets/genreMoviesWidget.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;

class GenreList extends StatefulWidget {
  final List<GenrePojo> genres;
  GenreList({Key key, @required this.genres}) : super(key: key);

  @override
  _GenreListState createState() => _GenreListState(genres);
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  final List<GenrePojo> genres;
  TabController _tabController;
  _GenreListState(this.genres);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        movieByGenreBloc..drainStream();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307.0,
      child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
                child: AppBar(
                  backgroundColor: Style.Colors.mainColor,
                  bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Style.Colors.secondColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      unselectedLabelColor: Style.Colors.titleColor,
                      labelColor: Colors.white,
                      isScrollable: true,
                      tabs: genres.map((GenrePojo genre) {
                        return Container(
                          padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                          child: Text(
                            genre.name.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList()),
                ),
                preferredSize: Size.fromHeight(50.0)),
            body: TabBarView(
                controller: _tabController,
                physics: NeverScrollableScrollPhysics(),
                children: genres.map((GenrePojo genre) {
                  return GenreMovies(genreId: genre.id);
                }).toList()),
          )),
    );
  }
}
