import 'package:first_flutter_app/model/personPojo/person_pojo.dart';

class PersonPojoResponse {
  final List<PersonPojo> persons;
  final String error;

  PersonPojoResponse(this.persons, this.error) ;

  PersonPojoResponse.fromJson(Map<String,dynamic>json)
      : persons =
  ( json['results'] as List).map((i)=> new PersonPojo.fromJson(i)).toList(),
        error="";
  PersonPojoResponse.withError(String errorValue)
      :persons  = List(),
        error = errorValue;

}
