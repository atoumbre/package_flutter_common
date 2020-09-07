// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:softi_deco_ui/src/form_fields/common.dart';

// class DecoFormCheckboxList extends StatelessWidget {
//   //! Parameters for Labels
//   final String hintText;
//   final String labelText;
//   final String helperText;

//   // From Super

//   final bool readOnly;
//   final FocusNode focusNode;
//   final String name;
//   final ValueChanged onChanged;
//   final ValueTransformer valueTransformer;
//   final VoidCallback onReset;
//   final FormFieldValidator validator;
//   final List<dynamic> initialValue;
//   final bool enabled;
//   final FormFieldSetter onSaved;
//   final bool autovalidate;

//   // Other fields

//   DecoFormCheckboxList({
//     Key key,
//     //!   Labels fields
//     this.helperText,
//     this.hintText,
//     this.labelText,
//     // From Super
//     this.name,
//     this.validator,
//     this.initialValue,
//     this.readOnly = false,
//     this.onChanged,
//     this.valueTransformer,
//     this.enabled = true,
//     this.onSaved,
//     this.autovalidate = false,
//     this.onReset,
//     this.focusNode,
//     // Other fields
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DecoFormFieldDecorator(
//       child: FormBuilderCheckboxGroup(
//         key: key,
//         decoration: decoDecoration(
//           labelText: labelText,
//           hintText: hintText,
//           helperText: helperText,
//         ),
//         // From Supper
//         initialValue: initialValue,
//         name: name,
//         validator: validator,
//         valueTransformer: valueTransformer,
//         onChanged: onChanged,
//         readOnly: readOnly,
//         autovalidate: autovalidate,
//         onSaved: onSaved,
//         enabled: enabled,
//         onReset: onReset,
//         focusNode: focusNode,
//         // Other fields
//       ),
//     );
//   }
// }
