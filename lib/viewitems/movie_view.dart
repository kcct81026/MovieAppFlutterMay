import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/vos/movie_vo.dart';
import '../network/api_constants.dart';
import '../resources/dimens.dart';
import '../widgets/rating_view.dart';

class MovieView extends StatelessWidget {

  final Function(int) onTapMovie;
  final MovieVO mMovie;

  MovieView(this.onTapMovie, this.mMovie);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTapMovie(mMovie.id);
      },
      child: Container(
        margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
        width: MOVIE_LIST_ITEM_WIDTH,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "$IMAGE_BASE_URL${mMovie?.posterPath ?? ""}",
              height: 200,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(height: MARGIN_MEDIUM_2,),
            Text(
              mMovie.title ?? mMovie.originalTitle ?? "",
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
            ),
            SizedBox(height: MARGIN_MEDIUM,),
            Row(
              children: [
                Text(
                  "8.9",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: TEXT_REGULAR
                  ),
                ),
                SizedBox(width: MARGIN_MEDIUM,),
                RatingView(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
