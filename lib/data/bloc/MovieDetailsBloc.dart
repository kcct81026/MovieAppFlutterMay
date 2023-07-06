import 'dart:async';

import 'package:movie_app_may/data/model/movie_model.dart';
import 'package:movie_app_may/data/model/movie_model_impl.dart';
import 'package:movie_app_may/data/vos/credit_vo.dart';

import '../vos/movie_vo.dart';

class MovieDetailsBloc{
  // Stream Controllers
  StreamController<MovieVO> mMovieStreamController = StreamController();
  StreamController<List<CreditVO>> creatorStreamController = StreamController();
  StreamController<List<CreditVO>> actorsStreamController = StreamController();
  StreamController<List<MovieVO>> relatedMoviesStreamController = StreamController();

  // Models
  MovieModel movieModel = MovieModelImpl();

  MovieDetailsBloc(int movieId){
    movieModel.getMovieDetails(movieId)
        ?.then((value) {
       mMovieStreamController.sink.add(value);
    });

    movieModel.getMovieDetailsFromDatabase(movieId)
        ?.then((movieVO) {
      _getRelatedMovies(movieVO?.genreIds?.first ?? movieVO?.genres?.first.id ?? 0);
      mMovieStreamController.sink.add(movieVO);
    });

    movieModel.getCreditsByMovie(movieId)
    ?.then((creditList){
      actorsStreamController.sink.add( creditList.where((credit) => credit.isActor()).toList());
      creatorStreamController.sink.add(creditList.where((creator) => creator.isCreator()).toList());
    });

  }

  void getReatedMovieByMovieId(MovieVO movieVO){
    _getRelatedMovies(movieVO?.genreIds?.first ?? movieVO?.genres?.first.id ?? 0);

  }

  void _getRelatedMovies(int genreId) {
    movieModel.getMoviesByGenre(genreId)?.then((relatedMovies) {
      relatedMoviesStreamController.sink.add(relatedMovies);
    });
  }

  void dispose(){
    mMovieStreamController.close();
    actorsStreamController.close();
    creatorStreamController.close();
    relatedMoviesStreamController.close();
  }
}