import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class IRemoteStorageService {
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
