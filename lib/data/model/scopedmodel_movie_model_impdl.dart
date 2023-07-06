import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:movie_app_may/data/model/scopedmodel_movie_model.dart';
import 'package:movie_app_may/data/vos/actor_vo.dart';
import 'package:movie_app_may/data/vos/credit_vo.dart';
import 'package:movie_app_may/data/vos/genre_vo.dart';
import 'package:movie_app_may/data/vos/movie_vo.dart';
import 'package:movie_app_may/network/movie_data_agent.dart';
import 'package:movie_app_may/persistence/daos/actor_dao.dart';
import 'package:movie_app_may/persistence/daos/genre_dao.dart';
import 'package:movie_app_may/persistence/daos/movie_dao.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../network/retrofit_data_agent_impl.dart';
import 'movie_model.dart';

class ScopedModelMovieModelImpl extends ScopedModelMovieModel{
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();

  static final ScopedModelMovieModelImpl _singleton = ScopedModelMovieModelImpl._internal();

  factory ScopedModelMovieModelImpl(){
    return _singleton;
  }

  ScopedModelMovieModelImpl._internal(){

    getPopularMoviesFromDatabaseReativeStream();
    getTopRatedMoviesFromDatabaseReativeStream();
    getNowPlayingMoviesFromDatabaseReativeStream();
    getGenres();
    getActors(1);
  }

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  /// States
  List<MovieVO> mNowPlayingMovieList = [];
  List<MovieVO> mPopularMovieList = [];
  List<MovieVO> mTopRatedMovieList = [];
  List<GenreVO> mGenreList = [];
  List<ActorVO> mActors = [];
  List<MovieVO> mMoviesByGenreList = [];



  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }


  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId)?.then((movie) async{
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }


  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mDataAgent.getNowPlayingMovies(page)?.then((movies) {
      List<MovieVO> nowPlayingmovies = movies.map((movie){
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingmovies);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getPopularMovies(int page) {
    return mDataAgent.getPopularMovies(page)?.then((movies) async{
      List<MovieVO> movieList = movies.map((movie){
        movie.isPopular = true;
        movie.isTopRated = false;
        movie.isNowPlaying = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(movieList);
      return Future.value(movies);
    });
  }

  @override
  Future<List<MovieVO>>? getTopRatedMovies(int page) {
    return mDataAgent.getTopRatedMovies(page)?.then((movies) async{
      List<MovieVO> movieList = movies.map((movie) {
        movie.isTopRated  = true;
        movie.isNowPlaying  = false;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(movieList);
      return Future.value(movies);
    });
  }

  /// From Database
  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  @override
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isNowPlaying ?? true)
        .toList()
    );
  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isPopular ?? true )
        .toList()
    );
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    return Future.value(mMovieDao
        .getAllMovies()
        .where((movie) => movie.isNowPlaying ?? true)
        .toList()
    );
  }

  /// GET MOVIES FROM DATABASE REACTIVE STREAM
  @override
  void getNowPlayingMoviesFromDatabaseReativeStream() {
    this.getNowPlayingMoviesAndSaveIntoDB(1);
    mMovieDao
        .getAllMoviesEventSteam()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowShowingMovie())
        .listen((movieList) {
          mNowPlayingMovieList = movieList;
          print('------------------------------------- d now ${movieList.length}');
          notifyListeners();
    });
  }

  @override
  void getPopularMoviesFromDatabaseReativeStream() {
    this.getPopularMoviesAndSaveIntoDB(1);
    mMovieDao
        .getAllMoviesEventSteam()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovie())
        .listen((event) {
          mPopularMovieList = event;
          print('------------------------------------- d popular ${event.length}');
          notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesFromDatabaseReativeStream() {
    this.getTopRatedMoviesAndSaveIntoDB(1);
    mMovieDao
        .getAllMoviesEventSteam()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovie())
        .listen((event) {
          mTopRatedMovieList = event;
          print('------------------------------------- d popular ${event.length}');
          notifyListeners();
    });
  }

  //////////////////////////////////////////////////////////////// SCOPED MODEL
  @override
  void getNowPlayingMoviesAndSaveIntoDB(int page) {
    mDataAgent.getNowPlayingMovies(page)?.then((movies) async{
      List<MovieVO> nowPlayingLMovies = movies.map((movie){
        movie.isTopRated = false;
        movie.isNowPlaying = true;
        movie.isPopular = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(nowPlayingLMovies);
      mNowPlayingMovieList = nowPlayingLMovies;
      print('------------------------------------- nowPlayingLMovies ${nowPlayingLMovies.length}');
      notifyListeners();
    });
  }

  @override
  void getPopularMoviesAndSaveIntoDB(int page) {
    mDataAgent.getPopularMovies(page)?.then((movies) async{
      List<MovieVO> popularMovieList = movies.map((movie){
        movie.isPopular = true;
        movie.isNowPlaying = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovieList);
      mPopularMovieList = popularMovieList;
      print('------------------------------------- popularMovieList ${popularMovieList.length}');

      notifyListeners();
    });
  }

  @override
  void getTopRatedMoviesAndSaveIntoDB(int page) {
    mDataAgent.getTopRatedMovies(page)?.then((movies) async{
      List<MovieVO> topRatedMovieList = movies.map((movie){
        movie.isTopRated = true;
        movie.isPopular = false;
        movie.isNowPlaying = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(topRatedMovieList);
      mTopRatedMovieList = topRatedMovieList;
      debugPrint( '------------------------------------- topRatedMovieList ${topRatedMovieList.length}');
      notifyListeners();
    });
  }

  @override
  Future<List<GenreVO>>? getGenres() {
    return mDataAgent.getGenres()?.then((genres) async{
      mGenreDao.saveAllGenres(genres);
      mGenreList = genres;
      notifyListeners();
      getMoviesByGenre(genres.first.id)?.then((movieList) {
        mMoviesByGenreList = movieList;
        notifyListeners();
      });
      return Future.value(genres);

    });
  }

  @override
  Future<List<ActorVO>>? getActors(int page) {
    return mDataAgent.getActors(page)?.then((actors) async{
      print("--------------------- actors ${actors.length}");
      mActorDao.saveAllActors(actors);
      mActors = actors;
      notifyListeners();
      return Future.value(actors);
    });
  }

  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId) {
     mDataAgent.getMoviesByGenre(genreId)
         ?.then((movieList){
           mMoviesByGenreList = movieList;
           notifyListeners();
     });

  }



}