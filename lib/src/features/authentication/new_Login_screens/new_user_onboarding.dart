import 'dart:async';

import 'package:cross_fade/cross_fade.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/authentication/register/views/sign_up.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../register/provider/user_types_controller.dart';
import 'widgets/business_selection.dart';
import 'widgets/main_talent_selection.dart';
import 'widgets/pet_breed_selection.dart';
import 'widgets/questions_selection.dart';
import 'widgets/talent_specialisation_selection.dart';

class UserOnBoardingPage extends ConsumerStatefulWidget {
  const UserOnBoardingPage({super.key});
  static const name = "signup/selection";

  @override
  ConsumerState<UserOnBoardingPage> createState() => _UserOnBoardingPageState();
}

class _UserOnBoardingPageState extends ConsumerState<UserOnBoardingPage> {
  bool isSelectedBusiness = false;
  bool isSelectedTalent = false;
  bool isShowSubTalent = false;
  bool isPet = false;
  bool isShowPetBreed = false;
  AccountTypes accountType = AccountTypes.none;
  List<String> subTalentList = [];
  List<String> petBreedList = [];

  // final int _selectedTalentIndex = -1;
  // final int _selectedTalentIndex = -1;
  // final int _selectedTalentIndex = -1;

  List businessList = [
    'to book Talent or Creators',
    'to gain access to jobs',
    'to book and get booked',
    'to network with other creators',
  ];

  List talentList = [
    "Model",
    "Influencer",
    "Digital Creator",
    "Beautician",
    "Digital Stylist",
    "Makeup Artistz",
    "Virtual Influencer",
    "Photographer",
    "Videographer",
    "Fashion Designer",
    "Hairstylist",
    "Stylist",
    "Artist",
    "Graphic Designer",
    "Dancer",
    "DJ",
    "Musician",
    "Actor",
    "Singer",
    "Content Writer",
    "Creative director",
    "Producer",
    "Fashion Enthusiast"
  ];

  final bgs = [
    'assets/images/bg_signup/bg1.png',
    'assets/images/bg_signup/bg2.png',
    'assets/images/bg_signup/bg3.png',
    'assets/images/bg_signup/bg4.png',
    'assets/images/bg_signup/bg5.png',
  ];

