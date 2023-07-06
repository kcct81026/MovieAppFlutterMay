import 'package:flutter/material.dart';
import 'package:movie_app_may/data/vos/actor_vo.dart';
import 'package:movie_app_may/data/vos/base_actor_vo.dart';
import 'package:movie_app_may/resources/colors.dart';

import '../network/api_constants.dart';
import '../resources/dimens.dart';

class ActorView extends StatelessWidget {

  final BaseActorVO actorVO;

  ActorView(this.actorVO);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Stack(
        children: [
          Positioned.fill(
            child: ActorImageView(actorVO.profilePath ?? ""),
          ),
          Padding(
            padding: EdgeInsets.all(MARGIN_MEDIUM),
            child: FavoriteButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: ActorNameAndLikeView(actorVO.name ?? ""),
          ),
        ],
      ),
    );
  }
}

class FavoriteButtonView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Icon(
        Icons.favorite_border,
        color: Colors.amber,
      ),
    );
  }
}

class ActorImageView extends StatelessWidget {
  final String image;

  ActorImageView(this.image);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL${image ?? ""}",
      fit: BoxFit.cover,
    );
  }
}

class ActorNameAndLikeView extends StatelessWidget {

  final String name;

  ActorNameAndLikeView(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MARGIN_MEDIUM_2,
        vertical: MARGIN_MEDIUM_2
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: TEXT_REGULAR_2X,
            ),
            maxLines: 1,
          ),

          Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.amber,
                size: MARGIN_MEDIUM_2,
              ),

              SizedBox(width: MARGIN_MEDIUM,),
              Text(
                "You Like 13 moives",
                style: TextStyle(
                  color: HOME_SCREEN_LIST_TITLE_COLOR,
                  fontSize: 12,

                ),
                maxLines: 1,

              ),
            ],
          ),

        ],
      ),
    );
  }
}
