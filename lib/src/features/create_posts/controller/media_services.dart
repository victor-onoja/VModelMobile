
import 'package:photo_manager/photo_manager.dart';

class MediaServices {
  Future loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];

    if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(type: requestType);
    } else {
      PhotoManager.openSetting();
    }

    return albumList;
  }

  Future loadAssets(AssetPathEntity selectedAlbum, int page) async {
    // PhotoManager.getAssetPathList()
    List<AssetEntity> assetList =
        // await PhotoManager.getAssetListRange(start: 20 * (page - 1), end: 20 * page);
    await selectedAlbum.getAssetListPaged(page: page, size: 48);
    return assetList;
  }
}