  int cBg = 0;
  final Stream _bgStream =
      Stream.periodic(const Duration(seconds: 7), (count) => count + 1);
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _sub = _bgStream.listen((event) {
      cBg = event % bgs.length;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedAccountTypeProvider, (p, n) {
      print('((>>>>>> selected user type is: $n');
    });
    final userTypes = ref.watch(accountTypesProvider);
    final allUserTypes = userTypes.valueOrNull;
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: [
          Positioned.fill(
            // width: double.maxFinite,
            // height: double.maxFinite,
            child: CrossFade<int>(
              value: cBg,
              duration: const Duration(seconds: 3),
              curve: Curves.easeInOut,
              builder: (context, i) => Image.asset(
                bgs[i],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
              top: 24,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    addVerticalSpacing(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: VmodelColors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            child: Text(
                              'BETA',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: VmodelColors.primaryColor,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 50.00,
                            height: 50.00,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    ExactAssetImage('assets/images/camera.png'),
                                fit: BoxFit.fitHeight,
                              ),
                            )),
                      ],
                    ),
                    Text(
                      "Welcome to VModel".toUpperCase(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: VmodelColors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    addVerticalSpacing(15),
                    Text(
                      "What will you use VModel for?",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: VmodelColors.primaryColor,
                              fontWeight: FontWeight.w600),
                    ),
                    const Spacer(flex: 2),
                    addVerticalSpacing(40),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              navigateToRoute(context, LoginPage());
                            },
                            child: Text(
                              "Already registered? Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: VmodelColors.white,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpacing(10),
                  ],
                ),
              )),

          // Question options
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            top: 52.h,
            // left: isSelectedBusiness || isSelectedTalent ? -100.w : 0,
            left: accountType == AccountTypes.none ? 0 : -100.w,
            child: QuestionSelection(
              onEnterpriseSelect: () {
                setState(() {
                  accountType = AccountTypes.enterprise;
                });
              },
              onTalentSelect: () {
                setState(() {
                  accountType = AccountTypes.talent;
                });
              },
            ),
          ),

          // if (true) //allUserTypes != null)
          //TalentList

          //Business
          if (allUserTypes != null)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              top: 52.h,
              // left: accountType == AccountTypes.enterprise ? 0 : 100.w,
              left: accountType == AccountTypes.enterprise
                  ? isShowSubTalent
                      ? -100.w
                      : 0
                  : 100.w,
              child: EnterpriseSelection(
                // isPrimaryScroll: !isShowSubTalent,
                onBackTap: () {
                  setState(() {
                    // isSelectedBusiness = false;
                    accountType = AccountTypes.none;
                  });
                },
                onItemTap: (index) {
                  print("[bussi] ${allUserTypes.businessLabels}");
                  ref.read(isAccountTypeBusinessProvider.notifier).state = true;

                  ref.read(selectedAccountTypeProvider.notifier).state =
                      allUserTypes.enterprise[index];

                  if (allUserTypes.enterprise[index].toLowerCase() ==
                      'booker') {
                    ref.read(selectedAccountLabelProvider.notifier).state = '';
                    subTalentList.clear();
                    isShowSubTalent = false;
                    navigateToRoute(context, const SignUpPage());
                    return;
                  }

                  //copy of the list must be made so that even when cleared
                  // the original will be available.
                  subTalentList = allUserTypes.businessLabels.toList();
                  isShowSubTalent = true;
                  setState(() {});
                  // });
                  // WidgetsBinding.instance.addPostFrameCallback((duration) {
                  // ref.read(selectedAccountTypeProvider.notifier).state =
                  //     allUserTypes.talents[index];
                  // });
                },
              ),
            ),

          //Talents
          if (allUserTypes != null)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              top: 52.h,
              // left: isSelectedTalent
              //     ? isShowSubTalent
              //         ? -100.w
              //         : 0
              //     : 100.w,
              left: accountType == AccountTypes.talent
                  ? isShowSubTalent
                      ? -100.w
                      : 0
                  : 100.w,
              child: MainTalentSelection(
                isPrimaryScroll: !isShowSubTalent,
                onBackTap: () {
                  setState(() {
                    accountType = AccountTypes.none;
                    // isSelectedBusiness = false;
                    // isSelectedTalent = false;
                  });
                },
                onItemTap: (index) {
                  HapticFeedback.lightImpact();
                  if (allUserTypes.talents[index]
                          .toLowerCase()
                          .contains('event planner') ||
                      allUserTypes.talents[index]
                          .toLowerCase()
                          .contains('chef') ||
                      allUserTypes.talents[index]
                          .toLowerCase()
                          .contains('cook') ||
                      allUserTypes.talents[index]
                          .toLowerCase()
                          .contains('baker')) {
                    ref.read(selectedAccountLabelProvider.notifier).state = '';
                    WidgetsBinding.instance.addPostFrameCallback((duration) {
                      ref.read(selectedAccountTypeProvider.notifier).state =
                          allUserTypes.talents[index];
                    });
                    navigateToRoute(context, const SignUpPage());
                    return;
                  }
                  isPet =
                      allUserTypes.talents[index].toLowerCase().contains('pet');

                  subTalentList.clear();
                  isShowSubTalent = true;
                  setState(() {});
                  allUserTypes
                      .getSubTalents(allUserTypes.talents[index])
                      .then((value) {
                    subTalentList = value;
                    setState(() {});
                  });
                  WidgetsBinding.instance.addPostFrameCallback((duration) {
                    ref.read(selectedAccountTypeProvider.notifier).state =
                        allUserTypes.talents[index];
                  });
                },
              ),
            ),

          // Sub-Talents
          if (allUserTypes != null)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              top: 52.h,
              left: isShowSubTalent
                  ? isShowPetBreed
                      ? -100.w
                      : 0
                  : 100.w,
              child: TalentSpecialisationSelection(
                talentSpecialisations: subTalentList,
                isPrimaryScroll: isShowSubTalent && !isShowPetBreed,
                isPet: isPet,
                onBackTap: () {
                  setState(() {
                    isShowSubTalent = false;
                  });
                },
                onItemTap: (index) {
                  if (isPet) {
                    isShowPetBreed = true;
                    // subTalentList.clear();
                    petBreedList =
                        allUserTypes.getPetBreed(subTalentList[index]);
                    setState(() {});
                  } else {
                    ref.read(selectedAccountLabelProvider.notifier).state =
                        subTalentList[index];
                    navigateToRoute(context, const SignUpPage());
                  }
                },
              ),
            ),

          //Pet-breed
          if (allUserTypes != null)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              top: 52.h,
              left: isShowPetBreed ? 0 : 100.w,
              child: PetBreedSelection(
                isPrimaryScroll: isShowPetBreed,
                petBreedList: petBreedList,
                onBackTap: () {
                  setState(() {
                    isShowPetBreed = false;
                  });
                },
                onItemTap: (index) {
                  ref.read(selectedAccountLabelProvider.notifier).state =
                      petBreedList[index];
                  navigateToRoute(context, const SignUpPage());
                },
              ),
            ),
        ],
      ),
    );
  }
}
