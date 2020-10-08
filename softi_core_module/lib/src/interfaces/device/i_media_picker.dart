import 'dart:io';

import 'package:softi_core_module/softi_core_module.dart';

abstract class IMediaPicker extends IBaseService {
  Future<List<MediaAsset>> selectMediaFromGalery({
    Set<MediaFormat> formats,
    List<MediaAsset> selectedItemId,
  });

  Future<List<MediaAsset>> selectMediaFromCamera({
    Set<MediaFormat> formats,
  });
}

class MediaAsset {
  final String id;
  final File file;
  final dynamic rawEntity;
  final MediaSource source;
  final MediaFormat format;

  MediaAsset({this.source, this.format, this.id, this.file, this.rawEntity});
}

enum MediaFormat { image, video, audio }
enum MediaSource { galery, camera }
