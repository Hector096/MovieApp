import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:first_flutter_app/bloc/getPersons_bloc.dart';
import 'package:first_flutter_app/model/personPojo/personPojo_response.dart';
import 'package:first_flutter_app/model/personPojo/person_pojo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonList extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  @override
  void initState() {
    super.initState();
    personsBloc..getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0, left: 10.0),
          child: Text(
            "Trending Person of this Week",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<PersonPojoResponse>(
            stream: personsBloc.subject.stream,
            builder: (context, AsyncSnapshot<PersonPojoResponse> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error != null &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildPersonWidget(snapshot.data);
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

  Widget _buildPersonWidget(PersonPojoResponse data) {
    List<PersonPojo> list = data.persons;
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      height: 116.0,
      child: ListView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                list[index].profileImg == null
                    ? Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Style.Colors.secondColor),
                        child:
                            Icon(FontAwesomeIcons.userAlt, color: Colors.white),
                      )
                    : Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.tmdb.org/t/p/w200" +
                                      list[index].profileImg),
                              fit: BoxFit.cover),
                        ),
                      ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  list[index].name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0),
                ),
                SizedBox(height: 3.0,),
                Text("For ${list[index].known}",style: TextStyle(
                  fontSize: 7.0,
                  fontWeight: FontWeight.w400,
                  color: Style.Colors.titleColor

                ),),
              ],
            ),
          );
        },
      ),
    );
  }
}
