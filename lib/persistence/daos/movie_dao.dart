import 'package:hive/hive.dart';
import 'package:movie_app_may/persistence/hive_constants.dart';

import '../../data/vos/movie_vo.dart';

class MovieDao{

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao(){
    return _singleton;
  }

  MovieDao._internal();

  void saveMovies(List<MovieVO> movieList) async{
    Map<int, MovieVO> movieMap = Map.fromIterable(movieList,
    key: (movie) => movie.id, value: (movie) => movie );
    await getMovieBox().putAll(movieMap);
  }

  List<MovieVO> getAllMovies(){
    return getMovieBox().values.toList();
  }

  void saveSingleMovie(MovieVO movie) async{
    return getMovieBox().put(movie.id, movie);
  }

  MovieVO? getMovieById(int movieId){
    return getMovieBox().get(movieId);
  }

  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

  /// Reactive Programming
  Stream<void> getAllMoviesEventSteam(){
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream(){
    return Stream.value(getAllMovies()
        .where((element) => element?.isNowPlaying ?? false)
        .toList()
    );
  }

  List<MovieVO> getPopularMovie () {
    if ((getAllMovies().isNotEmpty)) {
      print("movie_dao popular   is  not empty  ");
      return getAllMovies().where((movie) => movie?.isPopular ?? false).toList();
    } else {
      print("movie_dao popular   is  empty  ");

      return [];
    }
  }

  List<MovieVO> getTopRatedMovie () {
    if ((getAllMovies().isNotEmpty)) {
      print("movie_dao top rated   is  not empty  ");
      return getAllMovies().where((movie) => movie?.isTopRated ?? false).toList();
    } else {
      print("movie_dao top rated   is  empty  ");

      return [];
    }
  }

  List<MovieVO> getNowShowingMovie () {
    if ((getAllMovies().isNotEmpty)) {
      print("movie_dao now showing   is  not empty  ");
      return getAllMovies().where((movie) => movie?.isNowPlaying ?? false).toList();
    } else {
      print("movie_dao now showing   is  empty  ");

      return [];
    }
  }

  Stream<List<MovieVO>> getPopularMoviesStream(){
    return Stream.value(getAllMovies()
        .where((movie) => movie?.isPopular ?? false)
        .toList()
    );
  }

  Stream<List<MovieVO>> getTopRatedMoviesStream(){
    return Stream.value(getAllMovies()
      .where((movie) => movie.isTopRated ?? false)
        .toList()
    );
  }

}