import 'package:intl/intl.dart';
import 'package:vmodel/src/core/models/user.dart';

class VConstants {
  static bool isDarkMode = false;
  static VUser? logggedInUser;
  static dynamic loginReponse;
  static const double emojiOnlyMessageHugeSize = 28;
  static const double emojiOnlyMessageBigSize = 24;
  static const double emojiOnlyMessageMediumSize = 20;
  static const double normalChatMessageSize = 16;
  static const int discoverSectionItemsCount = 8;
  static const int maxServiceBannerImages = 10;
  static const double bottomPaddingForBottomSheets = 15;
  static const int maxPostHastagsAllowed = 50;
  static const int MB = 1 * 1024 * 1024;

  //Values
  static const int maxBioLength = 2000;

  static final noDecimalCurrencyFormatterGB =
      NumberFormat.simpleCurrency(locale: "en_GB", decimalDigits: 0);
  static final twoDigitsCurrencyFormatterGB =
      NumberFormat.simpleCurrency(locale: "en_GB");
  static final simpleDateFormatter = DateFormat('d MMM yyyy');
  static final simpleDateFormatterWithNoYear = DateFormat('d MMM');
  static final dayMonthDateFormatter = DateFormat('d MMMM');
  static final dayDateFormatter = DateFormat('d');

  // static const kDeliveryType = ["On-Location", "Hybrid", "Remote"];

  static const kUsageTypes = [
    'Private',
    'Commercial',
    'Social media',
    'Any',
    // 'All',
    // 'Other (please type)',
  ];

  static const kDeliveryOptions = [
//     2-3 days
// 4-7 days`
// 1-2 weeks
// 2-4 weeks
// 1-2 months
// 3 months
// 6 months
    '2-3 days',
    '4-7 days',
    '1-2 weeks',
    '2-4 weeks',
    '1-2 months',
    '3 months',
    '6 months',
    // 'On-Location',
    'Other (please specify)',
  ];

  static const kUsageLengthOptions = [
    '1 week',
    '2 weeks',
    '3 weeks',
    '1 month',
    '2 months',
    '3 months',
    '4 months',
    '5 months',
    '6 months',
    '1 year',
    '2 years',
    '3 years',
    '4 years',
    '5 years',
    'Forever',
    'Other (please specify)',
  ];

  //Debug values
  static const assetImagesPrefix = 'assets/images';
  static const testImage =
      "https://images.unsplash.com/photo-1604514628550-37477afdf4e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3327&q=80";
  static const testPetImage = 'https://i.imgur.com/5q9Me7Z.jpg';

  static const vellMagMockImages = [
    '$assetImagesPrefix/vell_magazine_images/vell_mag_art1.jpg',
    '$assetImagesPrefix/vell_magazine_images/vell_mag_art2.jpg',
    '$assetImagesPrefix/vell_magazine_images/vell_mag_art3.jpg',
  ];

  static const vellMagArticleLinks = [
    "https://vellmagazine.com/article/30/2",
    "https://vellmagazine.com/article/30/2",
    "https://vellmagazine.com/article/59/1",
  ];

  static const userPersonalities = [
    "Altruistic",
    "Artistic",
    "Bold",
    "Caring",
    "Charismatic",
    "Charming",
    "Creative",
    "Curious",
    "Energetic",
    "Enthusiastic",
    "Experimental",
    "Fact-minded",
    "Imaginative",
    "Idealist",
    "Inspiring",
    "Intellectual",
    "Innovative",
    "Kind",
    "Leader",
    "Logical",
    "Mystical",
    "Organised",
    "Perceptive",
    "Planner",
    "Poetic",
    "Popular",
    "Practical",
    "Punctual",
    "Quiet",
    "Reliable",
    "Sociable",
    "Smart",
    "Spontaneous",
    "Strategic",
    "Strong-willed",
    "Warm",
  ];

  static final platforms = [
    'Facebook',
    'Instagram',
    'Twitter',
    'Snapchat',
    'Tiktok',
    'Youtube',
    'Patreon',
    'Reddit',
    'Linkedin',
    'Pinterest',
    // 'Other'
  ];

  static final tempCategories = [
    'Modelling',
    'Photography',
    'Content Creation',
    'Beauty and Wellness',
    'Styling and Wardrobe',
    'Event planning',
    'Art and Design',
    'Culinary and baking',
    'Other',
  ];
}
