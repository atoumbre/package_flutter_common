import 'package:get/get.dart';
import 'package:softi_services_module/src/class/i_media_asset.dart';
import 'package:softi_services_module/src/interfaces/device/i_media_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class MediaPicker extends IMediaPicker {
  final _requestTypeMapper = {
    {MediaFormat.audio}: RequestType.audio,
    {MediaFormat.video}: RequestType.video,
    {MediaFormat.image}: RequestType.image,
    {MediaFormat.image, MediaFormat.video}: RequestType.common,
    {MediaFormat.audio, MediaFormat.video, MediaFormat.image}: RequestType.all,
    {MediaFormat.audio, MediaFormat.video}: RequestType.video,
    {MediaFormat.audio, MediaFormat.image}: RequestType.image,
  };

  final _typeMap = {
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
  Future<List<FileMediaAsset>> selectMediaFromCamera({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  }) async {
    final _assetList = await CameraPicker.pickFromCamera(
      Get.context,
      isOnlyAllowRecording: !formats.contains(MediaFormat.image),
      isAllowRecording: formats.contains(MediaFormat.video),
      resolutionPreset: ResolutionPreset.medium,
      textDelegate: EnglishCameraPickerTextDelegate(),
    );

    if (_assetList == null) return null;

    return _processAssetsList([_assetList]);
  }

  @override
  Future<List<FileMediaAsset>> selectMediaFromGallery({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
    List<FileMediaAsset> selectedItemId = const [],
    int maxItem,
  }) async {
    var _lastSelection = await Future.wait(selectedItemId.map((e) => AssetEntity.fromId(e.id)).toList());

    var _requestType = _requestTypeMapper[formats];
    final _assetList = await AssetPicker.pickAssets(
      Get.context,
      requestType: _requestType,
      selectedAssets: _lastSelection,
      textDelegate: EnglishTextDelegate(),
      maxAssets: maxItem,
    );

    if (_assetList == null) return null;

    return _processAssetsList(_assetList);
  }
}
