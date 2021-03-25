// import 'dart:io';

// import 'package:file_picker/file_picker.dart' as filePicker;
// import 'package:softi_common/src/core/base_service.dart';
// import 'package:softi_common/src/services/class/i_media_asset.dart';

// enum FileType {
//   other,
//   image,
//   video,
//   audio,
//   any,
//   custom,
// }

// abstract class IMediaPicker extends IBaseService {
//   Future<File> pickFile({
//     List<String> allowedExtensions,
//     Set<FileType> fileType = const {FileType.any},
//     int maxItemCount,
//   });

//   Future<List<FileMediaAsset>> selectMediaFromCamera({
//     Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
//   });

//   ///
//   Future<File> singleImageSelect({bool crop, PickerSource source});
// }

// test() {
//   filePicker.FilePicker.platform.pickFiles(
//     allowedExtensions: ,
//     allowCompression: true,
//     allowMultiple: true,
//     withData: true,
//     withReadStream: true,
//     type: filePicker.FileType

//   );
// }
