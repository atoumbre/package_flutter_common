import 'dart:io';
import 'dart:typed_data';

import 'package:softi_core_module/softi_core_module.dart';

abstract class IMediaPicker extends IBaseService {
  Future<List<MediaAsset>> selectMediaFromGalery({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
    List<MediaAsset> selectedItemId = const [],
  });

  Future<List<MediaAsset>> selectMediaFromCamera({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
  });
}

class MediaAsset {
  final String id;
  final File file;
  final dynamic rawEntity;
  final MediaSource source;
  final MediaType format;
  final Uint8List thumbData;

  MediaAsset({this.thumbData, this.source, this.format, this.id, this.file, this.rawEntity});
}

enum MediaType { image, video, audio }
enum MediaSource { galery, camera }
