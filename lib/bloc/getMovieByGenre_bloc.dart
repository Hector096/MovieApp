import 'package:first_flutter_app/Repo/movieRepo.dart';
import 'package:first_flutter_app/model/moviePojo/movie_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MovieByGenreList {
  final MovieRepo repo = MovieRepo();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovie(int id) async {
    MovieResponse response = await repo.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final movieByGenreBloc = MovieByGenreList();
