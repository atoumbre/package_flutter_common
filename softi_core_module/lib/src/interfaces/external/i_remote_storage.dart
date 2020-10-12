import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/interfaces/device/i_media_picker.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

abstract class IRemoteStorageService extends IBaseService {
  Future<NetworkMediaAsset> uploadImage({
    @required dynamic imageToUpload,
    @required String title,
    bool isFile = false,
  });

  Future deleteImage(String imageFileName);
}
