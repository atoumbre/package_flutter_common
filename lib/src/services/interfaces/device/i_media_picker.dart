import 'package:softi_common/src/core/base_service.dart';
import 'package:softi_common/src/services/class/i_media_asset.dart';

abstract class IMediaPicker extends IBaseService {
  Future<List<FileMediaAsset>> selectMediaFromGallery({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
    List<FileMediaAsset> selectedItemId = const [],
    int maxItem,
  });

  Future<List<FileMediaAsset>> selectMediaFromCamera({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  });
}
