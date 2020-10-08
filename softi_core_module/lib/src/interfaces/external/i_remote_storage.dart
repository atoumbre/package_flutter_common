import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

abstract class IRemoteStorageService extends IBaseService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
  });

  Future deleteImage(String imageFileName);
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}
