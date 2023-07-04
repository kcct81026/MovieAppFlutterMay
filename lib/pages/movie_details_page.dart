import 'package:flutter/material.dart';
import 'package:movie_app_may/pages/home_page.dart';
import 'package:movie_app_may/resources/colors.dart';
import 'package:movie_app_may/resources/dimens.dart';
import 'package:movie_app_may/resources/strings.dart';
import 'package:movie_app_may/widgets/actors_and_creators_section_view.dart';
import 'package:movie_app_may/widgets/gradient_view.dart';
import 'package:movie_app_may/widgets/rating_view.dart';
import 'package:movie_app_may/widgets/title_text.dart';

class MoiveDetailsPage extends StatelessWidget {
  final List<String> genreList = ["Singer", "Actor", "Model",
    "Ame Pa Pa"
  ];

  final int movieId;

  MoiveDetailsPage(this.movieId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliverAppBarView(
                () => Navigator.pop(context),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: TrailerSectionView(genreList),
                ),
                ActorAndCreatorsSectionView(
                  BEST_ACTOR_TITLE,
                  "",[],
                  seeMoreButtonVisibility: false,
                ),
                SizedBox(height: MARGIN_MEDIUM_2,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child:  AboutFilmSectionView(),
                ),
                SizedBox(height: MARGIN_MEDIUM_2,),
                ActorAndCreatorsSectionView(
                    CREATOR_TITLE, SEE_MORE_SHOWCASES_TITLE, []),
                SizedBox(height: MARGIN_MEDIUM_2,),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}


class AboutFilmSectionView extends StatelessWidget {

  //final MovieVO movieVO;

  //const AboutFilmSectionView(this.movieVO);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText("ABOUT FILM"),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
          "Original Title",
          "This is title"
          //movieVO.originalTitle ?? movieVO.title ?? "",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
          "Type",
         "This is type"
         // movieVO.genres?.map((genre) => genre.name).join(",") ?? "",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
            "Production",
           "This is Production"
           // movieVO.prodcutionCountries?.map((country) => country.name).join(",") ?? ""
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
          "Premier",
          "This is premiere"
          //movieVO.releaseDate ?? "",
        ),
        SizedBox(height: MARGIN_MEDIUM_2,),
        AboutFilmInfoView(
          "Description",
         "This is a long description. This is a long description.This is a long description. This is a long description. This is a long description. This is a long description.This is a long description.This is a long description.This is a long description.This is a long description.This is a long description."
         // movieVO.overview ?? "",
        ),
      ],
    );
  }
}

class AboutFilmInfoView extends StatelessWidget {

  final String label;
  final String description;

  const AboutFilmInfoView(this.label, this.description);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
              color: MOVIE_DETAIL_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2,),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSectionView extends StatelessWidget {
  final List<String> genreList;

  TrailerSectionView(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(height: MARGIN_MEDIUM_3,),
        StoryLineView(),
        SizedBox(height: MARGIN_MEDIUM_2,),
        PlayTrailerAndRateMoiveView(),
        SizedBox(height: MARGIN_MEDIUM_2,),
      ]);
  }
}

class PlayTrailerAndRateMoiveView extends StatelessWidget {
  const PlayTrailerAndRateMoiveView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieDetailsScreenButtonView(
            "PLAY TRAILER",
            PLAY_BUTTON_COLOR,
            Icon(
              Icons.play_circle_fill,
              color: Colors.black54,
            )
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2,),
        MovieDetailsScreenButtonView(
          "RATE MOVIE",
          HOME_SCREEN_BACKGROUND_COLOR,
          Icon(
            Icons.star,
            color: PLAY_BUTTON_COLOR,
          ),
          isGhostButton: true,
        ),

      ],
    );
  }
}

class StoryLineView extends StatelessWidget {
  const StoryLineView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAILS_STORYLINE_TITLE,),
        SizedBox(height: MARGIN_MEDIUM,),
        Text(
          "Bright Vachirawit Chivaaree, known professionally as Bright Vachirawit or Bright, is a Thai actor, singer, model, philanthropist, entertainer, entrepreneur and host. He is popular for his roles in F4 Thailand: Boys Over Flowers, 2gether: The Series, Astrophile, I Sea U and for variety show Toe Laew.",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieDetailsScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroudColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  const MovieDetailsScreenButtonView(
      this.title,
      this.backgroudColor,
      this.buttonIcon,
      {this.isGhostButton = false}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLLARGE,
      decoration: BoxDecoration(
        color: backgroudColor,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
        border: (isGhostButton) ? Border.all(
          color: Colors.white,
          width: 2,
        ) : null ,
      ),
      child: Center(
        child: Row(
          children: [
            buttonIcon,
            SizedBox(width: MARGIN_MEDIUM,),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    required this.genreList,
  }) ;

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      children: _createMovieTimeAndGenreWidget(),
    );
  }

  List<Widget> _createMovieTimeAndGenreWidget() {
    List<Widget> widgets = [
      Icon(
        Icons.access_time,
        color: PLAY_BUTTON_COLOR,
      ),
      SizedBox(width: MARGIN_SMALL),
      Container(
        child: Text(
          "2h 30min",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: MARGIN_MEDIUM),
    ];

    widgets.addAll(genreList.map((genre) => GenreChipView(genre)).toList());

    widgets.add(
      Icon(
        Icons.favorite_border,
        color: Colors.white,
      ),
    );
    return widgets;
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BG_COLOR,
          label: Text(
            genreText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
      ],
    );
  }
}


/*class MovieTimeAndGenreView extends StatelessWidget {
  MovieTimeAndGenreView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          "2h 30mins",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(width: MARGIN_SMALL,),
        Container(

          child: Row(
            children: [
              Wrap(
                direction: Axis.horizontal,
                spacing: MARGIN_SMALL,
                alignment: WrapAlignment.start,
                children: genreList
                    .map(
                      (genre) => GenreChipView(genre),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(width: MARGIN_SMALL,),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
            Chip(
              backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BG_COLOR,
              label: Text(
                genreText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          SizedBox(width: MARGIN_SMALL,)
    ],
    );
  }
}*/

class MovieDetailsSliverAppBarView extends StatelessWidget {

  final Function onTapBack;

  MovieDetailsSliverAppBarView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIE_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Positioned.fill(
              child: MovieDetailsAppBarImageView(),
            ),
            Positioned.fill(
              child: GradientView(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MARGIN_XXLLARGE, left: MARGIN_MEDIUM_2),
                child: BackButtonView(
                    (){
                      onTapBack();
                    }
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MARGIN_XXLLARGE + MARGIN_MEDIUM,
                  right: MARGIN_MEDIUM_2,
                ),
                child: SearchButtonView(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                ),
                child: MovieDetailsAppBarInfoView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailsAppBarInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("38879 VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    ),
                  ],
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  "1,27",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Text(
          "Bright Vachirawit Chivaaree",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  const MovieDetailsYearView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
      ),
      height: MARGIN_XXLLARGE,
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(
          MARGIN_XLLARGE,
        ),
      ),
      child: Center(
        child: Text(
          "1997",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {

  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapBack();
        },
      child: Container(
        width: MARGIN_XXLLARGE,
        height: MARGIN_XXLLARGE,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
          size: MARGIN_XLLARGE,
        ),
      ),
    );
  }
}

class MovieDetailsAppBarImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://static1.straitstimes.com.sg/s3fs-public/styles/large30x20/public/articles/2022/09/29/fhbright280922_1.jpg?VersionId=rcxQUvusUzyCFzttdPAoDJOmVhlJ3yT6",
      fit: BoxFit.cover,
    );
  }
}
