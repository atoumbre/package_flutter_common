// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:market_app_ower/theme/theme.dart';

// class FormFieldQuantity extends StatelessWidget {
//   FormFieldQuantity({
//     Key key,
//     @required this.initialValue,
//     @required this.name,
//     @required this.labelText,
//     @required this.valueTransformer,
//     @required this.hintText,
//   }) : super(key: key);

//   final String name;
//   final int initialValue;
//   final String labelText;
//   final dynamic Function(dynamic) valueTransformer;
//   final String hintText;

//   // final controller = ;

//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderTextField(
//       name: name,
//       initialValue: initialValue.toString(),
//       valueTransformer: valueTransformer,
//       textInputAction: TextInputAction.done,
//       decoration: getInputDecoration(labelText: labelText, hintText: hintText),
//       validator: FormBuilderValidators.compose([
//         FormBuilderValidators.required(context),
//         FormBuilderValidators.numeric(context),
//       ]),
//     );
//   }
// }
