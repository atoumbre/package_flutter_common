import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:secure_random/secure_random.dart';
import 'package:softi_common_module/index.dart';
import 'package:softi_core_module/index.dart';

class MediaManagerItem {
  NetworkMediaAsset asset;
  MediaAsset tempAsset;

  UploadState uploadState;

  double uploaded;
  double fileSize;
  bool isUploading;

  MediaManagerItem({this.asset, this.tempAsset});
}

class MediaManagerController extends BaseController {
  final List<NetworkMediaAsset> gallery;
  final int maxImageNumber;
  final String Function(String) fileTitleBuilder;

  // int _maxImageNumber;
  // String _remoteGalleryFolder;

  RxBool _uploding = false.obs;
  RxDouble _currentUploadSize = 0.0.obs;
  RxDouble _currentTransferredBytes = 0.0.obs;
  RxList<MediaManagerItem> mediaAssetList = List<MediaManagerItem>().obs;

  final int maxImageWidth;

  MediaManagerController({this.gallery, this.maxImageNumber, this.maxImageWidth, this.fileTitleBuilder}) {
    // _maxImageNumber = maxImageNumber;
    // _remoteGalleryFolder = remoteGalleryFolder;
    mediaAssetList.assignAll([]);
    if (gallery != null) {
      List<MediaManagerItem> _itemList = gallery
          .map((mediaAsset) => MediaManagerItem(
                asset: mediaAsset,
              ))
          .toList();
      mediaAssetList.assignAll(_itemList);
    }
  }

  Future<List<NetworkMediaAsset>> get updatedGallery async {
    await uploadImages();
    return mediaAssetList
        // .map((galeryItem) => galeryItem.newAsset = galeryItem.newAsset ?? galeryItem.asset)
        .map((galeryItem) => galeryItem.asset)
        .where((element) => element != null)
        .toList();
  }

  bool get uploading => _uploding();
  double get progress => _currentUploadSize() == 0.0 ? 0.0 : _currentTransferredBytes() / _currentUploadSize();

  // init({
  //   @required List<NetworkMediaAsset> gallery,
  //   @required int maxImageNumber,
  //   @required String remoteGalleryFolder,
  // }) {
  //   _maxImageNumber = maxImageNumber;
  //   _remoteGalleryFolder = remoteGalleryFolder;
  //   mediaAssetList.assignAll([]);
  //   if (gallery != null) {
  //     List<MediaManagerItem> _itemList = gallery
  //         .map((mediaAsset) => MediaManagerItem(
  //               asset: mediaAsset,
  //             ))
  //         .toList();
  //     mediaAssetList.assignAll(_itemList);
  //     // } else {
  //     //   mediaAssetList.addAll([]);
  //   }
  // }

  void onReorder(int oldIndex, int newIndex) {
    final item = mediaAssetList.removeAt(oldIndex);
    mediaAssetList.insert(newIndex, item);
  }

  void deleteIndex(MediaManagerItem galeryItem) {
    mediaAssetList.remove(galeryItem);
  }

  void addPictureFromGallery() async {
    if (maxImageNumber - mediaAssetList.length <= 0) {
      loading.showToast(
        'ou can not dd more then $maxImageNumber images',
      );
      return;
    }
    var _list = await mediaPicker.selectMediaFromGallery(
      // selectedItemId: selectedItemList,
      maxItem: maxImageNumber - mediaAssetList.length,
    );
    if (_list != null) {
      mediaAssetList.addAll(_list.map((e) => MediaManagerItem(tempAsset: e)));
    }
  }

  void addPictureFromCamera() async {
    var _list = await mediaPicker.selectMediaFromCamera();
    if (_list != null) mediaAssetList.addAll(_list.map((e) => MediaManagerItem(tempAsset: e)));
  }

// image upload pipeline

  FutureOr<Uint8List> _compressImage(media) {
    // Image compression
    if (media is FileMediaAsset)
      return FlutterImageCompress.compressWithFile(
        media.file.absolute.path,
        minHeight: maxImageWidth,
        minWidth: maxImageWidth,
      );

    if (media is MemoryMediaAsset)
      return FlutterImageCompress.compressWithList(
        media.data,
        minHeight: maxImageWidth,
        minWidth: maxImageWidth,
      );

    return null;
  }

  Stream<UploadEvent> _uploadImage(Uint8List data, String path) {
    // _currentUploadSize += data.length;
    // Start upload process and get the upload event streams
    return cloudStorage //
        .uploadMedia(
      imageToUpload: data,
      title: path,
      isFile: false,
    );
  }

  bool _handleUploadEvent(MediaManagerItem item, UploadEvent value) {
    bool _uplaodCompleted;

    item.uploadState = value.type;

    if (item.fileSize == 0) {
      _currentUploadSize += value.total;
      item.fileSize = value.total;
      print('Total Size ' + _currentUploadSize.toString());
    }

    item.uploadState = value.type;
    _currentTransferredBytes += (value.uploaded - item.uploaded);
    item.uploaded = value.uploaded;

    if (value.type == UploadState.progress) {
      //
      _uplaodCompleted = false;
    } else if (value.type == UploadState.success) {
      //
      item.asset = value.result;
      _uplaodCompleted = true;
    } else {
      //
      _uplaodCompleted = true;
    }

    print(_currentTransferredBytes().toString() + ' / ' + _currentUploadSize().toString());

    mediaAssetList.refresh();
    _currentTransferredBytes.refresh();
    return _uplaodCompleted;
  }

  Future<bool> uploadImages() async {
    List<Stream<bool>> tasks = [];
    SecureRandom secureRandom = SecureRandom();
    _uploding(true);
    _currentUploadSize(0);
    _currentTransferredBytes(0);

    // Create upload tasks asynchronously
    tasks = await Future.wait(
      mediaAssetList //
          .where((mediaItem) => !(mediaItem.asset is NetworkMediaAsset)) //
          .map(
        (mediaItem) async {
          // Toggle update state for the ui
          mediaItem.fileSize = 0;
          mediaItem.uploaded = 0;
          mediaItem.uploadState = UploadState.progress;
          mediaAssetList.refresh();

          // build remote path
          String imageTitle = fileTitleBuilder(secureRandom.nextInt(max: 10000).toString());
          //'$remoteGalleryFolder/${secureRandom.nextInt(max: 10000)}';

          // Get upload stream for each file
          Stream<UploadEvent> uploadEventStream = await Stream.value(mediaItem.tempAsset) //
              .asyncMap<Uint8List>((media) => _compressImage(media))
              .map<Stream<UploadEvent>>((Uint8List data) => _uploadImage(data, imageTitle))
              .first;

          // Map upload stream to get a upload completed boolean stream
          return uploadEventStream.map<bool>((uploadEvent) {
            return _handleUploadEvent(mediaItem, uploadEvent);
          });
        },
      ),
    );

    Completer<bool> _uploadCompleter = Completer<bool>();

    if (tasks.length == 0) _uploadCompleter.complete(true);

    CombineLatestStream.list<bool>(tasks).listen(
      (taskStateList) {
        print(taskStateList);
        var taskCompleted = taskStateList.reduce((taskState1, taskState2) => taskState1 && taskState2);
        if (taskCompleted) {
          _uploding(false);
          _uploadCompleter.complete(true);
        }
      },
      onError: print,
      onDone: () => print('Done!!!'),
    );

    _uploadCompleter.future.then((result) {
      print('Upload Completed : $result');
    });

    return _uploadCompleter.future;
  }
}
