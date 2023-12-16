import 'package:vmodel/src/res/icons.dart';

class HelpSupportModel {
  final String? title;
  final String? body;
  final String? iconPath;
  final Map<int, String>? accountSettings;
  HelpSupportModel(
      {this.title, this.body, this.iconPath, this.accountSettings});

  static List<HelpSupportModel> vmodelCredits() {
    return [
      HelpSupportModel(title: "What are VMC (VModel Credits)?", body: """
"""),
      HelpSupportModel(title: "How can I earn VMC?", body: """
"""),
      HelpSupportModel(title: "Can I purchase VMC directly?", body: """
"""),
      HelpSupportModel(title: "What can I use VMC for?", body: """
"""),
      HelpSupportModel(title: "Are VMC transferable between users?", body: """
"""),
      HelpSupportModel(title: "Do VMC have an expiration date?", body: """
"""),
      HelpSupportModel(
        title: "Can I use VMC to pay for any service or product on VModel?",
        body: "",
      ),
      HelpSupportModel(
          title: "How can I check my current VMC balance?", body: """
"""),
      HelpSupportModel(
          title: "Is there a minimum amount of VMC required to redeem rewards?",
          body: """
"""),
      HelpSupportModel(title: "How can I redeem my VMC for rewards?", body: """
"""),
      HelpSupportModel(
          title: "What kind of rewards can I get with VMC?", body: """
"""),
      HelpSupportModel(
          title: "Can I use VMC to pay for premium plans or subscriptions?",
          body: """
"""),
      HelpSupportModel(
          title: "Are there any restrictions on using VMC?", body: """
"""),
      HelpSupportModel(
          title: "Can I combine VMC with other payment methods?", body: """
"""),
      HelpSupportModel(
          title: "Are there any fees associated with using VMC?", body: """
"""),
      HelpSupportModel(
          title: "Is ther a maximum limit to the number of VMC "
              "I can earn or accumulate?",
          body: """
"""),
      HelpSupportModel(
          title: "How quickly will I receive my rewards after"
              " redeeming VMC?",
          body: """
"""),
      HelpSupportModel(
          title: "Can I earn VMC by referring friends to VModel?", body: """
"""),
      HelpSupportModel(
          title: "Can I earn VMC by participating in the VModel"
              " community?",
          body: ""),
      HelpSupportModel(
          title: "Is there a support team I can contact for VMC "
              "related inquiries?",
          body: ""),
    ];
  }

