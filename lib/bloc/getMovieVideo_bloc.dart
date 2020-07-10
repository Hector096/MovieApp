import 'package:first_flutter_app/Repo/movieDetailRepo.dart';
import 'package:first_flutter_app/model/movieDetails/videoPojo_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MovieVideoBloc{

  final MovieDetailRepo repo = MovieDetailRepo();
  final BehaviorSubject<VideoResponse> _subject =
  BehaviorSubject<VideoResponse>();

  getMovieVideo(int id) async {
    VideoResponse response = await repo.getMovieVideo(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  BehaviorSubject<VideoResponse> get subject => _subject;

  //disposing

  dispose() async {
    await _subject.drain();
    _subject.close();
  }
}

final movieVideoBloc = MovieVideoBloc();
