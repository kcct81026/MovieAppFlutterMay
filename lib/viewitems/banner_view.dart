import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_may/data/vos/movie_vo.dart';
import 'package:movie_app_may/resources/colors.dart';
import 'package:movie_app_may/resources/dimens.dart';

import '../network/api_constants.dart';
import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final Function(int) onTapMoive;
  final MovieVO mMoive;

  BannerView(this.onTapMoive, this.mMoive);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          // Banner Image View
          Positioned.fill(
            child: GestureDetector(
              onTap: (){
                this.onTapMoive(mMoive.id);
              },
              child: BannerImageView(mMoive.backDropPath ?? mMoive.posterPath ?? ""),
            ),
          ),

          // Gradient View
          Positioned.fill(
            child: GradientView(),
          ),

          // Banner Title View
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTitleView(mMoive.title ?? mMoive.originalTitle ?? ""),
          ),

          // Play Button View
          Align(
            child: PlayButtonView(),
          ),
        ],
      ),
    );
  }
}





class BannerTitleView extends StatelessWidget {

  final String title;

  BannerTitleView(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MARGIN_MEDIUM_2) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
          ),
          Text(
            "",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {
  final String imageURL;

  BannerImageView(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "$IMAGE_BASE_URL${imageURL ?? ""}",
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
      //fit: BoxFit.cover,
    );
  }
}
