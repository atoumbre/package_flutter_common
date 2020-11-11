import 'dart:io';
import 'dart:typed_data';

import 'package:softi_core_module/src/interfaces/i_base_service.dart';

enum MediaType { image, video, audio }
enum MediaSource { galery, camera, network, memory, asset }

abstract class IMediaPicker extends IBaseService {
  Future<List<FileMediaAsset>> selectMediaFromGallery({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
    List<FileMediaAsset> selectedItemId = const [],
    int maxItem,
  });

  Future<List<FileMediaAsset>> selectMediaFromCamera({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
  });
}

abstract class MediaAsset {
  final dynamic rawEntity;
  final MediaType format;
  final Uint8List thumbData;

  MediaAsset({
    this.thumbData,
    this.format,
    this.rawEntity,
  });
}

class NetworkMediaAsset extends MediaAsset {
  final String title;
  final String url;

  NetworkMediaAsset({
    this.title,
    this.url,
    thumbData,
    format,
    rawEntity,
  }) : super(
          thumbData: thumbData,
          rawEntity: rawEntity,
          format: format,
        );
}

class MemoryMediaAsset extends MediaAsset {
  final Uint8List data;

  MemoryMediaAsset({
    this.data,
    thumbData,
    format,
    rawEntity,
  }) : super(
          thumbData: thumbData,
          rawEntity: rawEntity,
          format: format,
        );
}

class FileMediaAsset extends MediaAsset {
  final String id;
  final File file;

  // File (Gallery and Camera)
  // final dynamic rawEntity;
  // final MediaType format;
  // final Uint8List thumbData;
  // Data
  // final MediaSource source;

  FileMediaAsset({
    this.id,
    this.file,
    thumbData,
    format,
    rawEntity,
  }) : super(
          thumbData: thumbData,
          rawEntity: rawEntity,
          format: format,
        );
}
