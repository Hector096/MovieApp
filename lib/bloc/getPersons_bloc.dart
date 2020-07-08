import 'package:first_flutter_app/Repo/personsRepo.dart';
import 'package:first_flutter_app/model/personPojo/personPojo_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PersonsListBloc {
  final PersonsRepo repo = PersonsRepo();
  final BehaviorSubject<PersonPojoResponse> _subject =
  BehaviorSubject<PersonPojoResponse>();


  getMovie() async {
    PersonPojoResponse response = await repo.getPersons();
    _subject.sink.add(response);
  }



  BehaviorSubject<PersonPojoResponse> get subject => _subject;

  //disposing

  dispose() {
    _subject.close();
  }
}

final personsBloc = PersonsListBloc();
