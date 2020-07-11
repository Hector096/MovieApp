import 'package:first_flutter_app/bloc/getCasts_bloc.dart';
import 'package:first_flutter_app/model/movieDetails/castPersonPojo.dart';
import 'package:first_flutter_app/model/movieDetails/castPojo_response.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/ui/Styles/appTheme.dart' as Style;

class CastWidget extends StatefulWidget {
  final int id;
  CastWidget({Key key, @required this.id}) : super(key: key);
  @override
  _CastWidgetState createState() => _CastWidgetState(id);
}

class _CastWidgetState extends State<CastWidget> {
  final int id;
  _CastWidgetState(this.id);
  @override
  void initState() {
    super.initState();
    castBloc..getCast(id);
  }

  @override
  void dispose() {
    super.dispose();
    castBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 20.0),
          child: Text(
            "CASTS",
            style: TextStyle(
                color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 12.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<CastResponse>(
            stream: castBloc.subject.stream,
            builder: (context, AsyncSnapshot<CastResponse> snapshot){
              if (snapshot.hasData) {
                if (snapshot.data.error != null && snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                }
                return _buildCastWidget(snapshot.data);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }
        )
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
  Widget _buildCastWidget (CastResponse data){
    List<CastPersonPojo> list = data.cast;
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      height: 143.0,
      child: ListView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10.0, right: 8.0),
            width: 100.0,
             child:GestureDetector(
               onTap: (){},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.tmdb.org/t/p/w300" +
                                    list[index].img),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      list[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                    SizedBox(height: 10.0,),
                    Text(list[index].character,style: TextStyle(
                        fontSize: 7.0,
                        fontWeight: FontWeight.bold,
                        color: Style.Colors.titleColor

                    ),),
                  ],
                ),
              ],
            ),
             ),
          );
        },
      ),
    );

  }
}
