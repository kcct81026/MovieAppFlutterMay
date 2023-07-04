import 'package:dio/dio.dart';
import 'package:movie_app_may/data/vos/actor_vo.dart';
import 'package:movie_app_may/data/vos/credit_vo.dart';
import 'package:movie_app_may/data/vos/genre_vo.dart';
import 'package:movie_app_may/data/vos/movie_vo.dart';
import 'package:movie_app_may/network/api_constants.dart';
import 'package:movie_app_may/network/movie_data_agent.dart';
import 'package:movie_app_may/network/the_moive_api.dart';

class RetrofitDataAgentImpl extends MovieDataAgent{

  late TheMovieApi mApi;

  static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl(){
    return _singleton;
  }

  RetrofitDataAgentImpl._internal(){
    final dio = Dio();
    mApi = TheMovieApi(dio);
  }


  @override
  Future<List<MovieVO>>? getNowPlayingMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<MovieVO>>? getPopularMovies(int page) {
    return mApi
        .getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<MovieVO>>? getTopRatedMovies(int page) {
    return mApi
        .getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<GenreVO>>? getGenres() {
    return mApi
        .getGenrees(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres ?? [])
        .first;
  }
  @override
  Future<List<MovieVO>>? getMoviesByGenre(int genreId) {
    return mApi
        .getMoviesByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }

  @override
  Future<List<ActorVO>>? getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.actors ?? [])
        .first;
  }

  @override
  Future<List<CreditVO>>? getCreditsByMovie(int movieId) {
    return mApi
        .getCreditsByMovieResponse(movieId.toString(), API_KEY, LANGUAGE_EN_US, "1")
        .asStream()
        .map((response) => response.cast ?? [])
        .first;
  }

  @override
  Future<MovieVO>? getMovieDetails(int movieId) {
    return mApi
        .getMovieDetail(movieId.toString(), API_KEY, LANGUAGE_EN_US, "1")
        .asStream()
        .map((response) => response)
        .first;
  }
}