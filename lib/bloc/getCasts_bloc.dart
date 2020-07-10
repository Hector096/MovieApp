import 'package:first_flutter_app/Repo/movieDetailRepo.dart';
import 'package:first_flutter_app/model/movieDetails/castPojo_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CastBloc {
  final MovieDetailRepo repo = MovieDetailRepo();
  final BehaviorSubject<CastResponse> _subject =
      BehaviorSubject<CastResponse>();

  getCast(int id) async {
    CastResponse response = await repo.getCastPerson(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  BehaviorSubject<CastResponse> get subject => _subject;

  //disposing

  dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final castBloc = CastBloc();
