import 'package:flutter/material.dart';
import 'package:movie_app_may/data/vos/base_actor_vo.dart';
import 'package:movie_app_may/resources/colors.dart';
import 'package:movie_app_may/widgets/title_text_with_see_more_view.dart';

import '../data/vos/actor_vo.dart';
import '../resources/dimens.dart';
import '../viewitems/actor_view.dart';

class ActorAndCreatorsSectionView extends StatelessWidget {

  final String title;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;
  final List<BaseActorVO> actorList;

  ActorAndCreatorsSectionView(
      this.title,
      this.seeMoreText,
      this.actorList,
      {this.seeMoreButtonVisibility = true}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: MARGIN_MEDIUM_2,),
      color: PRIMARY_COLOR,
      child: Column(
        children: [
          SizedBox(height: MARGIN_MEDIUM_2,),
          Padding(
            padding: EdgeInsets.only(
              left: MARGIN_MEDIUM_2,
              right: MARGIN_MEDIUM_2,
              top: MARGIN_MEDIUM_2,
            ) ,
            child: TitleTextWithSeeMoreView(
              title,
              seeMoreText,
              seeMoreButtonVisibility: this.seeMoreButtonVisibility,
            ),
          ),


          SizedBox(height: MARGIN_LARGE,),

          Container(
            height: BEST_ACTORS_HEIGHT,
            child: ListView(
              padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
              scrollDirection: Axis.horizontal,
              children: actorList
                .map((actor) => ActorView(actor)).toList()
              ,
            ),
          ),
        ],
      ),
    );
  }
}