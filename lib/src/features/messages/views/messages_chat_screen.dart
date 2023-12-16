import 'dart:convert';
import 'dart:core';

import 'package:dart_emoji/dart_emoji.dart';
import 'package:either_option/either_option.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/messages/widgets/message_menu_options.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/views/create_offer_page.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/response_widgets/toast_dialogue.dart';
import 'package:web_socket_channel/io.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/messages/controller/messages_controller.dart';
import 'package:vmodel/src/features/messages/views/create_offer.dart';
import 'package:vmodel/src/features/messages/widgets/message_chat_screen_bottom_navigationbar.dart';
import 'package:vmodel/src/features/messages/widgets/receiver_text_message_card.dart';
import 'package:vmodel/src/features/messages/widgets/sender_text_message_card.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar_title_text.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../firebase_options.dart';
import '../../../core/network/urls.dart';
import '../../../core/utils/costants.dart';
import '../../push_notifications/service/firebase_api.dart';

class MessagesChatScreen extends ConsumerStatefulWidget {
  final int id;
  final String? profilePicture;
  final String? profileThumbnailUrl;
  final String username;
  final String? label;

  const MessagesChatScreen(
      {super.key,
      required this.id,
      this.profilePicture,
      this.profileThumbnailUrl,
      required this.username,
      this.label});

  @override
  ConsumerState<MessagesChatScreen> createState() => _MessagesChatScreenState();
}

class _MessagesChatScreenState extends ConsumerState<MessagesChatScreen> {
  TextEditingController message = TextEditingController();
  bool isTyping = false;
  bool showSend = false;
  bool showCopy = false;
  String textToCopy = "";

  List text = [];
  List textSelect = [];

  void detectUserIsTyping(String value) {
    setState(() {
      if (value.isNotEmpty) {
        isTyping = true;
      } else {
        isTyping = false;
      }
    });
  }

  static final VModelSecureStorage stroage = VModelSecureStorage();
  String? token = '';

  Future<dynamic> getRestToken() async {
    return stroage.getSecuredKeyStoreData(VSecureKeys.restTokenKey);
  }

