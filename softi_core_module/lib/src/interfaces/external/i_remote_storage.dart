import 'package:flutter/foundation.dart';
import 'package:softi_core_module/src/interfaces/device/i_media_picker.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

enum UploadEnventType {
  progress,
  paused,
  canceled,
  error,
  success,
}

class UploadEvent {
  final UploadEnventType type;
  final double uploaded;
  final double total;

  final dynamic rawrResult;

  final NetworkMediaAsset result;

  UploadEvent({this.rawrResult, this.result, this.type, this.uploaded, this.total});

  get progress => (total != 0 && uploaded != null) ? uploaded / total : 0;
}

abstract class IRemoteStorageService extends IBaseService {
  Stream<UploadEvent> uploadImage({
    @required dynamic imageToUpload,
    @required String title,
    bool isFile = false,
  });

  Future deleteImage(String imageFileName);
}
