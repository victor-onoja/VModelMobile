import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_normal.dart';

import '../../../../../vmodel.dart';
import '../controller/user_permission_settings_controller.dart';
import '../../../../../core/models/user_permissions.dart';
import '../../../../../core/utils/enum/permission_enum.dart';

class PermissionsHomepage extends ConsumerStatefulWidget {
  const PermissionsHomepage({super.key, required this.user});
  final VAppUser? user;

  @override
  ConsumerState<PermissionsHomepage> createState() =>
      _PermissionsHomepageState();
}

class _PermissionsHomepageState extends ConsumerState<PermissionsHomepage> {
  bool showLoadingIndicator = false;

  final messageOptions = const [
    PermissionSetting.CONNECTIONS,
    PermissionSetting.NO_ONE
  ];
  final featureOptions = const [
    PermissionSetting.ANYONE,
    PermissionSetting.CONNECTIONS,
    PermissionSetting.NO_ONE
  ];
  final networkOptions = const [
    PermissionSetting.ANYONE,
    PermissionSetting.CONNECTIONS,
    PermissionSetting.NO_ONE
  ];
  final connectOptions = const [
    PermissionSetting.ANYONE,
    PermissionSetting.NO_ONE
  ];

  late UserPermissionsSettings currentSettings;
  @override
  initState() {
    super.initState();
    currentSettings = UserPermissionsSettings.fromMap({
      "whoCanConnectWithMe": '${widget.user?.whoCanConnectWithMe}',
      "whoCanFeatureMe": '${widget.user?.whoCanFeatureMe}',
      "whoCanMessageMe": '${widget.user?.whoCanMessageMe}',
      "whoCanViewMyNetwork": '${widget.user?.whoCanViewMyNetwork}',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Permissions Settings",
        leadingIcon: const VWidgetsBackButton(),
        trailingIcon: [
          VWidgetsTextButton(
            text: 'Save',
            showLoadingIndicator: showLoadingIndicator,
            onPressed: () async {
              setState(() {
                showLoadingIndicator = true;
              });
              await ref
                  .read(userPermissionsProvider(widget.user?.username).notifier)
                  .updateUserPermissionSettings(settings: currentSettings);
              setState(() {
                showLoadingIndicator = false;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            addVerticalSpacing(25),
            VWidgetsDropdownNormal<PermissionSetting>(
              fieldLabel: "Who can message me?",
              // value: selectedMessagePermission,
              value: currentSettings.whoCanMessageMe,
              items: messageOptions,
              validator: (val) => null,
              onChanged: (value) {
                // selectedMessagePermission = value;
                currentSettings =
                    currentSettings.copyWith(whoCanMessageMe: value);
                setState(() {});
              },
              itemToString: (value) => value.simpleName,
            ),
            addVerticalSpacing(3),
            VWidgetsDropdownNormal<PermissionSetting>(
              fieldLabel: "Who can feature me?",
              // value: selectedFeaturePermission,
              value: currentSettings.whoCanFeatureMe,
              items: featureOptions,
              validator: (val) => null,
              itemToString: (value) => value.simpleName,
              onChanged: (value) {
                // selectedFeaturePermission = value;
                currentSettings =
                    currentSettings.copyWith(whoCanFeatureMe: value);
                setState(() {});
              },
            ),
            addVerticalSpacing(3),
            VWidgetsDropdownNormal<PermissionSetting>(
              fieldLabel: "Who can view my network?",
              // value: selectedNetworkPermission,
              value: currentSettings.whoCanViewMyNetwork,
              items: networkOptions,
              validator: (val) => null,
              itemToString: (value) => value.simpleName,
              onChanged: (value) {
                // selectedNetworkPermission = value;
                currentSettings =
                    currentSettings.copyWith(whoCanViewMyNetwork: value);
                setState(() {});
              },
            ),
            addVerticalSpacing(3),
            VWidgetsDropdownNormal<PermissionSetting>(
              fieldLabel: "Who can connect with me?",
              // value: selectedConnectPermission,
              value: currentSettings.whoCanConnectWithMe,
              items: connectOptions,
              validator: (val) => null,
              itemToString: (value) => value.simpleName,
              onChanged: (value) {
                // selectedConnectPermission = value;
                currentSettings =
                    currentSettings.copyWith(whoCanConnectWithMe: value);
                setState(() {});
              },
            ),
            addVerticalSpacing(3)
          ],
        ),
      ),
    );
  }
}
