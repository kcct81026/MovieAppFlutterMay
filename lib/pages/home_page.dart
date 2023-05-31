import 'package:flutter/material.dart';
import 'package:movie_app_may/resources/colors.dart';
import 'package:movie_app_may/resources/dimens.dart';
import 'package:movie_app_may/viewitems/banner_view.dart';

import '../resources/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
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
        child: Column(
          children: [
            BannerSectionView(),

            Container(
              height: MOVIE_LIST_HEIGHT,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: MARGIN_MEDIUM_2),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    margin: EdgeInsets.only(right: 8.0),
                    width: MOVIE_LIST_ITEM_WIDTH,
                    color: Colors.blue,
                  );
                } ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerSectionView extends StatelessWidget {
  const BannerSectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: PageView(
        children: [
          BannerView(),
        ],
      ),
    );
  }
}
