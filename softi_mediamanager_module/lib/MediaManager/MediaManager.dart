import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:softi_common_module/index.dart';
import 'package:softi_mediamanager_module/MediaManager/BaseForm.dart';
import 'package:softi_mediamanager_module/MediaManager/MediaManagerController.dart';
import 'package:softi_mediamanager_module/MediaManager/widgets/GalleryItemWidget.dart';

class MediaManager extends StatelessWidget {
  final List<NetworkMediaAsset> gallery;
  final int maxImageNumber;
  final String Function(String) fileTitleBuilder;

  MediaManagerController get con => Get.find();
  // MediaManagerController con = Get.put();

  MediaManager({
    @required this.gallery,
    @required this.maxImageNumber,
    @required this.fileTitleBuilder,
    Key key,
  }) {
    Get.put(MediaManagerController(
      gallery: gallery,
      maxImageNumber: maxImageNumber,
      fileTitleBuilder: fileTitleBuilder,
    ));
  }

  final imageColumn = 2.obs;
  double imageSize(double canvasWidth, int column) => (canvasWidth - column * 8 - 8) / column;

  @override
  Widget build(BuildContext context) {
    // Widget body =

    return FormBasePage<List<NetworkMediaAsset>>(
      onSubmit: () async {
        var g = await con.updatedGallery;
        Get.back<List<NetworkMediaAsset>>(result: g);
        return g;
      },
      title: 'Media Manager',
      child: Obx(() => Column(
            children: [
              if (con.uploading)
                LinearProgressIndicator(
                  minHeight: 5,
                  value: con.progress,
                ),
              Row(children: [
                Expanded(
                  child: ObxValue(
                    (_imageColumn) => Slider(
                      value: (_imageColumn() as int).toDouble(),
                      onChanged: (double value) {
                        print(value);
                        return _imageColumn(value.toInt());
                      },
                      divisions: 3,
                      min: 1.0, //Helpers.sizing.safeWidth / 5,
                      max: 4.0, //Helpers.sizing.safeWidth - 25,
                    ),
                    imageColumn,
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(FontAwesomeIcons.fileImage),
                  color: Get.theme.accentColor,
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => con.addPictureFromGallery(),
                ),
                IconButton(
                  iconSize: 32,
                  icon: Icon(FontAwesomeIcons.cameraRetro),
                  color: Get.theme.accentColor,
                  padding: const EdgeInsets.all(0.0),
                  onPressed: () => con.addPictureFromCamera(),
                ),
                // IconButton(
                //   iconSize: 32,
                //   icon: Icon(FontAwesomeIcons.upload),
                //   color: CoreState.app.theme.accentColor,
                //   padding: const EdgeInsets.all(0.0),
                //   onPressed: () => con.uploadImages(),
                // )
              ]),
              Expanded(child: ResponsiveBuilder(
                builder: (__, _) {
                  //  Dev.logger.d();

                  // int _i = 4;
                  // imageSize((_.localWidgetSize.width - _i * 8 - 8) / _i);

                  return Obx(
                    () => ReorderableWrap(
                      needsLongPressDraggable: true,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      padding: const EdgeInsets.all(8),
                      children: con.mediaAssetList
                          .map<Widget>(
                            (galeryItem) => ObxValue(
                              (_imageSize) => GalleryItemWidget(
                                galeryItem,
                                con: con,
                                size: imageSize(_.localWidgetSize.width, _imageSize.value),
                              ),
                              imageColumn,
                            ),
                          )
                          .toList(),
                      onReorder: con.onReorder,
                      onNoReorder: (int index) {
                        //this callback is optional
                        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                      },
                      onReorderStarted: (int index) {
                        //this callback is optional
                        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                      },
                    ),
                  );
                },
              ))
            ],
          )),

      // onDimissed: () => Get.delete<MediaManagerController>(),
      isBusy: con.busy.value,
    );
  }
}
