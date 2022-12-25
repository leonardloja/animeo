import 'package:animeo/models/anime_streaming_link.dart';
import 'package:get/get.dart';
import '../services/remote_service.dart';

class VideoPlayerController extends GetxController {
  var showLoading = true.obs;

  Rx<AnimeStreamingLink>? animeStreamingLink = AnimeStreamingLink(
    headers: Headers(referer: ''),
    sources: [],
    download: '',
  ).obs;


  void fetchStreamingLink(String episodeID) async {
    animeStreamingLink!.value =
        await RemoteService().getAnimeStreamingLink(episodeID: episodeID);

    if (animeStreamingLink != null) {
      showLoading.value = false;
    }
  }
}
