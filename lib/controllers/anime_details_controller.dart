import 'package:animeo/models/anime_details.dart';
import 'package:get/get.dart';
import '../services/remote_service.dart';

class AnimeDetailsController extends GetxController {
  var showLoading = true.obs;
  Rx<AnimeDetails>? animeDetails = AnimeDetails(
      animeTitle: 'animeTitle',
      type: 'type',
      releasedDate: 'releasedDate',
      status: 'status',
      genres: [],
      otherNames: 'otherNames',
      synopsis: 'synopsis',
      animeImg: 'animeImg',
      totalEpisodes: 'totalEpisodes',
      episodesList: []).obs;


  void fetchAnimeDetails(String animeID) async {
    animeDetails!.value =
        await RemoteService().getAnimeDetails(animeID: animeID);
    if (animeDetails != null) {
      showLoading.value = false;
    }
  }
}
