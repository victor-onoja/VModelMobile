
class HelpSupportModel {
  final String? title;
  final String? body;
  final String? iconPath;
  final Map<int, String>? accountSettings;
  HelpSupportModel(
      {this.title, this.body, this.iconPath, this.accountSettings});

  static List<HelpSupportModel> helpAndSupport() {
    return [
      HelpSupportModel(
        title: "Report a bug",
      ),
      HelpSupportModel(
        title: "Report abuse or spam",
      ),
      HelpSupportModel(
        title: "Report something illegal",
      ),
      // HelpSupportModel(
      //   title: "Size guide",
      // ),
    ];
  }


// static List<HelpSupportModel> popularFAQS() {
  //   return [
  //     HelpSupportModel(
  //       title: "How can I set up my account?",
  //       body:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  //     ),
  //     HelpSupportModel(
  //       title: "Change or reset your password",
  //       body:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  //     ),
  //     HelpSupportModel(
  //       title: "Recover your account if you can’t log in",
  //       body:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  //     ),
  //   ];
  // }
  //
  // static List<HelpSupportModel> faqTopics() {
  //   return [
  //     HelpSupportModel(
  //       title: "Account settings",
  //       iconPath: VIcons.accountHelpIcon,
  //       accountSettings: {
  //         0: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         2: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         3: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //       },
  //       body:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  //     ),
  //     HelpSupportModel(
  //       title: "Login and password",
  //       iconPath: VIcons.loginHelpIcon,
  //       accountSettings: {
  //         0: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         2: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         3: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //       },
  //       body:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  //     ),
  //     HelpSupportModel(
  //       title: "Privacy and security",
  //       iconPath: VIcons.privacyHelpIcon,
  //       accountSettings: {
  //         0: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         2: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //         3: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
  //       },
  //       body:
  //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  //     ),
  //   ];
  // }
}
