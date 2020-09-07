import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softi_deco_ui/src/form_fields/common.dart';

class DecoFormImagePicker extends StatelessWidget {
  //! Parameters for Labels
  final String hintText;
  final String labelText;
  final String helperText;

  // From Super

  final bool readOnly;
  final FocusNode focusNode;
  final String name;
  final ValueChanged onChanged;
  final ValueTransformer valueTransformer;
  final VoidCallback onReset;
  final FormFieldValidator validator;
  final List<dynamic> initialValue;
  final bool enabled;
  final FormFieldSetter onSaved;
  final bool autovalidate;

  // Other fields

  final CameraDevice preferredCameraDevice;
  final Color iconColor;
  final double maxHeight;
  final double maxWidth;
  final double previewHeight;
  final double previewWidth;
  final EdgeInsets bottomSheetPadding;
  final EdgeInsets previewMargin;
  final Function(Image) onImage;
  final int imageQuality;
  final int maxImages;
  final Widget cameraIcon;
  final Widget cameraLabel;
  final Widget galleryIcon;
  final Widget galleryLabel;

  DecoFormImagePicker({
    Key key,
    //!   Labels fields
    this.helperText,
    this.hintText,
    this.labelText,
    // From Super
    this.name,
    this.validator,
    this.initialValue,
    this.readOnly = false,
    this.onChanged,
    this.valueTransformer,
    this.enabled = true,
    this.onSaved,
    this.autovalidate = false,
    this.onReset,
    this.focusNode,
    // Other fields
    this.previewWidth = 130,
    this.previewHeight = 130,
    this.previewMargin,
    this.iconColor,
    this.maxHeight,
    this.maxWidth,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.onImage,
    this.maxImages,
    this.cameraIcon = const Icon(Icons.camera_enhance),
    this.galleryIcon = const Icon(Icons.image),
    this.cameraLabel = const Text('Camera'),
    this.galleryLabel = const Text('Gallery'),
    this.bottomSheetPadding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return DecoFormFieldDecorator(
      child: FormBuilderImagePicker(
        key: key,
        decoration: decoDecoration(
          labelText: labelText,
          hintText: hintText,
          helperText: helperText,
        ),
        // From Supper
        initialValue: initialValue,
        name: name,
        validator: validator,
        valueTransformer: valueTransformer,
        onChanged: onChanged,
        readOnly: readOnly,
        autovalidate: autovalidate,
        onSaved: onSaved,
        enabled: enabled,
        onReset: onReset,
        focusNode: focusNode,
        // Other fields
        preferredCameraDevice: preferredCameraDevice,
        iconColor: iconColor,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        previewHeight: previewHeight,
        previewWidth: previewWidth,
        bottomSheetPadding: bottomSheetPadding,
        previewMargin: previewMargin,
        onImage: onImage,
        imageQuality: imageQuality,
        maxImages: maxImages,
        cameraIcon: cameraIcon,
        cameraLabel: cameraLabel,
        galleryIcon: galleryIcon,
        galleryLabel: galleryLabel,
      ),
    );
  }
}
