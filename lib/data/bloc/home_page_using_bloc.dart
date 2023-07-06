import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_may/data/bloc/HomeBloc.dart';
import 'package:movie_app_may/data/bloc/movie_detail_using_bloc.dart';
import 'package:movie_app_may/data/model/movie_model_impl.dart';
import 'package:movie_app_may/data/model/scopedmodel_movie_model_impdl.dart';
import 'package:movie_app_may/pages/movie_details_page.dart';
import 'package:movie_app_may/resources/colors.dart';
import 'package:movie_app_may/resources/dimens.dart';
import 'package:movie_app_may/viewitems/actor_view.dart';
import 'package:movie_app_may/viewitems/banner_view.dart';
import 'package:movie_app_may/viewitems/movie_view.dart';
import 'package:movie_app_may/viewitems/showcase_view.dart';
import 'package:movie_app_may/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app_may/widgets/see_more_text.dart';
import 'package:movie_app_may/widgets/title_text.dart';
import 'package:movie_app_may/widgets/title_text_with_see_more_view.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../resources/strings.dart';
import '../vos/actor_vo.dart';
import '../vos/genre_vo.dart';
import '../vos/movie_vo.dart';


class HomePageUsingBloc extends StatefulWidget {

  @override
  State<HomePageUsingBloc> createState() => _HomePageUsingBlocState();
}

class _HomePageUsingBlocState extends State<HomePageUsingBloc> {
  HomeBloc _bloc = HomeBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
        title: Center(
          child: Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        leading: Icon(
          Icons.menu,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 0,
              left: 0,
              right: MARGIN_MEDIUM_2,
              bottom: 0,
            ),
            child: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Container(
        color: PRIMARY_COLOR,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: _bloc.mTopRatedStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> snapshot) {
                  return  (snapshot.hasData) ?
                  BannerSectionView(
                    snapshot.data?.take(8)?.toList() ?? [],
                        (movieId) => _navigateToMovieDetailsScreen(context, movieId),
                  )
                      : Center(child: CircularProgressIndicator(),);
                },
              ),


              SizedBox(height: MARGIN_LARGE,),

              StreamBuilder(
                stream: _bloc.mPopularStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> snapshot) {
                  return  (snapshot.hasData) ?
                  BestPopularMoviesAndSeriesSectionView(
                          (movieId) => _navigateToMovieDetailsScreen(context, movieId),
                      snapshot.data ?? []
                  ) : Center(child: CircularProgressIndicator(),);
                },
              ),




              SizedBox(height: MARGIN_LARGE,),

              MovieShowTimeSectionView(),

              SizedBox(height: MARGIN_LARGE,),

              StreamBuilder(
                stream: _bloc.mGenreListStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<GenreVO>> genreListSnapShot) {
                  return StreamBuilder(
                    stream: _bloc.mMoivesByGenreListStreamController.stream,
                    builder: (BuildContext context, AsyncSnapshot<List<MovieVO>> mMoiveByGenreIdSnapShot) {
                      return GenreSectionView(
                            (movieId) => _navigateToMovieDetailsScreen(context,movieId),
                        genreListSnapShot.data ?? [],
                        mMoiveByGenreIdSnapShot.data ?? [], (genreId) => _bloc.getMoviesByGenreAndRefresh(genreId),

                      );
                    },

                  );
                },

              ),

              const SizedBox(height: MARGIN_LARGE,),

              ShowCaseSectionView(),

              const SizedBox(height: MARGIN_LARGE,),

              StreamBuilder(
                stream: _bloc.mActorsStreamController.stream,
                builder: (BuildContext context, AsyncSnapshot<List<ActorVO>> snapshot) {
                  return ActorAndCreatorsSectionView(ACTOR_TITLE, BEST_ACTOR_SEE_MORE, snapshot.data ?? []);
                },
              ),
              SizedBox(height: MARGIN_LARGE,),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int movieId) {
    print("---------------------- clcik click");
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MoiveDetailsPageUsingBloc(movieId)
    ));
  }
}

class GenreSectionView extends StatelessWidget {


  final Function(int) onTapMovie;
  final Function(int) onTapGenre;
  final List<GenreVO> mGenreList;
  final List<MovieVO> mMoviesListByGenre;

  const GenreSectionView(this.onTapMovie, this.mGenreList, this.mMoviesListByGenre,this.onTapGenre);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: mGenreList.length,
            child: TabBar(
              onTap: (index){
                onTapGenre(index);
              },
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs:
              mGenreList.map(
                    (genre) => Tab(
                  child: Text(genre.name ?? ""),
                ),
              ).toList(),

            ),
          ),
        ),
        Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          padding: EdgeInsets.only(
              top: MARGIN_MEDIUM_2,
              bottom: MARGIN_LARGE
          ),
          child: HorizontalMovieListView(
                  (moveiId){
                this.onTapMovie(moveiId);
              },
              mMoviesListByGenre
          ),
        ),
      ],
    );
  }
}



class ShowCaseSectionView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2) ,
          child: TitleTextWithSeeMoreView(
            SHOWCASE_TITLE,
            SEE_MORE_SHOWCASES_TITLE,
          ),
        ),

        SizedBox(height: MARGIN_MEDIUM_2,),

        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: [
              ShowCaseView(),
              ShowCaseView(),
            ],
          ),
        ),
      ],
    );
  }
}

class MovieShowTimeSectionView extends StatelessWidget {
  const MovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HOME_SCREEN_BACKGROUND_COLOR,
      margin: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2
      ),
      padding: EdgeInsets.all(MARGIN_LARGE),
      height: SHOWTIME_SECTION_HEIGHT,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                MAIN_SCREEN_SHOWTIME_TITLE,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_HEADING_1X,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              SeeMoreText(MAIN_SCREEN_SHOWTIME_SEE_MORE, textColor: Colors.amber,)
            ],
          ),
          Spacer(),
          Icon(
            Icons.location_on_rounded,
            color: Colors.white,
            size: BANNER_PLAY_BUTTON_SIZE,
          ),
        ],
      ),
    );
  }
}


class BestPopularMoviesAndSeriesSectionView extends StatelessWidget {
  final Function(int) onTapMoive;
  final List<MovieVO> mPopularMovieList;

  BestPopularMoviesAndSeriesSectionView(this.onTapMoive, this.mPopularMovieList);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: TitleText(BEST_POPULAR_TITLE),
        ),

        SizedBox(height: MARGIN_MEDIUM_2,),

        HorizontalMovieListView(
                (movieId){
              onTapMoive(movieId);
            },
            mPopularMovieList
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {

  final Function(int) onTapMovie;
  final List<MovieVO> mPopularMovieList;

  HorizontalMovieListView(this.onTapMovie, this.mPopularMovieList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_HEIGHT,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
        itemCount: mPopularMovieList.length,
        itemBuilder: (BuildContext context, int index){
          return MovieView(
                  (movieId){this.onTapMovie(movieId);},
              mPopularMovieList[index]
          );
        } ,
      ),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO> mPopularMovieList;
  final Function(int) onTapMoive;

  BannerSectionView(this.mPopularMovieList, this.onTapMoive);

  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {

  double _position = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          child: PageView(
            onPageChanged: (page){
              setState(() {
                _position = page.toDouble();
              });
            },
            children: widget.mPopularMovieList
                .map( (popularMoive) => BannerView(
                    (movieId) => widget.onTapMoive(movieId),
                popularMoive
            ),
            ).toList(),

          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        DotsIndicator(
          dotsCount: widget.mPopularMovieList.length,
          position: _position.toInt(),
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        ),
      ],
    );
  }
}
