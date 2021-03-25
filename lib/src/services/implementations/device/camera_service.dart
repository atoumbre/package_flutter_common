import 'package:get/get.dart';
import 'package:softi_common/src/services/class/i_media_asset.dart';
import 'package:softi_common/src/services/interfaces/device/i_camera_service.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class CameraService extends ICameraService {
  final _typeMap = <AssetType, MediaFormat>{
    AssetType.image: MediaFormat.image,
    AssetType.video: MediaFormat.video,
    AssetType.audio: MediaFormat.audio
  };

  Future<List<FileMediaAsset>> _processAssetsList(List<AssetEntity> assets) async {
    var _fileList = assets.map<Future<FileMediaAsset>>((asset) async {
      print('SSET ID : ${asset.id}');
      return FileMediaAsset(
        file: await asset.file,

        id: asset.id,
        //source: source,
        thumbData: await asset.thumbDataWithSize(200, 200),
        format: _typeMap[asset.type],
        rawEntity: asset,
      );
    }).toList();
    return await Future.wait(_fileList);
  }

  @override
  Future<List<FileMediaAsset>> useCamera({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  }) async {
    final _assetList = await CameraPicker.pickFromCamera(
      Get.context,
      // onlyEnableRecording: ,
      // isOnlyAllowRecording: !formats.contains(MediaFormat.image),
      // isAllowRecording: formats.contains(MediaFormat.video),
      resolutionPreset: ResolutionPreset.medium,
      textDelegate: EnglishCameraPickerTextDelegate(),
    );

    if (_assetList == null) return null;

    return _processAssetsList([_assetList]);
  }
}
