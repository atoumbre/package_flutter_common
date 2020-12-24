import 'package:softi_common_module/src/class/i_media_asset.dart';
import 'package:softi_core_module/index.dart';

// enum MediaFormat { image, video, audio }
// enum MediaSource { file, network, memory }

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
