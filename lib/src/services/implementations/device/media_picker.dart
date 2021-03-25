import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softi_common/src/services/class/i_media_asset.dart';
import 'package:softi_common/src/services/interfaces/device/i_media_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaPicker extends IMediaPicker {
  final _requestTypeMapper = <Set<MediaFormat>, RequestType>{
    {MediaFormat.audio}: RequestType.audio,
    {MediaFormat.video}: RequestType.video,
    {MediaFormat.image}: RequestType.image,
    {MediaFormat.image, MediaFormat.video}: RequestType.common,
    {MediaFormat.audio, MediaFormat.video, MediaFormat.image}: RequestType.all,
    {MediaFormat.audio, MediaFormat.video}: RequestType.video,
    {MediaFormat.audio, MediaFormat.image}: RequestType.image,
  };

  final _typeMap = <AssetType, MediaFormat>{
    AssetType.image: MediaFormat.image,
    AssetType.video: MediaFormat.video,
    AssetType.audio: MediaFormat.audio
  };

  final _pickerSourceMap = <PickerSource, ImageSource>{
    PickerSource.camera: ImageSource.camera,
    PickerSource.gallery: ImageSource.gallery,
    PickerSource.file: ImageSource.gallery
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

  // @override
  // Future<List<FileMediaAsset>> selectMediaFromCamera({
  //   Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
  // }) async {
  //   final _assetList = await CameraPicker.pickFromCamera(
  //     Get.context,
  //     isOnlyAllowRecording: !formats.contains(MediaFormat.image),
  //     isAllowRecording: formats.contains(MediaFormat.video),
  //     resolutionPreset: ResolutionPreset.medium,
  //     textDelegate: EnglishCameraPickerTextDelegate(),
  //   );

  //   if (_assetList == null) return null;

  //   return _processAssetsList([_assetList]);
  // }

  @override
  Future<List<FileMediaAsset>> selectMediaFromGallery({
    Set<MediaFormat> formats = const {MediaFormat.image, MediaFormat.video},
    List<FileMediaAsset> selectedItemId = const [],
    int maxItem = 1,
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

  @override
  Future<File> singleImageSelect({PickerSource source = PickerSource.gallery, bool crop}) async {
    final _picker = ImagePicker();

    File response;

    final _picked = await _picker.getImage(source: _pickerSourceMap[source]);
    if (_picked != null) {
      response = File(_picked.path);
      response = crop ? await _cropImage(response) : response;
    }

    return response;
  }

  Future<File> _cropImage(imageFile) async {
    var croppedFile = await ImageCropper.cropImage(
        maxWidth: 640,
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    return croppedFile;
    // if (croppedFile != null) {
    //   imageFile = croppedFile;
    //   setState(() {
    //     state = AppState.cropped;
    //   });
    // }
  }
}
