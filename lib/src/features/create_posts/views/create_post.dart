import 'dart:typed_data';

import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_trigger_autocomplete/multi_trigger_autocomplete.dart';
import 'package:vmodel/src/core/network/graphql_service.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/create_posts/widgets/image_with_stack_icons.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/features/dashboard/new_profile/model/gallery_model.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/controller/discard_editing_controller.dart';
import '../../../core/controller/gmap_places_controller.dart';
import '../../../core/models/app_user.dart';
import '../../../core/utils/enum/album_type.dart';
import '../../../core/utils/extensions/custom_text_input_formatters.dart';
import '../../../shared/response_widgets/toast.dart';
import '../../../shared/text_fields/dropdown_text_normal.dart';
import '../../../shared/text_fields/places_autocomplete_field.dart';
import '../../dashboard/discover/controllers/discover_controller.dart';
import '../../dashboard/new_profile/controller/gallery_controller.dart';
import '../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../settings/views/booking_settings/models/service_package_model.dart';
import '../controller/create_post_controller.dart';
import '../controller/cropped_data_controller.dart';
import '../controller/posts_location_history.dart';
import '../widgets/dialog_create_gallery.dart';
import '../widgets/preview_post.dart';
import 'chip_input_field.dart';
import 'mentionable_field.dart';

final myStreamProvider = StreamProvider.autoDispose((ref) {
  final myService = ref.watch(authProvider.notifier);
  return myService.getAlbum(myService.state.username!);
});

class CreatePostPage extends ConsumerStatefulWidget {
  final UploadAspectRatio aspectRatio;
  final List<Uint8List> images;
  const CreatePostPage(
      {super.key, required this.aspectRatio, required this.images});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  String selectedChip = "Model";
  bool isImageSelected = false;
  bool alertComment = false;
  bool polaroidSwitchValue = false;
  String dropdownIdentifyValue = "Features";
  GalleryModel? selectedAlbum;
  ServicePackageModel? selectedService;
  AlbumType dropdownPolariodValue = AlbumType.portfolio;

  // final TextEditingController _controller = TextEditingController();
  // final TextEditingController _album = TextEditingController();
  final TextEditingController _caption = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  // late Stream getData;
  bool showUploadOverlay = false;
  int maxNumberOfMentions = 5;
  final List<VAppUser> featured = [];
  final _scrollController = ScrollController();
  String? _selectedLocation;
  int _imageTapCount = 0;

  @override
  void initState() {
    super.initState();
    initDiscardProvider();
  }

  initDiscardProvider() {
    ref.read(discardProvider.notifier).initialState('gallery',
        initial: selectedAlbum?.id, current: selectedAlbum?.id);
    ref.read(discardProvider.notifier).initialState('caption',
        initial: _caption.text, current: _caption.text);
    ref.read(discardProvider.notifier).initialState('location',
        initial: _locationController.text, current: _locationController.text);
    ref
        .read(discardProvider.notifier)
        .initialState('featured', initial: featured, current: featured);
  }

  @override
  void dispose() {
    widget.images;
    // if (mounted) {
    // if (ref.context.mounted) {
    //   ref.invalidate(discardProvider);
    // }
    super.dispose();
  }

