import 'package:flutter/material.dart';
import 'package:movie_app_may/resources/colors.dart';
import 'package:movie_app_may/resources/dimens.dart';

class BannerView extends StatelessWidget {
  const BannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          // Banner Image View
          Positioned.fill(
            child: BannerImageView(),
          ),

          // Gradient View
          Positioned.fill(
            child: GradientView(),
          ),

          // Banner Title View
          Align(
            alignment: Alignment.bottomLeft,
            child: BannerTitleView(),
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

class GradientView extends StatelessWidget {
  const GradientView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            PRIMARY_COLOR,
          ],
        ),
      ),
    );
  }
}

class PlayButtonView extends StatelessWidget {
  const PlayButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.play_circle_fill,
      size: BANNER_PLAY_BUTTON_SIZE,
      color: PLAY_BUTTON_COLOR,
    );
  }
}

class BannerTitleView extends StatelessWidget {
  const BannerTitleView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MARGIN_MEDIUM_2) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Bright Vachirawit Chivaaree",
            style: TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
          ),
          Text(
            "My Ecstasy",
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
  const BannerImageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_ETdRXFlGKN-JimCydDlOaB5UYHrYatsavA&usqp=CAU",
      fit: BoxFit.cover,
    );
  }
}
