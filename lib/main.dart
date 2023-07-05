import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app_may/data/model/scopedmodel_movie_model.dart';
import 'package:movie_app_may/data/model/scopedmodel_movie_model_impdl.dart';
import 'package:movie_app_may/data/vos/actor_vo.dart';
import 'package:movie_app_may/data/vos/base_actor_vo.dart';
import 'package:movie_app_may/data/vos/genre_vo.dart';
import 'package:movie_app_may/pages/home_page.dart';
import 'package:movie_app_may/pages/movie_details_page.dart';
import 'package:scoped_model/scoped_model.dart';

import 'data/vos/collection_vo.dart';
import 'data/vos/credit_vo.dart';
import 'data/vos/date_vo.dart';
import 'data/vos/movie_vo.dart';
import 'data/vos/production_company_vo.dart';
import 'data/vos/production_country_vo.dart';
import 'data/vos/spoken_languages_vo.dart';
import 'persistence/hive_constants.dart';

Future<void> main() async {

  await Hive.initFlutter();



  Hive.registerAdapter(ActorVOAdapter()); // ActorVOAdapter got from build runner binary oject
  Hive.registerAdapter(BaseActorVOAdapter());
  Hive.registerAdapter(CollectionVOAdapter());
  Hive.registerAdapter(CreditVOAdapter());
  Hive.registerAdapter(DateVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(ProductionCompanyVOAdapter());
  Hive.registerAdapter(ProductionCountryVOAdapter());
  Hive.registerAdapter(SpokenLanguagesVOAdapter());

  await Hive.openBox<ActorVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ScopedModelMovieModelImpl(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
