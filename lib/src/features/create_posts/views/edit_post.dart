import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/gallery_controller.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/controller/discard_editing_controller.dart';
import '../../../core/models/app_user.dart';
import '../../../core/utils/extensions/custom_text_input_formatters.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../res/res.dart';
import '../../../shared/appbar/appbar.dart';
import '../../../shared/text_fields/places_autocomplete_field.dart';
import '../../dashboard/discover/controllers/discover_controller.dart';
import '../../dashboard/feed/controller/new_feed_provider.dart';
import '../controller/create_post_controller.dart';
import 'chip_input_field.dart';
import 'mentionable_field.dart';

class EditPostPage extends ConsumerStatefulWidget {
  const EditPostPage({
    super.key,
    required this.postId,
    required this.images,
    this.caption,
    this.locationName,
    this.featuredUsers = const [],
  });
  final int postId;
  final List images;
  final String? caption;
  final String? locationName;
  final List<VAppUser> featuredUsers;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditPostPageState();
}

class _EditPostPageState extends ConsumerState<EditPostPage> {
  final formKey = GlobalKey<FormState>();

  final captionController = TextEditingController();
  // final locationController = TextEditingController();
  final isLoading = ValueNotifier(false);
  String? _selectedLocation = null;
  int maxNumberOfMentions = 5;
  final List<VAppUser> featured = [];

  @override
  void initState() {
    super.initState();

    if (widget.caption != null) {
      captionController.text = widget.caption!;
    }
    featured.addAll(widget.featuredUsers);
    // if (widget.locationName != null) {
    //   locationController.text = widget.locationName!;
    // }
    initDiscardProvider();
  }

  initDiscardProvider() {
    ref.read(discardProvider.notifier).initialState('caption',
        initial: captionController.text, current: captionController.text);
    ref.read(discardProvider.notifier).initialState('location',
        initial: _selectedLocation, current: _selectedLocation);
    ref
        .read(discardProvider.notifier)
        .initialState('featured', initial: featured, current: featured);
  }

  @override
  void dispose() {
    // if (mounted) {
    //   ref.invalidate(discardProvider);
    // }
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    //ref.read(feedProvider.notifier).
    ref.watch(discardProvider);
    final searchList = ref.watch(searchUsersProvider);

    return WillPopScope(
      onWillPop: () async {
        return onPopPage(context, ref);
      },
      child: Portal(
        child: Scaffold(
            persistentFooterButtons: [
              ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: ((context, value, child) {
                    return VWidgetsPrimaryButton(
                        buttonTitle: 'Update post',
                        showLoadingIndicator: value,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading.value = true;
                            await ref
                                .read(createPostProvider(null).notifier)
                                .editPost(
                                  postId: widget.postId,
                                  caption: captionController.text.trim(),
                                  // locationName: locationController.text.trim(),
                                  locationName: _selectedLocation,
                                  taggedUsers:
                                      featured.map((e) => e.username).toList(),
                                );
                            ref.invalidate(mainFeedProvider);
                            ref.refresh(galleryProvider(null));
                            if (context.mounted) {
                              goBack(context);
                            }
                            isLoading.value = false;
                          }
                        });
                  }))
            ],
            appBar: VWidgetsAppBar(
              appbarTitle: 'Edit post',
              leadingIcon: VWidgetsBackButton(
                onTap: () {
                  onPopPage(context, ref);
                },
              ),
            ),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                        height: 150,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: widget.images
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: e.url,
                                        colorBlendMode: BlendMode.color,
                                        color: Colors.grey,
                                        placeholderFadeInDuration:
                                            Duration.zero,
                                        fadeInDuration: Duration.zero,
                                        fadeOutDuration: Duration.zero,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )),
                    addVerticalSpacing(5),
                    Text('images cant be edited',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: VmodelColors.darkGreyColor)),
                    addVerticalSpacing(15),
                    Row(
                      children: [
                        Text("Features",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    // color: VmodelColors.primaryColor,
                                    fontWeight: FontWeight.w600)),
                      ],
                    ),
                    addVerticalSpacing(4),
                    VWidgetChipsField(
                      maxNumberOfChips: maxNumberOfMentions,
                      initialValue: featured,
                      onChanged: (data) {
                        featured.clear();
                        featured.addAll(data);
                      },
                      suggestions: (query) async {
                        if (query.isEmpty &&
                            featured.length > maxNumberOfMentions) {
                          // return searchList.valueOrNull ?? [];
                          return [];
                        }
                        return await ref
                            .read(discoverProvider.notifier)
                            .searchUsers(query);
                      },
                    ),
                    // VWidgetsTextFieldNormal(
                    //   labelText: 'Features',
                    //   validator: (value) => null,
                    // ),
                    addVerticalSpacing(15),
                    PlacesAutocompletionField(
                      // locController: locController,
                      initialValue: widget.locationName,
                      label: "Location",
                      hintText: "Search location",
                      onItemSelected: (value) {
                        if (!mounted) return;
                        // WidgetsBinding.instance
                        // .addPostFrameCallback((timeStamp) {
                        // setState(() {
                        _selectedLocation = value;
                        ref
                            .read(discardProvider.notifier)
                            .updateState('location', newValue: value);
                        // _isShowAddressPredictions = false;
                        // });
                        // });
                      },
                      postOnChanged: (String value) {
                        ref
                            .read(discardProvider.notifier)
                            .updateState('location', newValue: value);
                        if (!mounted) return;
                        //
                        // if (value == null || value.isEmpty) {
                        // setState(() {
                        // _isShowAddressPredictions = false;
                        // });
                        // }
                        //  else {
                        //   setState(() {
                        //     _isShowAddressPredictions = true;
                        //   });
                        // }
                      },
                    ),
                    // VWidgetsTextFieldNormal(
                    //   labelText: 'Location',
                    //   hintText: 'Ex. London',
                    //   validator: (value) => null,
                    //   controller: locationController,
                    // ),
                    addVerticalSpacing(15),
                    // VWidgetsDescriptionTextFieldWithTitle(
                    //   label: 'Add caption',
                    //   hintText: 'Start typing...',
                    //   controller: captionController,
                    //   maxLines: 10,
                    //   inputFormatters: [MaxHashtagsFormatter()],
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
                      controller: captionController,
                      inputFormatters: [
                        MaxHashtagsFormatter(),
                      ],
                      onChanged: (val) {
                        ref
                            .read(discardProvider.notifier)
                            .updateState('caption', newValue: val);
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
