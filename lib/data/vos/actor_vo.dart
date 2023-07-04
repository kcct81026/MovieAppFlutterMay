import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
import 'base_actor_vo.dart';
import 'movie_vo.dart';

part 'actor_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACTOR_VO, adapterName: "ActorVOAdapter")
class ActorVO extends BaseActorVO{

 /* @JsonKey(name: "profile_path")
  String? profilePath;
*/
  @JsonKey(name: "adult")
  @HiveField(3)
  bool? adult;


  @JsonKey(name: "id")
  @HiveField(4)
  int id;

  @JsonKey(name: "known_for")
  @HiveField(5)
  List<MovieVO>? knownFor;
/*

  @JsonKey(name: "name")
  String? name;
*/

  @JsonKey(name: "popularity")
  @HiveField(6)
  double? popularity;


  ActorVO(this.adult, this.id, this.knownFor, this.popularity , String name, String? profilePath): super(name,profilePath);

  factory ActorVO.fromJson(Map<String, dynamic> json) => _$ActorVOFromJson(json);

  Map<String,dynamic> toJson() => _$ActorVOToJson(this);

}