  static List<HelpSupportModel> popularFAQS() {
    return [
      HelpSupportModel(title: "Change or reset your password", body: """
        <p>Follow these steps to change your password in the app:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Open the app and navigate to the main menu.</li>
          <li>Click on <b>Settings</b></li>
          <li>Scroll down and select the <b>Security</b> submenu.</li>
          <li>In the Security menu, select <b>Password Settings.</b></li>
          <li>Follow the on-screen instructions to change your password.</li>
        </ol>
        <p>Note: You may be prompted to enter your current password before changing it. Make sure to choose a strong password that is unique to this app and that you can remember easily.</p>
        <!--You can pretty much put any html in here!-->
"""),
      HelpSupportModel(title: "How to create a verified pets profile", body: """
        <p>Creating as Pet Profile on VModel</p>
        <p>To create a verified pet profile on VModel, follow these steps:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Sign up for a freelance account on the VModel app with your own personal details.</li>
          <li>During the registration process, you will be prompted to select an account type. Choose <b>Pet Creator</b> as your account type.</li>
          <li>Once you have registered as a Pet Creator, you will need to verify your personal details for security purposes. This also helps us confirm that you are authorised to register the pet.</li>
          <li>Follow the on-screen instructions to complete the verification process. You may be required to provide additional documentation to .</li>
          <li>Once your personal details have been verified, you can proceed to create a profile for your pet. Provide all necessary information such as name, age, breed, and any other relevant information.</li>
        </ol>
        <p>Note: At this time, it is not possible to switch any other account type to a pet account on VModel. You will need to create a separate freelance account specifically for your pet. By creating a verified pet profile on VModel, you can connect with other pet creators or businesses who re looking to hire pets.</p>
        <!--You can pretty much put any html in here!-->
"""),
      HelpSupportModel(title: "How to pause your VModel account ", body: """
        <p>How to Pause Your VModel Account</p>
        <p>If you need to take a break from using VModel, you can pause your account. Here's how:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Open the VModel app and navigate to the main menu.</li>
          <li>From the main menu, click on <b>Settings.</b></li>
          <li>In the <b>Settings.</b> menu, select the <b>Accounts</b> submenu.</li>
          <li>In the <b>Accounts</b> submenu, select <b>Pause Account</b>.</li>
          <li>Follow the on-screen instructions to confirm that you want to pause your account.</li>
        </ol>
        <p>Once your account is paused, your profile will not be visible to other users and you will not receive any new booking requests. However, any existing bookings that you have will remain active until their completion date.</p>
        <!--You can pretty much put any html in here!-->
"""),
      HelpSupportModel(title: "How to close your VModel account", body: """
        <p>If you no longer wish to use VModel, you can deactivate your account. Here's how:</p>
        <p>If you need to take a break from using VModel, you can pause your account. Here's how:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Open the VModel app and navigate to the main menu.</li>
          <li>From the main menu, click on <b>Settings.</b></li>
          <li>In the <b>Settings.</b> menu, select the <b>Accounts</b> submenu.</li>
          <li>In the <b>Accounts</b> submenu, select <b>Deactivate Account</b>.</li>
          <li>Follow the on-screen instructions to confirm that you want to deactivate your account.</li>
        </ol>
        <p>Once your account is deactivated, your profile and all of your information will be removed from the VModel app. You will no longer receive any notifications or booking requests from the app. If you decide to use VModel again in the future, you will need to create a new account.</p>
        <p>Note: Before you deactivate your account, make sure that you have completed any outstanding bookings or cancellations. Any active bookings will be cancelled automatically when you deactivate your account.</p>
        <!--You can pretty much put any html in here!-->
"""),
      HelpSupportModel(
          title: "How to report something a breach of our terms and conditions",
          body: """
        <p>To report a breach of VModel's terms and conditions, follow these simple steps:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Go to the main menu and click on <b>Settings</b>.</li>
          <li>Select <b>Security</b>.</li>
          <li>Click on <b>Report a User</b></li>
          <li>Provide as much detail as possible about the breach. You may be asked to provide additional information depending on the type of breach.</li>
          <li>Click <b>Submit</b></li>
        </ol>
        <p>Alternatively, you can report a user from their profile. Simply tap on any of their photos and report them from there.</p>
        <p>If the breach is related to content, select the options related to the content and then click <b>Report</b></p>
        <p>It is important to provide as much information as possible when reporting a breach. This will help us keep VModel as safe as possible for everyone. Thank you for your help in making our platform a safe and respectful community.</p>
  <!--You can pretty much put any html in here!-->
"""),
      HelpSupportModel(title: "How to create a booking (job)", body: """
        <p>Creating a booking on VModel is easy. Just follow these simple steps:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Open the VModel app and navigate to the main screen.</li>
          <li>Tap the middle round (VModel) button.</li>
          <li>From the popup menu, select <b>Create a Job</b>.</li>
          <li>Fill out the job details form, which will include:</li>
            <ul>
              <li>Job title and description</li>
              <li>Date and time of the job</li>
              <li>Job location</li>
              <li>Desired pay rate</li>
              <li>Required skills or experience</li>
           </ul>
        </ol>
        <p>Once you've entered all the necessary information, tap <b>Create</b> to submit your job posting.</p>
        <p>Your job will now be visible to all relevant creators on VModel. You'll receive notifications as creators apply for your job, and you can review their profiles and ratings before choosing who to hire.</p>
        <p>Note: Make sure to provide as much detail as possible in your job posting to attract the right creators for your job. And once you've hired someone for your job, make sure to communicate with them promptly and clearly to ensure a successful and smooth booking experience.</p>
  <!--You can pretty much put any html in here!-->
"""),
      // HelpSupportModel(
      //   title: "How to create a smart contract",
      //   body:
      //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      // ),
      HelpSupportModel(
        title: "How to get booked by brands",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),

//       HelpSupportModel(
//         title: "How to get noticed by brands",
//           body: """
//         <p>Getting booked by brands on VModel requires a combination of talent, professionalism, and strong communication skills. Here are some tips to help you stand out from the competition and increase your chances of landing bookings:</p>
//         <ol style="padding: 1px; margin-top:10px" start="1">
//           <li>Maintain Good Work Quality and Delivery: Brands are looking for models who consistently deliver high-quality work. Make sure to always put your best foot forward and exceed their expectations.</li>
//           <li>Have a Great Personality: In addition to your modeling skills, brands also want to work with models who have a positive attitude and friendly demeanor. Being personable and easy to work with can go a long way in building lasting relationships with brands.</li>
//           <li>Communicate Well: Strong communication skills are essential for success on VModel. Make sure to respond promptly and professionally to messages from brands and keep them updated on any changes or issues that arise.</li>
//           <li>Build a Great Portfolio: Your portfolio is your chance to showcase your talent and experience to brands. Make sure to include high-quality photos and a diverse range of work that highlights your unique strengths.</li>
//           <li>Keep Your Profile Up-to-Date: Regularly update your VModel profile with your latest work, skills, and experience. This will help brands find you more easily and ensure that your profile accurately reflects your current abilities.</li>
//           <li>Ask for Reviews: Reviews from brands you've worked with can help you stand out from other models on VModel. Encourage businesses to leave a review after working with you and make sure to respond to any feedback you receive.</li>
//           <li>Create High-Quality Content: To attract brands, make sure that the content on your VModel account is of the highest quality. This includes your photos, videos, and other promotional materials.</li>
//           <li>Offer Discounts for Recurring Customers: Building strong relationships with brands can lead to recurring work and steady income. Consider offering discounts or other incentives to encourage brands to book with you again and again.</li>
//
//         </ol>
//         <p>By following these tips, you can increase your visibility on VModel and attract more bookings from brands looking for talented and professional models.</p>
//       <!--You can pretty much put any html in here!-->
// """),
//       HelpSupportModel(
//           title: "Here's how to qualify for a creator’s badge at VModel",
//           body: """
//         <ol style="padding: 1px; margin-top:10px" start="1">
//           <li>Complete at least 10 bookings on VModel.</li>
//           <li>Maintain a minimum rating of 4.5 stars or higher for your bookings.</li>
//           <li>Communicate Well: Strong communication skills are essential for success on VModel. Make sure to respond promptly and professionally to messages from brands and keep them updated on any changes or issues that arise.</li>
//           <li>Build a Great Portfolio: Your portfolio is your chance to showcase your talent and experience to brands. Make sure to include high-quality photos and a diverse range of work that highlights your unique strengths.</li>
//           <li>Keep Your Profile Up-to-Date: Regularly update your VModel profile with your latest work, skills, and experience. This will help brands find you more easily and ensure that your profile accurately reflects your current abilities.</li>
//           <li>Ask for Reviews: Reviews from brands you've worked with can help you stand out from other models on VModel. Encourage businesses to leave a review after working with you and make sure to respond to any feedback you receive.</li>
//           <li>Create High-Quality Content: To attract brands, make sure that the content on your VModel account is of the highest quality. This includes your photos, videos, and other promotional materials.</li>
//           <li>Offer Discounts for Recurring Customers: Building strong relationships with brands can lead to recurring work and steady income. Consider offering discounts or other incentives to encourage brands to book with you again and again.</li>
//
//         </ol>
//         <p>By following these tips, you can increase your visibility on VModel and attract more bookings from brands looking for talented and professional models.</p>
//       <!--You can pretty much put any html in here!-->
// """),
      HelpSupportModel(
          title: "How to qualify for a creator’s badge at VModel. ",
          body:
              """<p>Here's how to <b>qualify</b> for a creator’s badge at VModel:</p>
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li>Complete at least 10 bookings on VModel.</li>
          <li><b>Maintain</b> a <b>minimum</b> rating of <b>4.5</b> stars or higher for your bookings.</li>
        </ol>
        <p>Getting a verified blue badge at VModel is important because it shows potential clients and brands that you are a <b>reliable and trusted creator</b>. This can lead to more bookings and opportunities for you in the future.</p>
        <p>By following these simple steps and providing <b>high-quality work</b> to your clients, you can earn a blue badge and stand out as a top creator on VModel. Good luck!</p>
  <!--You can pretty much put any html in here!-->
"""),
      HelpSupportModel(
          title: "How to compete effectively with other creatives. ", body: """
        <ol style="padding: 1px; margin-top:10px" start="1">
          <li><b>Showcase your strengths</b>: Highlight your unique skills and qualities that set you apart from other creators. This could be your experience, your portfolio, or your ability to work with a diverse range of clients.</li>
          <li><b>Maintain a professional profile</b>: Keep your profile updated with <b>recent work</b> and ensure that your portfolio is of <b>high quality</b>. This will give you an edge when clients are browsing through different creators' profiles.</li>
          <li><b>Communicate effectively</b>: Communication is key in any professional relationship, so be sure to <b>respond to messages</b> in a timely manner and <b>provide clear and concise answers</b> to any questions or concerns your clients may have.</li>
          <li><b>Provide high-quality work</b>: Clients are more likely to re-book you or recommend you to others if they are satisfied with the quality of your work. Focus on delivering top-notch results <b>every time</b>.</li>
          <li><b>Build relationships</b>: Offering discounts to recurring customers or brands can help build a sense of loyalty and trust, which can lead to more bookings in the long run.</li>
          <li><b>Get reviews</b>: <b>Encourage clients</b> to leave reviews after working with you. The more <b>positive reviews</b> you have, the more likely you are to stand out from other creators.</li>
          <li><b>Stay up-to-date</b>: Keep up with the latest trends in your industry and continue to <b>develop your skills</b>. This will not only make you a more valuable asset to clients, but also help you stay ahead of the competition.</li>
        </ol>
  <!--You can pretty much put any html in here!-->
"""),

      HelpSupportModel(title: "How to create a job", body: """
"""),

      HelpSupportModel(title: "How to print a portfolio or Polaroid", body: """
"""),
      HelpSupportModel(title: "How to create a service", body: """
"""),
      HelpSupportModel(title: "How to create a portfolio post", body: """
"""),
      HelpSupportModel(title: "VModel credits - how they work", body: """
"""),
      HelpSupportModel(title: "How to apply for a job", body: """
"""),
      HelpSupportModel(title: "How to find new creatives", body: """
"""),
      HelpSupportModel(title: "Connect and follow", body: """
"""),
      HelpSupportModel(title: "How to create an invoice", body: """
"""),
      HelpSupportModel(title: "The business suite", body: """
"""),
    ];
  }

  static List<HelpSupportModel> faqTopics() {
    return [
      HelpSupportModel(
        title: "Account settings",
        iconPath: VIcons.accountHelpIcon,
        accountSettings: {
          0: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          2: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          3: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
        },
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
      HelpSupportModel(
        title: "Login and password",
        iconPath: VIcons.loginHelpIcon,
        accountSettings: {
          0: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          2: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          3: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
        },
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
      HelpSupportModel(
        title: "Privacy and security",
        iconPath: VIcons.privacyHelpIcon,
        accountSettings: {
          0: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          1: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          2: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
          3: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet",
        },
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      ),
    ];
  }
}
