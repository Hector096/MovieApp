import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:first_flutter_app/ui/Widgets/nowPlayingWidget.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;
import 'package:first_flutter_app/ui/Widgets/genreWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.mainColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        centerTitle: true,
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        title: Text("MovieApp"),
        actions: <Widget>[
          IconButton(
              icon: Icon(EvaIcons.searchOutline, color: Colors.white),
              onPressed: null)
        ],
      ),
      body: ListView(
        children: <Widget>[NowPlaying(),GetGenre()],
      ),
    );
  }
}