  Future<dynamic> initFirebaseToken() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseApi().initNotification();
  }

  Future<dynamic> getToken() async {
    final restT = await getRestToken() as String?;
    setState(() {
      token = restT;
    });

    return restT;
  }

  @override
  void initState() {
    super.initState();
    print("user id ${widget.id}");
    getRestToken();
    getToken();
    // initFirebaseToken();
  }

  String selectedChip = "Model";
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final previousMessages = ref.watch(getConversation(widget.id));
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;
    // final wsUrl =
    //     Uri.parse('wss://vmodel-app.herokuapp.com/ws/chat/${widget.id}/');
    final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/${widget.id}/');
    // final wsUrl = Uri.parse('wss://uat-api.vmodel.app/ws/chat/${widget.id}/');

    // final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/${widget.id}/');
    WebSocketChannel channel = IOWebSocketChannel.connect(wsUrl,
        headers: {"authorization": "Token ${token.toString().trim()}"});
    return WillPopScope(
      onWillPop: () async {
        if (showCopy) {
          setState(() => showCopy = false);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: VWidgetsBackButton(onTap: () {
            if (showCopy) {
              setState(() => showCopy = false);
              return;
            } else {
              text.clear();
              Navigator.pop(context);
            }
          }),
          centerTitle: false,
          title: GestureDetector(
            onTap: () => navigateToRoute(
                context, OtherUserProfile(username: widget.username)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilePicture(
                  url: widget.profilePicture,
                  headshotThumbnail: widget.profileThumbnailUrl,
                  size: 44,
                  showBorder: true,
                ),
                addHorizontalSpacing(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VWidgetsAppBarTitleText(titleText: widget.username),
                    Text(
                      widget.label ?? "",
                      style: VModelTypography1.normalTextStyle.copyWith(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            if (showCopy)
              IconButton(
                  onPressed: () {
                    copyText();
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Theme.of(context).iconTheme.color,
                  )),
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          child: MessageMenuOptionsWidget(
                              conversationId: widget.id,
                              username: widget.username,
                              connectionStatus: user!.connectionStatus!),
                        );
                      });
                },
                icon: const RenderSvg(svgPath: VIcons.exclamation)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: previousMessages.when(
                    data: (Either<CustomException, List<dynamic>> data) {
                      text.clear();
                      return data.fold((p0) => const SizedBox.shrink(), (p0) {
                        text.addAll(p0.reversed);

                        for (int i = 0; i < p0.length; i++) {
                          textSelect.add(false);
                        }

                        return StreamBuilder(
                          stream: channel.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print(token);
                              var data = jsonDecode(snapshot.data);
                              List value = [data];

                              text.addAll(value);
                              return
                                  // VWidgetsReceiverTextCard(
                                  //     receiverMessage: '${snapshot.data}');
                                  GestureDetector(
                                      onTap: () {
                                        dismissKeyboard();
                                      },
                                      child: Padding(
                                        padding: const VWidgetsPagePadding
                                            .horizontalSymmetric(10),
                                        child: ListView.builder(
                                          reverse: true,
                                          itemCount: text.length,
                                          controller: controller,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final String senderText =
                                                text[text.length - 1 - index]
                                                    ['text'];
                                            final String receiverText =
                                                text[text.length - 1 - index]
                                                    ['text'];
                                            print(snapshot.data);
                                            if (text[text.length - 1 - index]
                                                    ['senderName'] ==
                                                currentUser?.username) {
                                              return GestureDetector(
                                                onLongPress: () {
                                                  onLongtap(
                                                      receiverText, index);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: hilight(index)
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primary
                                                            .withOpacity(.1)
                                                        : Colors.transparent,
                                                  ),
                                                  child: VWidgetsReceiverTextCard(
                                                      receiverMessage:
                                                          receiverText,
                                                      fontSize:
                                                          _emojiOnlyTextFontSize(
                                                              receiverText)),
                                                ),
                                              );
                                            }
                                            return GestureDetector(
                                              onLongPress: () {
                                                onLongtap(senderText, index);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: hilight(index)
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(.1)
                                                      : Colors.transparent,
                                                ),
                                                child: VWidgetsSenderTextCard(
                                                  onSenderImageTap: () {
                                                    navigateToRoute(
                                                        context,
                                                        OtherUserProfile(
                                                            username: widget
                                                                .username));
                                                  },
                                                  senderMessage: senderText,
                                                  senderImage: text[text
                                                          .length -
                                                      1 -
                                                      index]['receiverProfile'],
                                                  checkStatus: false,
                                                  fontSize:
                                                      _emojiOnlyTextFontSize(
                                                          senderText),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ));
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return GestureDetector(
                                onTap: () {
                                  dismissKeyboard();
                                },
                                child: Padding(
                                  padding: const VWidgetsPagePadding
                                      .horizontalSymmetric(10),
                                  child: ListView.builder(
                                    reverse: true,
                                    itemCount: text.length,
                                    controller: controller,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(text.length);
                                      final String senderText =
                                          text[text.length - 1 - index]['text'];
                                      final String receiverText =
                                          text[text.length - 1 - index]['text'];
                                      if (text[text.length - 1 - index]
                                              ['senderName'] ==
                                          currentUser?.username) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            onLongtap(receiverText, index);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: hilight(index)
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(.1)
                                                  : Colors.transparent,
                                            ),
                                            child: VWidgetsReceiverTextCard(
                                              receiverMessage: receiverText,
                                              fontSize: _emojiOnlyTextFontSize(
                                                  receiverText),
                                            ),
                                          ),
                                        );
                                      }
                                      return GestureDetector(
                                        onLongPress: () {
                                          print("object");

                                          onLongtap(senderText, index);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: hilight(index)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(.1)
                                                : Colors.transparent,
                                          ),
                                          child: Container(
                                            color: hilight(index)
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .withOpacity(.1)
                                                : Colors.transparent,
                                            child: VWidgetsSenderTextCard(
                                              onSenderImageTap: () {
                                                navigateToRoute(
                                                    context,
                                                    OtherUserProfile(
                                                        username:
                                                            widget.username));
                                              },
                                              senderMessage: senderText,
                                              senderImage:
                                                  text[text.length - 1 - index]
                                                      ['receiverProfile'],
                                              checkStatus: false,
                                              fontSize: _emojiOnlyTextFontSize(
                                                  senderText),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ));
                          },
                        );
                      });
                    },
                    error: (Object error, StackTrace stackTrace) =>
                        const SizedBox.shrink(),
                    loading: () => const SizedBox.shrink())),
            addVerticalSpacing(12),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    // height: 65,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding:
                          const VWidgetsPagePadding.horizontalSymmetric(16),
                      child: SizedBox(
                        height: 80,
                        child: VWidgetsTextFieldWithMultipleIcons(
                          textCapitalization: TextCapitalization.sentences,
                          isTyping: isTyping,
                          controller: message,
                          suffixIcon: Padding(
                            padding:
                                EdgeInsets.only(right: 0, top: 8, bottom: 8),
                            child: RenderSvg(
                              svgPath: VIcons.smilyImojie,
                              svgHeight: 10,
                              svgWidth: 0,
                            ),
                          ),
                          showSend: showSend,
                          onTapPlus: () => showOptionModalSheet(),
                          onSend: () {
                            sendMessage();
                            message.clear();
                            showSend = false;
                            setState(() {});
                          },
                          onChanged: (value) {
                            if (value!.isNotEmpty) {
                              showSend = true;
                              setState(() {});
                            } else {
                              showSend = false;
                              setState(() {});
                            }
                          },
                          hintText: 'Message...',
                          onPressedSuffixFirst: () {},
                          onPressedSuffixSecond: () {},
                          onPressedSuffixThird: () {
                            // navigateToRoute(context, const BookingSettings());
                            // showCupertinoModalPopup(
                            //   context: context,
                            //   builder: (BuildContext context) => Container(
                            //     margin: const EdgeInsets.only(
                            //       bottom: 10,
                            //     ),
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         ...createBookingOptions(context).map((e) {
                            //           return Container(
                            //             decoration: BoxDecoration(
                            //               color: VmodelColors.white,
                            //               borderRadius: const BorderRadius.all(
                            //                 Radius.circular(10),
                            //               ),
                            //             ),
                            //             width: double.infinity,
                            //             margin: const EdgeInsets.only(
                            //                 left: 12, right: 12, bottom: 4),
                            //             height: 50,
                            //             child: MaterialButton(
                            //               shape: const RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.all(
                            //                   Radius.circular(10),
                            //                 ),
                            //               ),
                            //               onPressed: () {
                            //                 showModalBottomSheet(
                            //                   isScrollControlled: true,
                            //                   isDismissible: false,
                            //                   backgroundColor: Colors.white,
                            //                   context: context,
                            //                   builder: (context) =>
                            //                       DraggableScrollableSheet(
                            //                     expand: false,
                            //                     key: UniqueKey(),
                            //                     initialChildSize: 0.9,
                            //                     maxChildSize: 0.9,
                            //                     minChildSize: .5,
                            //                     builder: (context, controller) =>
                            //                         const CreateOffer(),
                            //                   ),
                            //                 );
                            //               },
                            //               child: GestureDetector(
                            //                 onTap: () {
                            //                   popSheet(context);
                            //                 },
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.center,
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.center,
                            //                   children: [
                            //                     Text(
                            //                       e.label.toString(),
                            //                       style: e.label == 'Cancel'
                            //                           ? Theme.of(context)
                            //                               .textTheme
                            //                               .displayMedium!
                            //                               .copyWith(
                            //                                   color: Colors.blue)
                            //                           : Theme.of(context)
                            //                               .textTheme
                            //                               .displayMedium,
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         }),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ),
                  ),
                  addVerticalSpacing(3),
                ],
              ),
            ),
            addVerticalSpacing(3),
          ],
        ),
      ),
    );
  }

  void sendMessage() async {
    print("object hey");
    // final wsUrl =
    //     Uri.parse('wss://vmodel-app.herokuapp.com/ws/chat/${widget.id}/');
    final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/${widget.id}/');
    // final wsUrl = Uri.parse('wss://uat-api.vmodel.app/ws/chat/${widget.id}/');
    WebSocketChannel channel = IOWebSocketChannel.connect(wsUrl,
        headers: {"authorization": "Token ${token.toString().trim()}"});
    if (message.text.isNotEmpty) {
      var text = jsonEncode(<String, String>{"message": message.text});
      channel.sink.add(text);
    }
  }

  @override
  void dispose() {
    final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/${widget.id}/');
    WebSocketChannel channel = IOWebSocketChannel.connect(wsUrl,
        headers: {"authorization": "Token ${token.toString().trim()}"});
    channel.sink.close();
    ref.invalidate(getConversations);
    super.dispose();
  }

  double _emojiOnlyTextFontSize(String? text) {
    if (!EmojiUtil.hasOnlyEmojis(text ?? '')) {
      return VConstants.normalChatMessageSize;
    }
    //Todo emojis are typically composed of 2 characters. Thus one emoji will
    // have a length of 2.
    switch (text!.length) {
      case 2: //one emoji only
        return VConstants.emojiOnlyMessageHugeSize;
      case 4: //two emojis only
        return VConstants.emojiOnlyMessageBigSize;
      case 6: //three emojis only
        return VConstants.emojiOnlyMessageMediumSize;
      default:
        return VConstants.normalChatMessageSize;
    }
  }

  void onLongtap(String senderText, int index) {
    textToCopy = senderText;
    textSelect[index] = true;
    showCopy = true;
    setState(() {});
  }

  bool hilight(int index) {
    bool? val;

    for (int i = 0; i < textSelect.length; i++) {
      if (i == index) {
        val = textSelect[i];
      }
    }
    return val!;
  }

  void copyText() {
    for (int i = 0; i < textSelect.length; i++) {
      textSelect[i] = false;
    }
    copyTextToClipboard(textToCopy);
    toastDialoge(text: "Message copied", context: context);

    setState(() => showCopy = false);
  }

  showOptionModalSheet() {
    showModalBottomSheet(
      // isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      context: context,
      builder: (context) {
        return Container(
          height: 110,
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              addVerticalSpacing(10),
              VWidgetsBottomSheetTile(
                onTap: () async {
                  Navigator.of(context)..pop();
                  showCreateOfferModalSheet();
                },
                message: "Create an offer",
              ),
              const Divider(thickness: 0.5, height: 10),
            ],
          ),
        );
      },
    );
  }

  void showCreateOfferModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      context: context,
      builder: (context) {
        return Container(
            height: SizerUtil.height * .93,
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: CreateOfferPage(
              onCreatOffer: (map) {},
            ));
      },
    );
  }

  void sendOffer(Map<String, dynamic> data) async {
    final wsUrl = Uri.parse('${VUrls.webSocketBaseUrl}/chat/${widget.id}/');
    // final wsUrl = Uri.parse('wss://uat-api.vmodel.app/ws/chat/${widget.id}/');
    WebSocketChannel channel = IOWebSocketChannel.connect(wsUrl,
        headers: {"authorization": "Token ${token.toString().trim()}"});
    if (message.text.isNotEmpty) {
      var map = jsonEncode(<String, dynamic>{
        "message": jsonEncode(data),
        "is_item": true,
        "item_id": data['id'].toString(),
        "item_type": "OFFER"
      });
      channel.sink.add(map);
    }
  }
}

List<UploadOptions> createBookingOptions(BuildContext context) {
  return [
    UploadOptions(label: "Create an offer", onTap: () {}),
    UploadOptions(
        label: "Cancel",
        onTap: () {
          popSheet(context);
        }),
  ];
}

void _modalBuilder(BuildContext context) {
  showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  'Create an Offer',
                  style: Theme.of(context).textTheme.displayMedium,
                  // .copyWith(color: VmodelColors.primaryColor),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => DraggableScrollableSheet(
                      expand: false,
                      key: UniqueKey(),
                      initialChildSize: 0.9,
                      maxChildSize: 0.9,
                      minChildSize: .5,
                      builder: (context, controller) => const CreateOffer(),
                    ),
                  );
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.displayMedium,
                // .copyWith(color: VmodelColors.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ));
}
