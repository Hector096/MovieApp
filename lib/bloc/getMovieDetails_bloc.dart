import 'package:first_flutter_app/Repo/movieDetailRepo.dart';
import 'package:first_flutter_app/model/movieDetails/movieDetailsPojo_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MovieDetailBloc {
  final MovieDetailRepo repo = MovieDetailRepo();
  final BehaviorSubject<MovieDetailResponse> _subject =
  BehaviorSubject<MovieDetailResponse>();

  getMoviDetail(int id) async {
    MovieDetailResponse response = await repo.getMovieDetail(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  BehaviorSubject<MovieDetailResponse> get subject => _subject;

  //disposing

  dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final moviedetailBloc = MovieDetailBloc();
