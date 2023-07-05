import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_may/widgets/title_text.dart';

import '../data/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/movie_view.dart';
import '../widgets/smart_list_view.dart';

class TitleAndHorizontalMovieListView extends StatelessWidget {

  final Function(int) onTapMovie;

  final List<MovieVO> mNowPlayingMovieList;
  final String title;
  final Function onListEndReached;

  TitleAndHorizontalMovieListView(this.onTapMovie, this.mNowPlayingMovieList, {required this.title, required this.onListEndReached});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          //alignment: Alignment.topLeft,
          child: TitleText(title),
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        HorizontalMovieListView(
              (movieId){ onTapMovie(movieId);},
          movieList: mNowPlayingMovieList,
          onListEndReached: (){
            this.onListEndReached();
          },
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {

  final Function(int) onTapMovie;
  final List<MovieVO> movieList;
  final Function onListEndReached;

  HorizontalMovieListView(this.onTapMovie, {required this.movieList, required this.onListEndReached } );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
      /*? ListView.builder(
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: movieList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            return MovieView(
                  (movieId){
                onTapMovie(movieId);
              },
              movieList[index],
            );
          },
         ) */
          ? SmartHorizontalListView(
          padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: movieList?.length ?? 0,
          itemBuilder:  (BuildContext context, int index){
            return MovieView(
                  (movieId){
                onTapMovie(movieId);
              },
              movieList[index],
            );
          },
          onListEndReached: (){
            this.onListEndReached();
          })
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}