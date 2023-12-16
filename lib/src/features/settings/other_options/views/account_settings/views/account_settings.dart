import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/settings/other_options/controller/account_settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import '../../../controller/settings_controller.dart';
import 'account_settings_sub_base.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  _buildRedirectingListTile(
    BuildContext context,
    String title,
    String subtitle,
    Widget nextScreen,
  ) {
    return InkWell(
      onTap: () {
        navigateToRoute(context, nextScreen);
      },
      child: ListTile(
        title: Text(
          title,
          style: VModelTypography1.sheetCenterCTA
              .copyWith(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
        subtitle: Text(
          subtitle,
          style: VModelTypography1.sheetCenterCTA.copyWith(
              letterSpacing: 1, fontSize: 14, color: const Color(0xff696464)),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(VSettingsController());

    List<Widget> menuItems = [
      _buildRedirectingListTile(
        context,
        'Full Name',
        'John Doe',
        const AccountBase(
          currentPage: 'name',
        ),
      ),
      _buildRedirectingListTile(
         context,
        'Email',
        'john@vmodel.app',
        const AccountBase(
          currentPage: 'email',
        ),
      ),
      _buildRedirectingListTile(
         context,
        'Location (Country)',
        'London',
        const AccountBase(
          currentPage: 'location',
        ),
      ),

      _buildRedirectingListTile(
         context,
        'Phone',
        '+44 123 456 789',
        const AccountBase(
          currentPage: 'phone',
        ),
      ),

    ];
    Get.put(AccountSettignsController());
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.grey[200]!)),
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: VmodelColors.background,
          leading: const VWidgetsBackButton(),
          title: Text(
            'Settings',
            style: VModelTypography1.pageTitleTextStyle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          )),
      backgroundColor: VmodelColors.background,
      body: Container(
        color: const Color.fromARGB(120, 0, 0, 0),
      ),
      bottomSheet: SizedBox(
        height: SizeConfig.screenHeight - 200,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 3,
          color: VmodelColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return menuItems[index];
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        indent: 15,
                        endIndent: 15,
                        height: 1,
                        thickness: 1,
                        color: Color(0xffDEDEDE),
                      );
                    },
                    itemCount: menuItems.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
