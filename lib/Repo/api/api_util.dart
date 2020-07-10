class ApiUtil {
  static const String baseMovieUrl = "https://api.themoviedb.org/3";

  getTopRatedUrl() {
    return;
  }

  getPopularUrl() {
     String popularUrl = "$baseMovieUrl/movie/top_rated";

    return popularUrl;
  }

  getMoviesUrl() {
     String movieUrl = "$baseMovieUrl/discover/movie";

    return movieUrl;
  }

  getNowPlayingUrl() {
     String playingUrl = "$baseMovieUrl/movie/now_playing";

    return playingUrl;
  }

  getGenreUrl() {
     String genreUrl = "$baseMovieUrl/genre/movie/list";

    return genreUrl;
  }

  getPersonsUrl() {
     String trendingUrl = "$baseMovieUrl/trending/person/week";

    return trendingUrl;
  }
  getMovieDetail(){


    String movieDetialUrl = "$baseMovieUrl/movie";
    return movieDetialUrl;
  }
}
