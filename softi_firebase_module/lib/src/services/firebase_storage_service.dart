import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:softi_core_module/softi_core_module.dart';

class FirebaseStorageService implements IRemoteStorage {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
    bool addTimestamp = false,
  }) async {
    String imageFileName = title + (addTimestamp ? DateTime.now().millisecondsSinceEpoch.toString() : '');

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    StorageTaskSnapshot storageSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
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
