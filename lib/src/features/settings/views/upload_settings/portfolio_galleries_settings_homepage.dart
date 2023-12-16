import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/features/settings/views/upload_settings/gallery_functions_widget.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/enum/album_type.dart';
import '../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../../shared/bottom_sheets/input_bottom_sheet.dart';
import '../../../../shared/bottom_sheets/tile.dart';
import '../../../create_posts/widgets/dialog_create_gallery.dart';
import '../../../dashboard/new_profile/controller/gallery_controller.dart';

class PortfolioGalleriesSettingsHomepage extends ConsumerStatefulWidget {
  const PortfolioGalleriesSettingsHomepage(
      {super.key, required this.title, required this.galleryType});
  final String title;
  final AlbumType galleryType;

  @override
  ConsumerState<PortfolioGalleriesSettingsHomepage> createState() =>
      _PortfolioGalleriesSettingsHomepageState();
}

class _PortfolioGalleriesSettingsHomepageState
    extends ConsumerState<PortfolioGalleriesSettingsHomepage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final galleries = ref.watch(galleryProvider(null));
    // final albums = ref.watch(albumsProvider(null));
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: widget.galleryType == AlbumType.portfolio
            ? "Portfolio Galleries"
            : "Polaroid Galleries",
        leadingIcon: VWidgetsBackButton(),
        trailingIcon: [
          VWidgetsTextButton(
              text: 'Add',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) => CreateGalleryDialog(
                        isPolaroid: widget.galleryType == AlbumType.polaroid)));
              }),
        ],
      ),
      body: galleries.when(data: (values) {
        final portfolios = values.where((e) {
          return e.galleryType == widget.galleryType;
        }).toList();
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const VWidgetsPagePadding.horizontalSymmetric(16),
                child: Column(
                  children: [
                    if (portfolios.isNotEmpty) ...[
                      addVerticalSpacing(20),
                      ...List.generate(portfolios.length, (index) {
                        return VWidgetsGalleryFunctionsCard(
                          title: portfolios[index].name,
                          onTapEdit: () {
                            _controller.text = '';
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      bottom: VConstants
                                          .bottomPaddingForBottomSheets,
                                    ),
                                    decoration: BoxDecoration(
                                      // color: VmodelColors.white,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(13),
                                      ),
                                    ),
                                    child: VWidgetsInputBottomSheet(
                                      controller: _controller,
                                      title: "${portfolios[index].name}",
                                      hintText: "${portfolios[index].name}",
                                      dialogMessage: "Edit gallery name",
                                      actions: [
                                        VWidgetsBottomSheetTile(
                                          message: "Update",
                                          onTap: () {
                                            final id = int.tryParse(
                                                portfolios[index].id);
                                            if (id == null) {
                                              print(
                                                  'gallery ID to rename is null');
                                              return;
                                            }
                                            goBack(context);
                                            VLoader.changeLoadingState(true);
                                            ref
                                                .read(galleryProvider(null)
                                                    .notifier)
                                                .upadetGalleryName(
                                                    galleryId: id,
                                                    name:
                                                        _controller.text.trim())
                                                .then((value) {
                                              _controller.text = '';
                                              VLoader.changeLoadingState(false);
                                              //  ref.invalidate(galleryProvider(null));
                                            });
                                          },
                                        ),
                                        const Divider(thickness: 0.5),
                                        VWidgetsBottomSheetTile(
                                          message: "Cancel",
                                          onTap: () {
                                            goBack(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                });
                            // showDialog(
                            //     context: context,
                            //     builder: ((context) => VWidgetsAddAlbumPopUp(
                            //           controller: _controller,
                            //           popupTitle: "Edit Gallery Name",
                            //           buttonTitle: "Done",
                            //           onPressed: () async {
                            //             final id =
                            //                 int.tryParse(portfolios[index].id);
                            //             if (id == null) {
                            //               print('gallery ID to rename is null');
                            //               return;
                            //             }
                            //             goBack(context);
                            //             VLoader.changeLoadingState(true);
                            //             ref
                            //                 .read(galleryProvider(null).notifier)
                            //                 .upadetGalleryName(
                            //                     galleryId: id,
                            //                     name: _controller.text.trim())
                            //                 .then((value) {
                            //               _controller.text = '';
                            //               VLoader.changeLoadingState(false);
                            //               //  ref.invalidate(galleryProvider(null));
                            //             });
                            //           },
                            //         )));
                          },
                          onTapDelete: () async {
                            final bool? first =
                                await showModalBottomSheet<bool?>(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      _controller.text = '';
                                      return Container(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: VConstants
                                              .bottomPaddingForBottomSheets,
                                        ),
                                        decoration: BoxDecoration(
                                          // color: VmodelColors.white,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(13),
                                          ),
                                        ),
                                        child: VWidgetsConfirmationBottomSheet(
                                          title: "${portfolios[index].name}",
                                          dialogMessage:
                                              "Are you sure want to delete this gallery?"
                                              " This action cannot be undone!",
                                          actions: [
                                            VWidgetsBottomSheetTile(
                                              message: "Delete",
                                              onTap: () {
                                                Navigator.pop(context, true);
                                              },
                                            ),
                                            const Divider(thickness: 0.5),
                                            VWidgetsBottomSheetTile(
                                              message: "Cancel",
                                              onTap: () {
                                                Navigator.pop(context, false);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });

                            if (first != null && first && context.mounted) {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        bottom: VConstants
                                            .bottomPaddingForBottomSheets,
                                      ),
                                      decoration: BoxDecoration(
                                        // color: VmodelColors.white,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(13),
                                        ),
                                      ),
                                      child: VWidgetsInputBottomSheet(
                                        controller: _controller,
                                        title: "${portfolios[index].name}",
                                        dialogMessage:
                                            "Please enter you password to proceed",
                                        hintText: 'Password',
                                        obscureText: true,
                                        actions: [
                                          VWidgetsBottomSheetTile(
                                            message: "Delete",
                                            onTap: () async {
                                              final id = int.tryParse(
                                                  portfolios[index].id);
                                              if (id == null) {
                                                print(
                                                    'gallery ID to delete is null');
                                                return;
                                              }
                                              goBack(context);
                                              VLoader.changeLoadingState(true);
                                              ref
                                                  .read(galleryProvider(null)
                                                      .notifier)
                                                  .deleteGallery(
                                                      galleryId: id,
                                                      userPassword:
                                                          _controller.text)
                                                  .then((value) {
                                                _controller.text = '';
                                                VLoader.changeLoadingState(
                                                    false);
                                                ref.invalidate(
                                                    galleryProvider(null));
                                              });
                                            },
                                          ),
                                          const Divider(thickness: 0.5),
                                          VWidgetsBottomSheetTile(
                                            message: "Cancel",
                                            onTap: () {
                                              goBack(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }

                            // final bool? first = await showDialog<bool>(
                            //     context: context,
                            //     builder: ((context) => VWidgetsConfirmationPopUp(
                            //         popupTitle: "Delete Gallery",
                            //         firstButtonText: "Delete",
                            //         secondButtonText: "Go Back",
                            //         popupDescription:
                            //             "Are you sure want to delete this Gallery ? This action cannot be undone!",
                            //         onPressedYes: () {
                            //           Navigator.pop(context, true);
                            //           // _controller.text = '';
                            //         },
                            //         onPressedNo: () {
                            //           // _controller.text = '';
                            //           Navigator.pop(context, false);
                            //         })));

                            // if (first != null && first && context.mounted) {
                            //   _controller.text = '';
                            //   showDialog(
                            //       context: context,
                            //       builder: ((context) => VWidgetsAddAlbumPopUp(
                            //             textFieldlabel: "Enter your Password",
                            //             controller: _controller,
                            //             popupTitle: "Delete Gallery",
                            //             buttonTitle: "Delete",
                            //             hintText: "Enter Password",
                            //             obscureText: true,
                            //             onPressed: () async {
                            //               final id =
                            //                   int.tryParse(portfolios[index].id);
                            //               if (id == null) {
                            //                 print('gallery ID to delete is null');
                            //                 return;
                            //               }
                            //               goBack(context);
                            //               VLoader.changeLoadingState(true);
                            //               ref
                            //                   .read(
                            //                       galleryProvider(null).notifier)
                            //                   .deleteGallery(
                            //                       galleryId: id,
                            //                       userPassword: _controller.text)
                            //                   .then((value) {
                            //                 _controller.text = '';
                            //                 VLoader.changeLoadingState(false);
                            //                 ref.invalidate(galleryProvider(null));
                            //               });
                            //             },
                            //           )));
                            // }
                          },
                        );
                      }),
                    ],
                    if (portfolios.isEmpty) ...[
                      addVerticalSpacing(300),
                      Center(child: Text("No Gallery")),
                    ]
                  ],
                ),
              ),
            ),
          ],
        );
      }, error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      }, loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      }),
    );
  }
}
