import 'dart:io';
import 'dart:typed_data';

enum MediaFormat { image, video, audio }
enum MediaSource { file, network, memory }
enum PickerSource { camera, gallery, file }

abstract class MediaAsset {
  final dynamic rawEntity;
  final MediaFormat? format;
  final MediaSource? source;
  final Uint8List? thumbData;

  MediaAsset({
    this.thumbData,
    this.source,
    this.format,
    this.rawEntity,
  });
}

class MemoryMediaAsset extends MediaAsset {
  final Uint8List? data;

  MemoryMediaAsset({
    this.data,
    MediaFormat? format,
    Uint8List? thumbData,
    rawEntity,
  }) : super(
          thumbData: thumbData,
          rawEntity: rawEntity,
          format: format,
          source: MediaSource.memory,
        );
}

class NetworkMediaAsset extends MediaAsset {
  final String? title;
  final String? url;

  NetworkMediaAsset({
    this.title,
    this.url,
    MediaFormat? format,
    Uint8List? thumbData,
    rawEntity,
  }) : super(thumbData: thumbData, rawEntity: rawEntity, format: format, source: MediaSource.network);
}

class FileMediaAsset extends MediaAsset {
  final String? id;
  final File? file;

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
