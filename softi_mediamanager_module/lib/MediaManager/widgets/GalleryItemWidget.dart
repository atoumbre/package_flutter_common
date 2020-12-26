import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:softi_common_module/index.dart';
import 'package:softi_mediamanager_module/MediaManager/MediaManagerController.dart';
import 'package:softi_mediamanager_module/MediaManager/widgets/PhotoViewer.dart';

class GalleryItemWidget extends StatelessWidget {
  final MediaManagerItem galeryItem;
  final double size;

  final String profileImagePlacehoder;

  GalleryItemWidget(
    this.galeryItem, {
    this.size = 90,
    this.profileImagePlacehoder,
    @required this.con,
    Key key,
  }) : super(key: key);

  final MediaManagerController con; //= Get.find<MediaManagerController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        PhotoViewPage(image: _getImageProvider(galeryItem.asset)),
      ),
      child: Stack(children: [
        _getImageWidget(galeryItem.asset ?? galeryItem.tempAsset),
        if (galeryItem.uploadState != UploadState.progress)
          Positioned(
              top: 6,
              left: 6,
              child: InkWell(
                  onTap: () => con.deleteIndex(galeryItem),
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.amber,
                    size: 22,
                  ))),
        if (galeryItem.uploadState == UploadState.progress)
          Container(
            height: size,
            width: size,
            color: Colors.grey.withOpacity(0.5),
            alignment: Alignment.center,
            child: SpinKitPulse(
              color: Colors.white,
            ),
            //   value: galeryItem.progress ?? 0.0,
            //   minHeight: 8.0,
            // ),
          ),
      ]),
    );
  }

  ImageProvider _getImageProvider(MediaAsset asset) {
    if (asset is FileMediaAsset)
      return ExtendedFileImageProvider(
        asset.file,
      );

    if (asset is NetworkMediaAsset)
      return ExtendedNetworkImageProvider(
        asset.url,
      );

    if (asset is MemoryMediaAsset)
      return ExtendedMemoryImageProvider(
        asset.data,
      );

    return null;
  }

  Widget _getImageWidget(MediaAsset asset) {
    // Dev.logger.d(galeryItem?.progress?.toString() ?? '');
    if (asset is FileMediaAsset)
      return ExtendedImage.file(
        asset.file,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );

    if (asset is NetworkMediaAsset)
      return CachedNetworkImage(
        imageUrl: asset.url ?? profileImagePlacehoder,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );

    if (asset is MemoryMediaAsset)
      return ExtendedImage.memory(
        asset.data,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    return Container();
  }
}
