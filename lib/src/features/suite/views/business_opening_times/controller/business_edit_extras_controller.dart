import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../res/strings.dart';
import '../models/business_open_times_info.dart';
import 'business_open_times_controller.dart';

final businessInfoTag = NotifierProvider.autoDispose
    .family<BusinessOpenTimesNotifier, List<BusinessWorkingInfoTag>, String>(
        BusinessOpenTimesNotifier.new);

class BusinessOpenTimesNotifier
    extends AutoDisposeFamilyNotifier<List<BusinessWorkingInfoTag>, String> {
  // final _repository = BusinessOpeningInfoRepository.instance;

  final List<BusinessWorkingInfoTag> preDefinedExtras = [
    BusinessWorkingInfoTag(title: 'Live Band'),
    BusinessWorkingInfoTag(title: "Children's Playground"),
    BusinessWorkingInfoTag(title: "Parking"),
    BusinessWorkingInfoTag(title: "Free WiFi"),
  ];

  final List<BusinessWorkingInfoTag> preDefinedSafetyRules = [
    BusinessWorkingInfoTag(title: 'Employees wear masks'),
    BusinessWorkingInfoTag(title: "Appointment only, no walk-ins"),
    BusinessWorkingInfoTag(title: "Disinfected surfaces and venue"),
  ];
  String _mKey = '';

  @override
  List<BusinessWorkingInfoTag> build(arg) {
    _mKey = arg;
    return [];
  }

  void set(List<BusinessWorkingInfoTag> items, String key) {
    List<BusinessWorkingInfoTag> tempState = [];
    // if (items.isEmpty && key == _mKey) {
    if (items.isEmpty && key == VMString.businessExtraKey) {
      print('owowo22 setting if key: $key');
      tempState = preDefinedExtras;
      // return;
    } else if (items.isEmpty && key == VMString.businessSafetyRulesKey) {
      print('owowo22 setting else key: $key');
      tempState = preDefinedSafetyRules;
      // return;
    }
    print('owowo22 setting TAG ${state.length} key: $key $items');
    state = [...tempState, ...items];
  }

  void add(BusinessWorkingInfoTag item) {
    print('owowo22 adding TAG ${item.title}');
    // onTapped(item);
    // return;
    // if (isPredefinedSelected(item)) {
    //   return;
    // }
    if (existsAlready(item)) {
      return;
      // onTapped(item);
      // state = [
      //   for (var i in state)
      //     if (i != item) i
      // ];
    } else {
      print('else owowo22 adding TAG ${item.title}');
      state = [...state, item];
    }
  }

  bool existsAlready(BusinessWorkingInfoTag item) {
    // final res = state.contains(item);
    final res = state.any((element) => element.title == item.title);
    print('owowo22 $res TAG ${item.title}');
    return res;
    // return state.any((element) => element.title == item.title);
  }

  Future<bool> onTapped(BusinessWorkingInfoTag tag) async {
    // final res = state.contains(item);
    final res = state
        .any((element) => element.title == tag.title && element.id == null);
    // final res = state
    //     .any((element) => element.title == item.title && element.id == null);

    final currentState = state;
    final newState = [];
    for (var item in currentState) {
      if (item.title == tag.title && tag.id == null) {
        print('owowo2 BLK1 ${tag.title}');
        newState.add(item.copyWith(isSelected: !tag.isSelected));
        // print('owowo2 if $res TAG ${item.title} ${!item.isSelected}');
      } else if (item.title == tag.title && tag.id != null) {
        print('owowo2 BLK2 ${tag.title}');
        // final nott = ref.read(businessOpenTimesProvider(null).notifier);
        // if (_mKey == VMString.businessSafetyRulesKey) {
        //   await nott.removeSafetyRule(tag.id!);
        // } else if (_mKey == VMString.businessExtraKey) {
        //   await nott.removeExtraInfo(tag.id!);
        // }
        newState.add(item.copyWith(
            isDeleted: !tag.isDeleted, isSelected: !tag.isSelected));
        // } else {
        //   newState.add(item.copyWith(
        //       isDeleted: !tag.isDeleted, isSelected: !tag.isSelected));
        // }
        // print('owowo2 if $res TAG ${item.title} ${!item.isSelected}');
      } else {
        // item
        print('owowo2 BLK3 ${tag.title}');
        newState.add(item);
        // print('owowo2 else $res TAG ${item.title} ${item.isSelected}');
      }
    }
    print('owowo2 onTpped $state ');
    state = [...newState];
    print('owowo2 onTpped $state ');
    // state = [
    //   for (var item in currentState)
    //     if (item.title == tag.title)
    //       item.copyWith(isSelected: !item.isSelected)
    //     else
    //       item
    // ];
    return res;
    // return state.any((element) => element.title == item.title);
  }

  Future<bool> isPredefinedSelected(BusinessWorkingInfoTag tag) async {
    // final res = state.contains(item);
    // final res = state.any((element) => element.title == tag.title);
    // final res = state
    //     .any((element) => element.title == item.title && element.id == null);

    final currentState = state;
    // final newState = [];
    // for (var item in currentState) {
    //   if (item.title == tag.title && tag.id == null) {
    //     newState.add(item.copyWith(isSelected: !item.isSelected));
    //     // print('owowo2 if $res TAG ${item.title} ${!item.isSelected}');
    //   } else if (item.title == tag.title && tag.id != null) {
    //     final nott = ref.read(businessOpenTimesProvider(null).notifier);
    //     if (_mKey == VMString.businessSafetyRulesKey) {
    //       await nott.removeSafetyRule(tag.id!);
    //     } else if (_mKey == VMString.businessExtraKey) {
    //       await nott.removeExtraInfo(tag.id!);
    //     }
    //     newState.add(item.copyWith(id: null, isSelected: !item.isSelected));
    //     // print('owowo2 if $res TAG ${item.title} ${!item.isSelected}');
    //   } else {
    //     // item
    //     newState.add(item);
    //     // print('owowo2 else $res TAG ${item.title} ${item.isSelected}');
    //   }
    // }
    state = [
      for (var item in currentState)
        if (item.title == tag.title)
          item.copyWith(isSelected: !item.isSelected)
        else
          item
    ];
    return true;
    // return state.any((element) => element.title == item.title);
  }

  Future<void> onSave(String key) async {
    final nott = ref.read(businessOpenTimesProvider(null).notifier);
    final List<String> tagsToSave = [];

//new additions
    for (var x in state) {
      print('owowo2 save $x ');
      if (x.isDeleted) {
        _removeBusinessTag(x.id!);
      } else if (x.isSelected && x.id == null) {
        tagsToSave.add(x.title);
      }
    }

    // final tagsToSave = state
    //     .where((element) => element.id == null && element.isSelected)
    //     .map((e) => e.title);
//new additions
    if (tagsToSave.isEmpty) return;
    if (_mKey == VMString.businessExtraKey)
      await nott.addBusinessExtras(tagsToSave);
    else if (_mKey == VMString.businessSafetyRulesKey)
      await nott.addBusinessSafetyRule(tagsToSave);
  }

  Future<void> _removeBusinessTag(String id) async {
    final nott = ref.read(businessOpenTimesProvider(null).notifier);
    if (_mKey == VMString.businessSafetyRulesKey) {
      await nott.removeSafetyRule(id);
    } else if (_mKey == VMString.businessExtraKey) {
      await nott.removeExtraInfo(id);
    }

    state = [
      for (var item in state)
        if (item.id == id) item.copyWithNulledID else item
    ];

    print('owowo2 _remove $state ');
    // print('owowo2 save $x ');
  }
}
