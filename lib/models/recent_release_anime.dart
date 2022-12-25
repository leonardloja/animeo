// To parse this JSON data, do
//
//     final recentReleaseAnime = recentReleaseAnimeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RecentReleaseAnime> recentReleaseAnimeFromJson(String str) => List<RecentReleaseAnime>.from(json.decode(str).map((x) => RecentReleaseAnime.fromJson(x)));

String recentReleaseAnimeToJson(List<RecentReleaseAnime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentReleaseAnime {
  RecentReleaseAnime({
     required this.animeId,
     required this.episodeId,
     required this.animeTitle,
     required this.episodeNum,
     required this.subOrDub,
     required this.animeImg,
     required this.episodeUrl,
  });

  String animeId;
  String episodeId;
  String animeTitle;
  String episodeNum;
  String subOrDub;
  String animeImg;
  String episodeUrl;

  factory RecentReleaseAnime.fromJson(Map<String, dynamic> json) => RecentReleaseAnime(
    animeId: json["animeId"],
    episodeId: json["episodeId"],
    animeTitle: json["animeTitle"],
    episodeNum: json["episodeNum"],
    subOrDub: json["subOrDub"],
    animeImg: json["animeImg"],
    episodeUrl: json["episodeUrl"],
  );

  Map<String, dynamic> toJson() => {
    "animeId": animeId,
    "episodeId": episodeId,
    "animeTitle": animeTitle,
    "episodeNum": episodeNum,
    "subOrDub": subOrDub,
    "animeImg": animeImg,
    "episodeUrl": episodeUrl,
  };
}
