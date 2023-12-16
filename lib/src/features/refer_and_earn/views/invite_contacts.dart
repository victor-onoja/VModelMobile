import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/refer_and_earn/views/invite_contact.dart';
import 'package:vmodel/src/features/refer_and_earn/widgets/action_button.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/shimmer/shimmerItem.dart';

import '../../../core/utils/shared.dart';

class ReferAndEarnInviteContactsPage extends StatefulWidget {
  const ReferAndEarnInviteContactsPage({super.key});

  @override
  State<ReferAndEarnInviteContactsPage> createState() =>
      _ReferAndEarnInviteContactsPageState();
}

class _ReferAndEarnInviteContactsPageState
    extends State<ReferAndEarnInviteContactsPage> {
  bool showRecentSearches = false;
  bool _isLoading = true;
  bool _showPermissionDenied = false;
  final _isInvited = ValueNotifier(false);
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  List<Map<String, dynamic>> _contactsMap = [];

  FocusNode myFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _getContacts();
    checkPermissionStatus();
    // Permission.contacts.request();
  }

  Future<bool> checkPermissionStatus() async {
    PermissionStatus status = await Permission.contacts.status;
    // await _getContacts();
    if (status.isGranted) {
      print("Permission isGranted.");
      await _getContacts();
      return true;
    } else {
      await Permission.contacts.request();

      _getContacts();

      return false;
    }
  }

  Future<void> _getContacts() async {
    setState(() => _isLoading = true);
    List<Contact> contacts = await ContactsService.getContacts();

    for (Contact contact in contacts) {
      _contactsMap.add({"contact": contact, "isInvited": false});
    }

    _contacts = _contactsMap;
    _filteredContacts = _contactsMap;
    _isLoading = false;
    print(contacts.length);
    setState(() {});
  }

  void _searchContacts(String query) {
    setState(() {
      _filteredContacts = _contactsMap.where((contact) {
        return contact['contact']
                .displayName
                ?.toLowerCase()
                .contains(query.toLowerCase()) ??
            false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(),
          appbarTitle: "Invite contacts",
        ),
        body: _showPermissionDenied
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                    ),
                    addVerticalSpacing(20),
                    Text(
                      "Go to your setting and allow access to contact for VModel",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              )
            : SafeArea(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  SearchTextFieldWidget(
                    hintText: "Search...",
                    controller: _searchController,
                    onChanged: _searchContacts,
                    //     onPressed: () {
                    //       searchController.clear();
                    //     },
                    //     icon: const RenderSvg(
                    //       svgPath: VIcons.roundedCloseIcon,
                    //       svgHeight: 20,
                    //       svgWidth: 20,
                    //     )), // suffixIcon: IconButton(
                  ),
                  Expanded(
                    child: !_isLoading
                        ? _filteredContacts.isNotEmpty
                            ? ListView.separated(
                                itemCount: _filteredContacts.length,
                                separatorBuilder: (context, index) => Divider(
                                      color: Theme.of(context).dividerColor,
                                      height: 1,
                                    ),
                                itemBuilder: (context, index) {
                                  Map<String, dynamic>? contact =
                                      _filteredContacts[index];
                                  List<Item>? phones = _contacts[index]
                                          ['contact']
                                      .phones!
                                      .toList();
                                  String phoneNumbers = phones!.isNotEmpty
                                      ? phones[0].value ?? ""
                                      : "";

                                  return ListTile(
                                    onTap: () {
                                      navigateToRoute(
                                          context,
                                          ReferAndEarnInviteContactPage(
                                              contact: contact['contact']));
                                    },
                                    title: Text(
                                        contact['contact'].displayName ??
                                            phoneNumbers,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    trailing: ReferAndEarnActionButton(
                                        title: contact['isInvited']
                                            ? 'Invited'
                                            : 'Invite',
                                        onPressed: () {
                                          HapticFeedback.lightImpact();
                                          for (int x = 0;
                                              x < _contacts.length;
                                              x++) {
                                            if (x == index) {
                                              _contacts[index]['isInvited'] =
                                                  !_contacts[index]
                                                      ['isInvited'];
                                              setState(() {});
                                            }
                                          }
                                          // navigateToRoute(
                                          //     context,
                                          //     ReferAndEarnInviteContactPage(
                                          //         contact: contact[
                                          //             'contact']));
                                        }),
                                  );
                                })
                            : Center(
                                child: Text("No contact found",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              )
                        : shimmerItem(numOfItem: 10, context: context),
                  )
                ]),
              )));
  }
}
