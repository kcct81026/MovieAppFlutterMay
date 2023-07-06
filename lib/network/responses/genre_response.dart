import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/genre_vo.dart';

part 'genre_response.g.dart';

@JsonSerializable()
class GetGenreResponse{

  @JsonKey(name: "genres")
  List<GenreVO>? genres;

  GetGenreResponse(this.genres);

  factory GetGenreResponse.fromJson(Map<String, dynamic> json) => _$GetGenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetGenreResponseToJson(this);
}