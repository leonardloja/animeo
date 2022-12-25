import 'package:animeo/models/recent_release_anime.dart';
import 'package:animeo/models/top_airing_anime.dart';
import 'package:get/get.dart';
import '../models/popular_anime.dart';
import '../services/remote_service.dart';

class HomeController extends GetxController {
  var showLoading = true.obs;


  RxList<PopularAnime>? popularAnime = <PopularAnime>[].obs;
  RxList<RecentReleaseAnime>? recentReleaseAnime = <RecentReleaseAnime>[].obs;
  RxList<TopAiringAnime>? topAiringAnime = <TopAiringAnime>[].obs;

  @override
  void onInit() async {
    super.onInit();
    fetchPopularAnime();
    fetchRecentReleaseAnime();
    fetchTopAiringAnime();
  }

  void fetchPopularAnime() async {
    showLoading.value = true;
    popularAnime?.value = await RemoteService().getPopularAnime();
    if (topAiringAnime != null) {
      showLoading.value = false;
    }
  }

  void fetchRecentReleaseAnime() async {
    showLoading.value = true;
    recentReleaseAnime?.value = await RemoteService().getRecentReleaseAnime();
    if (topAiringAnime != null) {
      showLoading.value = false;
    }
  }

  void fetchTopAiringAnime() async {
    showLoading.value = true;
    topAiringAnime?.value = await RemoteService().getTopAiringAnime();
    if (topAiringAnime != null) {
      showLoading.value = false;
    }
  }
}
