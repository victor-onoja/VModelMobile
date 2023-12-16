import 'package:vmodel/src/features/settings/views/account_settings/views/account_settings_email_page.dart';
import 'package:vmodel/src/features/settings/views/account_settings/views/account_settings_location_page.dart';
import 'package:vmodel/src/features/settings/views/account_settings/views/account_settings_name_page.dart';
import 'package:vmodel/src/features/settings/views/account_settings/views/account_settings_phone_page.dart';
import 'package:vmodel/src/features/settings/views/account_settings/widgets/account_settings_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class PersonalSettingsPage extends StatelessWidget {
   const PersonalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Personal Information", 
      ),
      body: SingleChildScrollView(
      padding:  const VWidgetsPagePadding.horizontalSymmetric(18),
      child: Column(

        children: [
         addVerticalSpacing(15),
        VWidgetsAccountSettingsCard(
          title: "Full Name",
          subtitle: "John Doe",
          onTap: () {
            navigateToRoute(context,  const AccountSettingsNamePage());
          },
        ),
         VWidgetsAccountSettingsCard(
          title: "Email",
          subtitle: "john@vmodel.app",
          onTap: () {
            navigateToRoute(context,  const AccountSettingsEmailPage());
          },
        ),

         VWidgetsAccountSettingsCard(
          title: "Location (City)",
          subtitle: "London",
          onTap: () {
            navigateToRoute(context,  const AccountSettingsLocationPage());
          },
        ),

         VWidgetsAccountSettingsCard(
          title: "Phone",
          subtitle: "+44 123 456 789",
          onTap: () {
            navigateToRoute(context,  const AccountSettingsPhonePage());
          },
        ),

        VWidgetsAccountSettingsCard(
          title: "Date of Birth",
          subtitle: "01/01/2000",
          onTap: () {

          },
        ),
      ]),
    ),
    );
  }
}
