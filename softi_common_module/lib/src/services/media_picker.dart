import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class MediaPicker extends IMediaPicker {
  Map<Set<MediaFormat>, RequestType> _requestTypeMapper = {
    {MediaFormat.audio}: RequestType.audio,
    {MediaFormat.video}: RequestType.video,
    {MediaFormat.image}: RequestType.image,
    {MediaFormat.image, MediaFormat.video}: RequestType.common,
    {MediaFormat.audio, MediaFormat.video, MediaFormat.image}: RequestType.all,
    {MediaFormat.audio, MediaFormat.video}: RequestType.video,
    {MediaFormat.audio, MediaFormat.image}: RequestType.image,
  };

  Future<List<MediaAsset>> _processAssetsList(List<AssetEntity> assets) async {
    List<Future<MediaAsset>> _fileList = assets.map<Future<MediaAsset>>((asset) async {
      return MediaAsset(
        file: await asset.file,
        id: asset.id,
      );
    });
    return await Future.wait(_fileList);
  }

  @override
  Future<List<MediaAsset>> selectMediaFromCamera({Set<MediaFormat> formats}) async {
    final AssetEntity _assetList = await CameraPicker.pickFromCamera(
      Get.context,
      isOnlyAllowRecording: !formats.contains(MediaFormat.image),
      isAllowRecording: formats.contains(MediaFormat.video),
      resolutionPreset: ResolutionPreset.medium,
    );

    if (_assetList == null) return null;

    return _processAssetsList([_assetList]);
  }

  @override
  Future<List<MediaAsset>> selectMediaFromGalery({Set<MediaFormat> formats, List<MediaAsset> selectedItemId}) async {
    List<AssetEntity> _lastSelection = await Future.wait(selectedItemId.map((e) => AssetEntity.fromId(e.id)).toList());

    RequestType _requestType = _requestTypeMapper[formats];
    final List<AssetEntity> _assetList = await AssetPicker.pickAssets(
      Get.context,
      requestType: _requestType,
      selectedAssets: _lastSelection,
    );

    if (_assetList == null) return null;

    return _processAssetsList(_assetList);
  }
}
