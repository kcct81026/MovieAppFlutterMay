import 'package:flutter/material.dart';
import 'package:movie_app_may/resources/dimens.dart';
import 'package:movie_app_may/widgets/play_button_view.dart';
import 'package:movie_app_may/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://cdn1.forevergeek.com/uploads/33/2023/02/Bright-Bua-930x663.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: PlayButtonView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(MARGIN_MEDIUM_2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Saturday Night",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: TEXT_REGULAR_3X,
                    ),
                  ),
                  SizedBox(height: MARGIN_SMALL,),
                  TitleText("27 December 1997")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
