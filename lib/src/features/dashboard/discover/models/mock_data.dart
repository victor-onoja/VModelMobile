import 'package:vmodel/src/features/dashboard/discover/models/discover_item.dart';

List<DiscoverItemObject> recentlyViewed = List.generate(4, (index) {
  return DiscoverItemObject(
      name: '',
      userType: 'No Type',
      image: 'assets/images/models/model_11.png',
      label: '',
      username: '');
}).toList();
List<DiscoverItemObject> mostPopular = List.generate(4, (index) {
  return DiscoverItemObject(
      name: '',
      userType: 'No Type',
      image: 'assets/images/models/model_11.png',
      label: '',
      username: '');
}).toList();

List<DiscoverItemObject> petModels = List.generate(4, (index) {
  return DiscoverItemObject(
      name: '',
      userType: 'No Type',
      image: 'assets/images/models/model_11.png',
      label: '',
      username: '');
}).toList();

List<DiscoverItemObject> photoModels = List.generate(4, (index) {
  return DiscoverItemObject(
      name: '',
      userType: 'No Type',
      image: 'assets/images/models/model_11.png',
      label: '',
      username: '');
}).toList();

List<DiscoverItemObject> ontentModels = List.generate(4, (index) {
  return DiscoverItemObject(
      name: '',
      userType: 'No Type',
      image: 'assets/images/models/model_11.png',
      label: '',
      username: '');
}).toList();

List<String> categories = ['Models', 'Creators', 'Photographers', 'Pets'];
List<String> tags = [
  'Lingerie',
  'Glamour',
  'Parts',
  'Editorial',
  'Commercial',
  'Campaigns'
];

List<String> imagesAsset = [
  'assets/images/doc/main-model.png',
  'assets/images/models/model_3.png',
  'assets/images/models/model_11.png',
  'assets/images/models/model_12.png',
  'assets/images/models/model_13.png',
  'assets/images/models/model_14.png',
  'assets/images/models/model_2.png',
  'assets/images/models/model_2.png',
];

List<String> mockDiscoverCategoryAssets = [
  'assets/images/discover_categories/cat_model.jpg',
  'assets/images/discover_categories/cat_photographer.jpg',
  'assets/images/discover_categories/cat_influencer.jpg',
  'assets/images/discover_categories/cat_health_beauty.jpg',
  'assets/images/discover_categories/cat_stylist.jpg',
  'assets/images/discover_categories/cat_event_planning.jpg',
  'assets/images/discover_categories/cat_cooking.jpg',
  'assets/images/discover_categories/cat_art_design.jpg',
  'assets/images/discover_categories/cat_other.jpg',
];

final mockDiscoverCarouselPrefix = [
  // 'assets/images/discover_categories/d_carousel_0.jpg',
  'assets/images/discover_categories/d_carousel_1.jpg',
  'assets/images/discover_categories/d_carousel_2.jpg',
  'assets/images/discover_categories/d_carousel_3.jpg',
];

final mockMarketPlaceImages = [
  'assets/images/discover_categories/cat_influencer.jpg',
  'assets/images/discover_categories/cat_health_beauty.jpg',
  'assets/images/discover_categories/d_carousel_1.jpg',
  'assets/images/discover_categories/d_carousel_2.jpg',
  'assets/images/discover_categories/d_carousel_3.jpg',
];

final mockMarketPlaceHomeImages = [
  'assets/images/marketplace_home_banners/banner1.jpg',
  'assets/images/marketplace_home_banners/banner2.jpg',
  'assets/images/marketplace_home_banners/banner3.jpg',
  'assets/images/marketplace_home_banners/banner4.jpg',
  'assets/images/marketplace_home_banners/banner5.jpg',
];
final mockMarketPlaceJobsImages = [
  'assets/images/marketplace_home_banners/banner4.jpg',
  'assets/images/marketplace_home_banners/banner3.jpg',
];
final mockMarketPlaceServicesImages = [
  'assets/images/marketplace_home_banners/banner1.jpg',
  'assets/images/marketplace_home_banners/banner2.jpg',
  'assets/images/marketplace_home_banners/banner5.jpg',
];


  final List userTypesMockImages = [
    "assets/images/userTypes/Models.jpg",
    "assets/images/userTypes/Photography.jpg",
    "assets/images/userTypes/content_creation.jpg",
    "assets/images/userTypes/health_and_welness.jpg",
    "assets/images/userTypes/Styling.jpg",
    "assets/images/userTypes/event_planning.jpg",
    "assets/images/userTypes/Art.jpg",
    "assets/images/userTypes/Cook.jpg",
    "assets/images/userTypes/Chef.jpg",
    "assets/images/discover_categories/cat_other.jpg",
  ];
