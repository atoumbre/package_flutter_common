import 'dart:io';
import 'dart:typed_data';

enum BaseMediaFormat { image, video, audio }
enum BaseMediaType { file, network, memory }
enum BaseMediaSource { file, network, memory }
// enum PickerSource { camera, gallery, file }

class BaseMediaAsset {
  final String id;
  final File file;
  final String title;
  final String url;
  final Uint8List data;
  final BaseMediaType type;

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
      type: BaseMediaType.network,
    );
  }

  factory BaseMediaAsset.file(File file) {
    return BaseMediaAsset._(
      file: file,
      type: BaseMediaType.file,
    );
  }

  factory BaseMediaAsset.memory(Uint8List data) {
    return BaseMediaAsset._(
      data: data,
      type: BaseMediaType.memory,
    );
  }

  bool get isNetworkImage => url != null;
  bool get isMemoryImage => data != null;
  bool get isFileImage => file != null;
}
