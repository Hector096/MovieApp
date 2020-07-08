import 'package:first_flutter_app/Repo/movieRepo.dart';
import 'package:first_flutter_app/model/moviePojo/movie_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class GetNowPlayingList {
  final MovieRepo repo = MovieRepo();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getNowPlayingMovie() async {
    MovieResponse response = await repo.getNowPlayingMovie();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlaying = GetNowPlayingList();
