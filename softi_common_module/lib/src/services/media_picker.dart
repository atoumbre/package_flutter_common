import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class MediaPicker extends IMediaPicker {
  Map<Set<MediaType>, RequestType> _requestTypeMapper = {
    {MediaType.audio}: RequestType.audio,
    {MediaType.video}: RequestType.video,
    {MediaType.image}: RequestType.image,
    {MediaType.image, MediaType.video}: RequestType.common,
    {MediaType.audio, MediaType.video, MediaType.image}: RequestType.all,
    {MediaType.audio, MediaType.video}: RequestType.video,
    {MediaType.audio, MediaType.image}: RequestType.image,
  };

  Map _typeMap = {AssetType.image: MediaType.image, AssetType.video: MediaType.video, AssetType.audio: MediaType.audio};

  Future<List<MediaAsset>> _processAssetsList(
    List<AssetEntity> assets,
    MediaSource source,
  ) async {
    List<Future<MediaAsset>> _fileList = assets.map<Future<MediaAsset>>((asset) async {
      print('SSET ID : ${asset.id}');
      return MediaAsset(
        file: await asset.file,
        id: asset.id,
        source: source,
        thumbData: await asset.thumbDataWithSize(200, 200),
        format: _typeMap[asset.type],
        rawEntity: asset,
      );
    }).toList();
    return await Future.wait(_fileList);
  }

  @override
  Future<List<MediaAsset>> selectMediaFromCamera({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
  }) async {
    final AssetEntity _assetList = await CameraPicker.pickFromCamera(
      Get.context,
      isOnlyAllowRecording: !formats.contains(MediaType.image),
      isAllowRecording: formats.contains(MediaType.video),
      resolutionPreset: ResolutionPreset.medium,
      textDelegate: EnglishCameraPickerTextDelegate(),
    );

    if (_assetList == null) return null;

    return _processAssetsList([_assetList], MediaSource.camera);
  }

  @override
  Future<List<MediaAsset>> selectMediaFromGalery({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
    List<MediaAsset> selectedItemId = const [],
  }) async {
    List<AssetEntity> _lastSelection = await Future.wait(selectedItemId.map((e) => AssetEntity.fromId(e.id)).toList());

    RequestType _requestType = _requestTypeMapper[formats];
    final List<AssetEntity> _assetList = await AssetPicker.pickAssets(
      Get.context,
      requestType: _requestType,
      selectedAssets: _lastSelection,
      textDelegate: EnglishTextDelegate(),
    );

    if (_assetList == null) return null;

    return _processAssetsList(_assetList, MediaSource.galery);
  }
}
