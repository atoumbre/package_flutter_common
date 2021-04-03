import 'package:softi_common/src/core/base_service.dart';
import 'package:softi_common/src/services/class/i_media_asset.dart';

abstract class ICameraService extends IBaseService {
  Future<List<FileMediaAsset>> useCamera({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  });
}