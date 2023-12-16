import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isPictureViewProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final feedProvider = ChangeNotifierProvider((ref) {
  return FeedProvider();
});

class FeedProvider extends ChangeNotifier {
  bool isShare = true;
  void isShared() {
    if (isShare) {
      isShare = false;
      notifyListeners();
    } else {
      isShare = true;
      notifyListeners();
    }
  }

  bool isLike = false;
  void isLiked() {
    isLike = !isLike;
    notifyListeners();
    // if (isLike) {
    //   isLike = false;
    //   notifyListeners();
    // }
    // else {
    //   isLike = true;
    //
    // }
  }

  bool isSave = false;
  void isSaved() {
    isSave = !isSave;
    notifyListeners();
  }

  bool isFeed = true;
  void isFeedPage(
      {bool isFeedOnly = false, bool isNavigatoToDiscover = false}) {
    if (isNavigatoToDiscover) {
      // print('^^^^^^^^^^^^^ First if');
      isFeed = false;
      notifyListeners();
      return;
    }
    if (isFeedOnly) {
      // print('^^^^^^^^^^^^^ if 2');
      isFeed = true;
      notifyListeners();
      return;
    }
    if (isFeed) {
      // print('^^^^^^^^^^^^^ if 3');
      isFeed = false;
      notifyListeners();
    } else {
      // print('^^^^^^^^^^^^^ else');
      isFeed = true;
      notifyListeners();
    }
  }

  // For the usage of Gallery Feed View Page
  // bool isPictureView = false;
  // void isPictureViewState() {
  //   isPictureView = !isPictureView;
  //   notifyListeners();
  // }

//Api call should not be in a controller
  //get feed stream

//   Future<Map<String, dynamic>?> getAllFeedPostsssss() async {
//     try {
//       final result =
//           await vBaseServiceInstance.getOrdinaryQuery(queryDocument: '''
// query getposts{
//   posts{
//     data{
//       photos{
//         data{
//           itemLink
//           description
//           postSet{
//             data{
//               postType
//             }
//           }
//         }
//       },
//       postType
//       videos{
//         data{
//           id
//           itemLink

//         }
//       }
//       audios{
//         data{
//           id
//           itemLink
//         }
//       }
//       album{
//         name
//       },
//       postType
//       id
//     }
//   }
// }

// ''', payload: {});

//       return result;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
}
