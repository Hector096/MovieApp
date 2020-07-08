import 'package:first_flutter_app/Repo/genreRepo.dart';
import 'package:rxdart/subjects.dart';
import 'package:first_flutter_app/model/genrePojo/genrePojo_response.dart';

import 'package:rxdart/rxdart.dart';

class GenreListBloc {
  final GenreRepo repo = GenreRepo();
  final BehaviorSubject<GenrePojoResponse> _subject =
      BehaviorSubject<GenrePojoResponse>();


  getGenre() async {
    GenrePojoResponse response = await repo.getGenre();
    _subject.sink.add(response);
  }



  BehaviorSubject<GenrePojoResponse> get subject => _subject;

  //disposing

  dispose() {
    _subject.close();
  }
}

final genreBloc = GenreListBloc();
