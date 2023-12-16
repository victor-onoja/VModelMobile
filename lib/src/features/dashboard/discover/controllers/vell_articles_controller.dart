import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/helper_functions.dart';
import '../models/vell_article.dart';

final vellLinks = {
  "https://vellmagazine.com/article/43/3":
      "Tems' Controversial Oscar Dress Sparks Debate on Red Carpet Etiquette",
  "https://vellmagazine.com/article/16/2":
      "Beyoncé Shines in a Spectacular Performance at a Private Event in Dubai",
  "https://vellmagazine.com/article/26/3":
      "Interview with An Influencer - Mr Deals Manchester",
  "https://vellmagazine.com/article/72/1":
      "Dame Mary Quant: Remembering the Legacy of a Fashion Icon and Trailblazer",
  "https://vellmagazine.com/article/30/2":
      "Why Is Everyone Wearing These Cartoonish Red Boots?",
  "https://vellmagazine.com/article/59/1":
      "Fashion for all sizes: Celebrating body diversity in the industry",
  "https://vellmagazine.com/article/41/3":
      "Beyoncé's Ivy Park Faces Uncertain Future Following Failure to Meet Sales Projections",
};

// final articleTitles = [
//   "Tems' Controversial Oscar Dress Sparks Debate on Red Carpet Etiquette",
//   "Beyoncé Shines in a Spectacular Performance at a Private Event in Dubai",
//   "Interview with An Influencer - Mr Deals Manchester",
//   "Dame Mary Quant: Remembering the Legacy of a Fashion Icon and Trailblazer",
//   "Why Is Everyone Wearing These Cartoonish Red Boots?",
//   "Fashion for all sizes: Celebrating body diversity in the industry",
//   "Beyoncé's Ivy Park Faces Uncertain Future Following Failure to Meet Sales Projections",
// ];

final vellArticlesProvider =
    AsyncNotifierProvider<VellArticlesNotifier, List<VellArticle>>(
        VellArticlesNotifier.new);

class VellArticlesNotifier extends AsyncNotifier<List<VellArticle>> {
  @override
  Future<List<VellArticle>> build() async {
    List<VellArticle> articles = [];

    for (var item in vellLinks.entries) {
      final temp = await getLinkMetadataAny(item.key, item.value);
      // getLinkMetadata(item);
      print('[linkM] ${temp}');
      articles.add(temp);
    }
    return articles;
  }
}
