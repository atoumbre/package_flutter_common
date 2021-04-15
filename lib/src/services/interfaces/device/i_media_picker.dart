import 'dart:io';

import 'package:softi_common/src/core/controllers/BaseService.dart';
import 'package:softi_common/src/services/class/i_media_asset.dart';

abstract class IMediaPicker extends IBaseService {
  Future<List<FileMediaAsset>?> selectMediaFromGallery({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
    List<FileMediaAsset> selectedItemId = const [],
    int? maxItem,
  });

  ///
  Future<File?> singleImageSelect({bool? crop, PickerSource? source});
}
