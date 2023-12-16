
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/discover/models/featured_talent.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../repository/discover_repo.dart';


// final discoverProvider = AsyncNotifierProvider<DiscoverController, String?>(
//     () => DiscoverController());


final discoverTalentProvider = StateProvider<TalentNotifier>(
    (ref) => TalentNotifier());



class TalentNotifier extends StateNotifier<AsyncValue<List<FeaturedTalent>>> {
  TalentNotifier() : super(const AsyncLoading());

  _init() {
    state = [] as AsyncValue<List<FeaturedTalent>>;
  }

  void getRTalent() async {
    state = const AsyncLoading();
    final discoverRepoInstance = DiscoverRepository.instance;

    final response = await discoverRepoInstance.getRT(4, 4);

    response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to get featured list');
      return [] as List<FeaturedTalent>;
    }, (right) {
      // final map = json.decode(right);

      final dList = right['risingTalents'] as List;

      final data = dList.map((e) => FeaturedTalent.fromJson(e)).toList();

      state = AsyncData([...data]);

      print('-------$data -------');

      print(data);

      // print('--- dlist -----$dList ----- ');

      // return dList as List;
    });
  }

  Future rT() async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response = await discoverRepoInstance.getRT(4, 4);

    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to get featured list');
      return [];
    }, (right) {
      final dList = right['risingTalents'];

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }
}
