import 'dart:io';
import 'dart:typed_data';

enum MediaFormat { image, video, audio }
enum MediaType { file, network, memory }
enum MediaSource { file, network, memory }
// enum PickerSource { camera, gallery, file }

class BaseMediaAsset {
  final String id;
  final File file;
  final String title;
  final String url;
  final Uint8List data;
  final MediaType type;

  //
  // final Uint8List thumbData;
  // final MediaFormat format;
  // final MediaSource source;

  BaseMediaAsset._({
    this.title,
    this.data,
    this.url,
    this.id,
    this.file,
    this.type,
    // this.thumbData,
    // this.format,
    // this.source,
  });

  factory BaseMediaAsset.network(String url, String title) {
    return BaseMediaAsset._(
      url: url,
      title: title,
      type: MediaType.network,
    );
  }

  factory BaseMediaAsset.file(File file) {
    return BaseMediaAsset._(
      file: file,
      type: MediaType.file,
    );
  }

  factory BaseMediaAsset.memory(Uint8List data) {
    return BaseMediaAsset._(
      data: data,
      type: MediaType.memory,
    );
  }

  bool get isNetworkImage => url != null;
  bool get isMemoryImage => data != null;
  bool get isFileImage => file != null;
}
