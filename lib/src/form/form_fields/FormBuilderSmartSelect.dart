// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:smart_select/smart_select.dart';

// class FormBuilderSmartSelect<T> extends FormBuilderField<T> {
//   // Custom field
//   final List<S2Choice> options;
//   final S2ModalConfig modalConfig;
//   final S2ChoiceConfig choiceConfig;

//   FormBuilderSmartSelect({
//     Key key,
//     // For super
//     @required String name,
//     FormFieldValidator<T> validator,
//     T initialValue,
//     InputDecoration decoration = const InputDecoration(),
//     ValueChanged<T> onChanged,
//     ValueTransformer<T> valueTransformer,
//     bool enabled = true,
//     FormFieldSetter<T> onSaved,
//     AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
//     VoidCallback onReset,
//     FocusNode focusNode,
//     // Custom field
//     @required this.options,
//     this.modalConfig = const S2ModalConfig(
//       title: 'Title',
//       type: S2ModalType.fullPage,
//     ),
//     this.choiceConfig = const S2ChoiceConfig(
//       type: S2ChoiceType.chips,
//     ),
//   }) : super(
//           key: key,
//           initialValue: initialValue,
//           name: name,
//           validator: validator,
//           valueTransformer: valueTransformer,
//           onChanged: onChanged,
//           autovalidateMode: autovalidateMode,
//           onSaved: onSaved,
//           enabled: enabled,
//           onReset: onReset,
//           decoration: decoration,
//           focusNode: focusNode,
//           builder: (FormFieldState<T> field) {
//             final state = field as _FormBuilderSmartSelectState<T>;

//             return SmartSelect<T>.single(
//               title: 'Categorie',
//               placeholder: '',
//               value: initialValue ?? state.value, // ['1', '4'],
//               onChange: (selected) {
//                 state.didChange(selected.value);
//               },
//               // value: ['1', '4'],
//               tileBuilder: (context, state) {
//                 return S2Tile.fromState(
//                   state,
//                   isTwoLine: true,
//                 );
//               },
//               modalValidation: validator,
//               modalConfirm: true,
//               modalFilter: true,
//               modalFilterAuto: true,
//               choiceDivider: true,

//               choiceItems: options,

//               modalConfig: modalConfig,
//               choiceConfig: choiceConfig,
//             );
//           },
//         );

//   @override
//   _FormBuilderSmartSelectState<T> createState() => _FormBuilderSmartSelectState<T>();
// }

// class _FormBuilderSmartSelectState<T> extends FormBuilderFieldState<FormBuilderSmartSelect<T>, T> {}
