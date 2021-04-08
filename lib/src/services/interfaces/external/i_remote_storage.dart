import 'dart:typed_data';

import 'package:softi_common/src/core/BaseService.dart';
import 'package:softi_common/src/services/class/i_media_asset.dart';

enum UploadState {
  running,
  paused,
  canceled,
  error,
  success,
}

class UploadEvent {
  final UploadState? type;
  final double? uploaded;
  final double? total;

  final dynamic rawrResult;

  final NetworkMediaAsset? result;

  UploadEvent({this.rawrResult, this.result, this.type, this.uploaded, this.total});

  double get progress => (total != 0 && uploaded != null) ? uploaded! / total! : 0;
}

abstract class IRemoteStorageService extends IBaseService {
  Future<UploadEvent> uploadMedia({
    required Uint8List imageToUpload,
    required String title,
  });

  Stream<UploadEvent> uploadMediaStream({
    required Uint8List imageToUpload,
    required String title,
  });

  Future<void> deleteMedia(String imageFileName);
}
