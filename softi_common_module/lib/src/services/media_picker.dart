import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class MediaPicker extends IMediaPicker {
  final _requestTypeMapper = {
    {MediaType.audio}: RequestType.audio,
    {MediaType.video}: RequestType.video,
    {MediaType.image}: RequestType.image,
    {MediaType.image, MediaType.video}: RequestType.common,
    {MediaType.audio, MediaType.video, MediaType.image}: RequestType.all,
    {MediaType.audio, MediaType.video}: RequestType.video,
    {MediaType.audio, MediaType.image}: RequestType.image,
  };

  final _typeMap = {
    AssetType.image: MediaType.image,
    AssetType.video: MediaType.video,
    AssetType.audio: MediaType.audio
  };

  Future<List<FileMediaAsset>> _processAssetsList(
    List<AssetEntity> assets,
    MediaSource source,
  ) async {
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
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
  }) async {
    final _assetList = await CameraPicker.pickFromCamera(
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
  Future<List<FileMediaAsset>> selectMediaFromGallery({
    Set<MediaType> formats = const {MediaType.image, MediaType.video},
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

    return _processAssetsList(_assetList, MediaSource.galery);
  }
}
