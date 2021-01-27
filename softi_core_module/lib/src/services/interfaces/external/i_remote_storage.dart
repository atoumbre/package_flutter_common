import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/core/base_service.dart';
import 'package:softi_core_module/src/services/class/i_media_asset.dart';

enum UploadState {
  progress,
  paused,
  canceled,
  error,
  success,
}

class UploadEvent {
  final UploadState type;
  final double uploaded;
  final double total;

  final dynamic rawrResult;

  final NetworkMediaAsset result;

  UploadEvent({this.rawrResult, this.result, this.type, this.uploaded, this.total});

  double get progress => (total != 0 && uploaded != null) ? uploaded / total : 0;
}

abstract class IRemoteStorageService extends IBaseService {
  Stream<UploadEvent> uploadMedia({
    @required Uint8List imageToUpload,
    @required String title,
    bool isFile = false,
  });

  Future<void> deleteMedia(String imageFileName);
}