  void _incrementCount(List<Uint8List> images) {
    _imageTapCount++;
    print('+-= Count is $_imageTapCount');
    if (_imageTapCount % 2 == 0) {
// navigateToRoute(context, )

      showDialog(
          context: context,
          barrierColor: Colors.black,
          builder: (context) {
            return PostPreview(
              aspectRatio: widget.aspectRatio,
            );
          });
      // showGeneralDialog(
      //     context: context,
      //     anchorPoint: Offset(0.5, 0.5),
      //     barrierColor: Colors.black,
      //     pageBuilder: (context, _, __) {
      //       return Center(
      //         // alignment: Alignment.center,
      //         child: PostPreview(
      //           aspectRatio: widget.aspectRatio,
      //         ),
      //       );
      //     });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authNotifier = ref.read(authProvider.notifier);
    // final pst = ref.watch(myStreamProvider);
    final services = ref.watch(servicePackagesProvider(null));
    ref.watch(discardProvider);
    final suggestedLocations = ref.watch(suggestedPostLocationProvider);
    print(widget.images);
    ref.listen(searchUsersProvider, (p, n) {
      if (n.valueOrNull != null && n.value!.isNotEmpty)
        print('[pp] ${n.value?.first.username} ${n.value?.length}');
    });
    final suggestedUsers = ref.watch(searchUsersProvider);
    final uploadPercentage = ref.watch(uploadProgressProvider);
    // final pst = ref.watch(albumsProvider(null));

    final pst = ref.watch(galleryProvider(null));
    // final imagesx = ref.watch(croppedImagesToUploadProviderx);
    final images = ref.watch(croppedImagesProvider);

    // ref.listen(uploadProgressProvider, (prev, next) {
    //   if (next == 0.1 && context.mounted) {
    //     goBack(context);
    //   }
    // });

    return WillPopScope(
      onWillPop: () async {
        return onPopPage(context, ref);
      },
      child: Scaffold(
          appBar: VWidgetsAppBar(
            // backgroundColor: VmodelColors.white,
            appBarHeight: 50,
            leadingIcon: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: VWidgetsBackButton(
                onTap: () {
                  onPopPage(context, ref);
                },
              ),
            ),
            appbarTitle: "New post",
            customBottom: widget.images.isNotEmpty && uploadPercentage > 0.0
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight + 4),
                    child: LinearProgressIndicator(
                      value: uploadPercentage >= 1.0 ? null : uploadPercentage,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  )
                : null,
          ),
          body: pst.when(
            data: (value) {
              // final List<dynamic> albums = data['albums']['data'];
              // final List<String> names =
              //     albums.map((album) => album['name'] as String).toList();
              // print(names);
              final type = polaroidSwitchValue
                  ? AlbumType.polaroid
                  : AlbumType.portfolio;
              final data = value.where((element) {
                return element.galleryType == type;
              }).toList();

              return Portal(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListView(
                    padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                    children: [
                      addVerticalSpacing(20),
                      SizedBox(
                          height: 142,
                          child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              // itemExtent: widget.images.length.toDouble(),
                              // itemCount: widget.images.length + 1,
                              itemCount: widget.images.isNotEmpty
                                  ? widget.images.length + 1
                                  : images.length + 1,
                              itemBuilder: (context, index) {
                                if (index == images.length) {
                                  return _addMore();
                                }
                                return VWidgetsStackImage(
                                  image: widget.images.isNotEmpty
                                      ? MemoryImage(widget.images[0])
                                      : MemoryImage(images[index]),
                                  bottomLeftIconOnPressed: () {
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //   return TapAndHold(
                                    //     item: rv[index],
                                    //   );
                                    // });
                                    ref
                                        .read(croppedImagesProvider.notifier)
                                        .removeImageAt(index);
                                  },
                                  topRightIconOnPressed: () {},
                                  isImageSelected: isImageSelected,
                                  onTapImage: () {
                                    // print(images.length);
                                    _incrementCount(images);
                                    setState(() {
                                      isImageSelected = !isImageSelected;
                                    });
                                  },
                                );
                              })),
                      addVerticalSpacing(25),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Polaroid Post",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .displayMedium!
                      //             .copyWith(
                      //                 color: VmodelColors.primaryColor,
                      //                 fontWeight: FontWeight.w600)),
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 12),
                      //       child: VWidgetsSwitch(
                      //           swicthValue: polaroidSwitchValue,
                      //           onChanged: (p0) {
                      //             selectedAlbum = null;
                      //             polaroidSwitchValue = !polaroidSwitchValue;
                      //             setState(() {});
                      //           }),
                      //     )
                      //   ],
                      // ),
                      addVerticalSpacing(10),
                      // const VWidgetsPrimaryTextFieldWithTitle(
                      //   label: "Features",
                      //   hintText: "@",
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select gallery',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: VmodelColors.primaryColor,
                                  )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) => CreateGalleryDialog(
                                            isPolaroid: polaroidSwitchValue)

                                        /*
                                  VWidgetsAddAlbumPopUp(
                                    controller: _controller,
                                    popupTitle: "Create a new album",
                                    buttonTitle: "Continue",
                                    textFieldlabel: "Add Name :",
                                    onPressed: () async {
                                      VLoader.changeLoadingState(true);
                                      final albumName = _controller
                                          .text.capitalizeFirst!
                                          .trim();
                                      await ref
                                          .read(albumsProvider(null).notifier)
                                          .createAlbum(albumName);
                                      // await ref
                                      //     .read(albumsProvider.notifier)
                                      //     .createAlbum(
                                      //         _controller.text.capitalizeFirst!
                                      //             .trim(),
                                      //         userIDPk!)
                                      //     .then((value) =>
                                      //         ref.refresh(myStreamProvider));
                                      if (mounted) {
                                        goBack(context);
                                      }
    
                                      VLoader.changeLoadingState(false);
                                    },
                                  )));
    */
                                        // Navigator.pop(context);
                                        ));
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VWidgetsDropdownNormal(
                                value: dropdownPolariodValue,
                                items: AlbumType.values,
                                validator: (vak) {
                                  return null;
                                },
                                onChanged: (val) {
                                  dropdownPolariodValue = val!;
                                  if (val == AlbumType.polaroid) {
                                    polaroidSwitchValue = true;
                                  } else {
                                    polaroidSwitchValue = false;
                                  }
                                  selectedAlbum = null;
                                  ref
                                      .read(discardProvider.notifier)
                                      .updateState('gallery', newValue: '');
                                  setState(() {});
                                },
                                itemToString: (val) =>
                                    val.name.capitalizeFirstVExt),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: FocusScope(
                              autofocus: true,
                              child: VWidgetsDropdownNormal(
                                hintText: "Select",
                                items: data,
                                value: selectedAlbum,
                                validator: (val) {
                                  if (val == null) {
                                    return 'Select gallery';
                                  }
                                  return null;
                                },
                                itemToString: (val) => val.name,
                                onChanged: (val) {
                                  selectedAlbum = val;
                                  ref
                                      .read(discardProvider.notifier)
                                      .updateState('gallery',
                                          newValue: selectedAlbum?.id);
                                  setState(() {
                                    // dropdownIdentifyValue = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpacing(16),
                      services.maybeWhen(
                          data: (data) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: FocusScope(
                                    autofocus: true,
                                    child: VWidgetsDropdownNormal<
                                        ServicePackageModel>(
                                      hintText: "Select...",
                                      items: data,
                                      value: selectedService,
                                      fieldLabel: 'Add a service',
                                      validator: (val) {
                                        return null;
                                      },
                                      isExpanded: true,
                                      itemMaxLines: 1,
                                      itemTextOverflow: TextOverflow.ellipsis,
                                      itemToString: (val) => val.title,
                                      onChanged: (val) {
                                        selectedService = val;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          orElse: () => SizedBox.shrink()),
                      addVerticalSpacing(16),
                      Text("Features",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  // color: VmodelColors.primaryColor,
                                  fontWeight: FontWeight.w600)),
                      addVerticalSpacing(4),

                      VWidgetChipsField(
                        maxNumberOfChips: maxNumberOfMentions,
                        onChanged: (data) {
                          featured.clear();
                          featured.addAll(data);

                          ref
                              .read(discardProvider.notifier)
                              .updateState('featured', newValue: featured);
                        },
                        suggestions: (query) async {
                          if (query.isEmpty &&
                              featured.length > maxNumberOfMentions) {
                            return [];
                          }
                          final lll = await ref
                              .read(discoverProvider.notifier)
                              .searchUsers(query);
                          print('[pps  future completed ${lll.length}');

                          ref
                              .read(discardProvider.notifier)
                              .updateState('featured', newValue: lll);
                          return lll;
                          // return searchList.valueOrNull ?? [];
                          // print(
                          //     '[pp] the search results is ${searchList.value?.length}');
                        },
                      ),

                      addVerticalSpacing(25),

                      PlacesAutocompletionField(
                        controller: _locationController,
                        // placePredictions: placePredictions,
                        // initialValue: _selectedLocation,
                        label: "Location",
                        hintText: "Search location",
                        onItemSelected: (value) {
                          if (!mounted) return;
                          // WidgetsBinding.instance
                          // .addPostFrameCallback((timeStamp) {
                          // setState(() {
                          _selectedLocation = value;
                          ref.read(discardProvider.notifier).updateState(
                              'location',
                              newValue: _selectedLocation);
                          // _isShowAddressPredictions = false;
                          // });
                          // });
                        },
                        postOnChanged: (String value) {
                          ref
                              .read(discardProvider.notifier)
                              .updateState('location', newValue: value);
                          if (!mounted) return;
                        },
                      ),

                      suggestedLocations.when(data: (items) {
                        return Center(
                          child: Container(
                            height: 40,
                            // padding: EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.builder(
                              itemCount: items.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      _selectedLocation = items[index];
                                      _locationController.text =
                                          _selectedLocation ?? '';

                                      ref
                                          .read(discardProvider.notifier)
                                          .updateState('location',
                                              newValue: _selectedLocation);

                                      ref
                                          .read(
                                              placeSearchQueryProvider.notifier)
                                          .state = '';
                                      setState(() {});
                                    },
                                    child: Chip(
                                      backgroundColor: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .secondary,
                                      side: BorderSide.none,
                                      // labelPadding: EdgeInsets.zero,
                                      // padding: EdgeInsets.only(left: 0, right: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // avatar: Icon(Icons.arrow_outward_outlined, size: 20),
                                      label: Text(items[index]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }, error: (err, stackTrace) {
                        print('$err, $stackTrace');
                        return SizedBox.shrink();
                      }, loading: () {
                        return Chip(
                          label: Text('Loding'),
                        );
                      }),
                      // VWidgetsPrimaryTextFieldWithTitle(
                      //   label: "Location",
                      //   controller: _location,
                      //   hintText: "Ex. London",
                      // ),
                      addVerticalSpacing(16),
                      // MultiTriggerAutocomplete(
                      //   optionsAlignment: OptionsAlignment.topStart,
                      //   autocompleteTriggers: [
                      //     // Add the triggers you want to use for autocomplete
                      //     AutocompleteTrigger(
                      //       trigger: '@',
                      //       optionsViewBuilder:
                      //           (context, autocompleteQuery, controller) {
                      //         return ColoredBox(color: Colors.blue);
                      //         // return MentionAutocompleteOptions(
                      //         //   query: autocompleteQuery.query,
                      //         //   onMentionUserTap: (user) {
                      //         //     final autocomplete =
                      //         //         MultiTriggerAutocomplete.of(context);
                      //         //     return autocomplete
                      //         //         .acceptAutocompleteOption(user.id);
                      //         //   },
                      //         // );
                      //       },
                      //     ),
                      //     AutocompleteTrigger(
                      //       trigger: '#',
                      //       optionsViewBuilder:
                      //           (context, autocompleteQuery, controller) {
                      //         return ColoredBox(color: Colors.pink);
                      //         // return HashtagAutocompleteOptions(
                      //         //   query: autocompleteQuery.query,
                      //         //   onHashtagTap: (hashtag) {
                      //         //     final autocomplete =
                      //         //         MultiTriggerAutocomplete.of(context);
                      //         //     return autocomplete
                      //         //         .acceptAutocompleteOption(hashtag.name);
                      //         //   },
                      //         // );
                      //       },
                      //     ),
                      //   ],
                      //   // Add the text field widget you want to use for autocomplete
                      //   fieldViewBuilder: (context, controller, focusNode) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: VWidgetsDescriptionTextFieldWithTitle(
                      //         label: "Add Caption",
                      //         hintText: "Start typing...",
                      //         controller: _caption,
                      //         inputFormatters: [
                      //           MaxHashtagsFormatter(),
                      //         ],
                      //         onChanged: (val) {
                      //           ref
                      //               .read(discardProvider.notifier)
                      //               .updateState('caption', newValue: val);
                      //         },
                      //       ),

                      //       // ChatMessageTextField(
                      //       //   focusNode: focusNode,
                      //       //   controller: controller,
                      //       // ),
                      //     );
                      //   },
                      // ),
                      // VWidgetsDescriptionTextFieldWithTitle(
                      //   label: "Add Caption",
                      //   hintText: "Start typing...",
                      //   controller: _caption,
                      //   inputFormatters: [
                      //     MaxHashtagsFormatter(),
                      //   ],
                      //   onChanged: (val) {
                      //     ref
                      //         .read(discardProvider.notifier)
                      //         .updateState('caption', newValue: val);
                      //   },
                      // ),
                      VMentionableDescriptionField(
                        label: "Add Caption",
                        hintText: "Start typing...",
                        maxLines: 10,
                        controller: _caption,
                        inputFormatters: [
                          MaxHashtagsFormatter(),
                        ],
                        onChanged: (val) {
                          ref
                              .read(discardProvider.notifier)
                              .updateState('caption', newValue: val);
                        },
                      ),
                      // addVerticalSpacing(15),
                      // VWidgetsCupertinoSwitchWithText(
                      //   titleText: "Allow comments",
                      //   value: alertComment,
                      //   onChanged: ((p0) {
                      //     setState(() {
                      //       alertComment = !alertComment;
                      //     });
                      //   }),
                      // ),
                      addVerticalSpacing(20),
                      VWidgetsPrimaryButton(
                        buttonTitle: "Share",
                        enableButton: selectedAlbum != null,
                        onPressed: () async {
                          // VLoader.changeLoadingState(true);

                          // List imageBytesList = [];
                          // String filename = '';
                          // String content = '';

                          // for (File image in widget.images) {
                          //   List<int> imageBytes = image.readAsBytesSync();
                          //   String base64Image = base64Encode(imageBytes);
                          //   imageBytesList.add(base64Image);
                          // }
                          //
                          // for (final image in imageBytesList) {
                          //   setState(() {
                          //     content = image;
                          //   });
                          // }

                          if (selectedAlbum != null) {
                            // final selectedFiles = (widget.images).cast<File>();
                            final taggedUsers =
                                featured.map((e) => e.username).toList();
                            // await ref
                            ref
                                .read(createPostProvider(null).notifier)
                                .createPost(
                                  albumId: selectedAlbum!.id,
                                  aspectRatio: widget.aspectRatio,
                                  // images: selectedFiles,
                                  rawBytes: widget.images.isNotEmpty
                                      ? widget.images
                                      : images,
                                  caption: _caption.text.trim(),
                                  location: _selectedLocation,
                                  tagged: taggedUsers,
                                  serviceId: selectedService?.id,
                                );
                            if (context.mounted) {
                              navigateAndRemoveUntilRoute(
                                  context, const DashBoardView());
                            }
                          } else {
                            VWidgetShowResponse.showToast(ResponseEnum.failed,
                                message: "Please select gallery");
                          }

                          // VLoader.changeLoadingState(false);
                          // Navigator.pop(context);
                        },
                        // enableButton: uploadPercentage >= 0.0 ? false : true,
                      ),
                      addVerticalSpacing(50),
                    ],
                  ),
                ),
              );
            },
            error: (error, trace) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () {
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          )),
    );
  }

  Widget _addMore() {
    return Container(
      height: 142,
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade300,
      ),
      child: TextButton(
        onPressed: () async {
          goBack(context);
          return

              // SchedulerBinding.instance.addPostFrameCallback((_) {
              //   _scrollController.animateTo(
              //     _scrollController.position.maxScrollExtent,
              //     duration: const Duration(milliseconds: 100),
              //     curve: Curves.ease,
              //   );
              // });
              // _scrollController.animateTo(_scrollController.position.maxScrollExtent,
              //     duration: Duration(milliseconds: 500),
              //     curve: Curves.fastOutSlowIn);

              setState(() {});
        },
        style: TextButton.styleFrom(
          backgroundColor: VmodelColors.vModelprimarySwatch.withOpacity(0.3),
          // foregroundColor: Colors.red,
          // surfaceTintColor: Colors.indigoAccent,
          shape: const CircleBorder(),
          maximumSize: const Size(64, 36),
        ),
        child: Icon(Icons.add, color: VmodelColors.white),
      ),
    );
  }
}
