// To parse this JSON data, do
//
//     final animeDetails = animeDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnimeDetails animeDetailsFromJson(String str) => AnimeDetails.fromJson(json.decode(str));

String animeDetailsToJson(AnimeDetails data) => json.encode(data.toJson());

class AnimeDetails {
  AnimeDetails({
     required this.animeTitle,
     required this.type,
     required this.releasedDate,
     required this.status,
     required this.genres,
     required this.otherNames,
     required this.synopsis,
     required this.animeImg,
     required this.totalEpisodes,
     required this.episodesList,
  });

  String animeTitle;
  String type;
  String releasedDate;
  String status;
  List<String> genres;
  String otherNames;
  String synopsis;
  String animeImg;
  String totalEpisodes;
  List<EpisodesList> episodesList;

  factory AnimeDetails.fromJson(Map<String, dynamic> json) => AnimeDetails(
    animeTitle: json["animeTitle"],
    type: json["type"],
    releasedDate: json["releasedDate"],
    status: json["status"],
    genres: List<String>.from(json["genres"].map((x) => x)),
    otherNames: json["otherNames"],
    synopsis: json["synopsis"],
    animeImg: json["animeImg"],
    totalEpisodes: json["totalEpisodes"],
    episodesList: List<EpisodesList>.from(json["episodesList"].map((x) => EpisodesList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "animeTitle": animeTitle,
    "type": type,
    "releasedDate": releasedDate,
    "status": status,
    "genres": List<dynamic>.from(genres.map((x) => x)),
    "otherNames": otherNames,
    "synopsis": synopsis,
    "animeImg": animeImg,
    "totalEpisodes": totalEpisodes,
    "episodesList": List<dynamic>.from(episodesList.map((x) => x.toJson())),
  };
}

class EpisodesList {
  EpisodesList({
     required this.episodeId,
     required this.episodeNum,
     required this.episodeUrl,
  });

  String episodeId;
  String episodeNum;
  String episodeUrl;

  factory EpisodesList.fromJson(Map<String, dynamic> json) => EpisodesList(
    episodeId: json["episodeId"],
    episodeNum: json["episodeNum"],
    episodeUrl: json["episodeUrl"],
  );

  Map<String, dynamic> toJson() => {
    "episodeId": episodeId,
    "episodeNum": episodeNum,
    "episodeUrl": episodeUrl,
  };
}
