import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:softi_core_module/softi_core_module.dart';

class FirebaseStorageService extends IRemoteStorageService {
  Future<NetworkMediaAsset> uploadImage({
    @required dynamic imageToUpload,
    @required String title,
    bool addTimestamp = false,
    bool isFile = false,
  }) async {
    print('Start up load');

    String imageFileName = title + (addTimestamp ? DateTime.now().millisecondsSinceEpoch.toString() : '');

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = isFile
        ? firebaseStorageRef.putFile(imageToUpload as File)
        : firebaseStorageRef.putData(imageToUpload as Uint8List);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return NetworkMediaAsset(
        url: url,
        title: storageSnapshot.storageMetadata.path,
      );
    }

    return null;
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
