import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:softi_core_module/softi_core_module.dart';

var _eventTypeMap = {
  StorageTaskEventType.failure: UploadEnventType.failure,
  StorageTaskEventType.success: UploadEnventType.success,
  StorageTaskEventType.pause: UploadEnventType.pause,
  StorageTaskEventType.resume: UploadEnventType.resume,
  StorageTaskEventType.progress: UploadEnventType.progress,
};

class FirebaseStorageService extends IRemoteStorageService {
  Stream<UploadEvent> uploadImage({
    @required dynamic imageToUpload,
    @required String title,
    bool addTimestamp = false,
    bool isFile = false,
  }) {
    print('Start up load');

    String imageFileName = title + (addTimestamp ? DateTime.now().millisecondsSinceEpoch.toString() : '');

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = isFile
        ? firebaseStorageRef.putFile(imageToUpload as File)
        : firebaseStorageRef.putData(imageToUpload as Uint8List);

    return uploadTask.events.asyncMap<UploadEvent>((event) async {
      // event.snapshot.
      return UploadEvent(
          type: _eventTypeMap[event.type],
          total: event.snapshot.totalByteCount.toDouble(),
          uploaded: event.snapshot.bytesTransferred.toDouble(),
          rawrResult: event.type == StorageTaskEventType.success ? event.snapshot : null,
          result: event.type != StorageTaskEventType.success
              ? null
              : NetworkMediaAsset(
                  url: (await event.snapshot.ref.getDownloadURL()).toString(),
                  title: event.snapshot.storageMetadata.path,
                ));
    });

    // StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    // var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    // if (uploadTask.isComplete) {
    //   var url = downloadUrl.toString();
    //   return NetworkMediaAsset(
    //     url: url,
    //     title: storageSnapshot.storageMetadata.path,
    //   );
    // }

    // return null;
  }

  Future deleteImage(String imageFileName) async {
    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
