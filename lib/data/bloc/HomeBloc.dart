import 'dart:async';

import 'package:movie_app_may/data/model/movie_model_impl.dart';
import 'package:movie_app_may/data/vos/actor_vo.dart';
import 'package:movie_app_may/data/vos/genre_vo.dart';
import 'package:movie_app_may/data/vos/movie_vo.dart';

import '../model/movie_model.dart';

class HomeBloc{

  // Reactive Streams
  StreamController<List<MovieVO>> mNowPlayingStreamController = StreamController();
  StreamController<List<MovieVO>> mPopularStreamController = StreamController();
  StreamController<List<MovieVO>> mTopRatedStreamController = StreamController();
  StreamController<List<MovieVO>> mMoivesByGenreListStreamController = StreamController();
  StreamController<List<GenreVO>> mGenreListStreamController = StreamController();
  StreamController<List<ActorVO>> mActorsStreamController = StreamController();

  // Models
  MovieModel mMovieModel = MovieModelImpl();

  HomeBloc(){
    mMovieModel.getNowPlayingMoviesFromDatabaseReativeStream()
        .listen((movieList) {
          mNowPlayingStreamController.sink.add(movieList);
    });

    mMovieModel.getPopularMoviesFromDatabaseReativeStream()
        .listen((movieList) {
      mPopularStreamController.sink.add(movieList);
    });

    mMovieModel.getTopRatedMoviesFromDatabaseReativeStream()
        .listen((movieList) {
      mTopRatedStreamController.sink.add(movieList);
    });

    mMovieModel.getActors(1)
        ?.then((actors) {
      mActorsStreamController.sink.add(actors);
    });

    mMovieModel.getAllActorsFromDatabase()
        .then((actors) {
      mActorsStreamController.sink.add(actors);
    });

    mMovieModel.getGenresFromDatabase()
        .then((genreList) {
      mGenreListStreamController.sink.add(genreList);

      /// Movies By Genre
      _getMoviesByGenreAndRefresh(genreList.first.id);
    });

    mMovieModel.getGenres()
        ?.then((genreList) {
      mGenreListStreamController.sink.add(genreList);

      /// Movies By Genre
      _getMoviesByGenreAndRefresh(genreList.first.id);
    });

  }

  void getMoviesByGenreAndRefresh(int genreId) {
    _getMoviesByGenreAndRefresh(genreId);
  }

  void _getMoviesByGenreAndRefresh(int genreId){
    mMovieModel.getMoviesByGenre(genreId)
        ?.then((movies) {
          mMoivesByGenreListStreamController.sink.add(movies);
    });
  }

  void dispose(){
    mNowPlayingStreamController.close();
    mPopularStreamController.close();
    mTopRatedStreamController.close();
    mMoivesByGenreListStreamController.close();
    mGenreListStreamController.close();
    mActorsStreamController.close();
  }
}