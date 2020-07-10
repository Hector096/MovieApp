import 'package:first_flutter_app/Repo/movieRepo.dart';
import 'package:first_flutter_app/model/moviePojo/movie_response.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMovieBloc {
  final MovieRepo repo = MovieRepo();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getSimilarMovie(int id) async {
    MovieResponse response = await repo.getSimilarMovie(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

  //disposing

  dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final similarMovieBloc = SimilarMovieBloc();
