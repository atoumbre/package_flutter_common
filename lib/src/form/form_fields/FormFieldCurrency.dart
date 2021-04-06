import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:hungerz_store/test.dart';

class FormFieldCurrency extends StatelessWidget {
  FormFieldCurrency({
    Key? key,
    required this.initialValue,
    required this.name,
    required this.decoration,
  }) : super(key: key);

  final String name;
  final dynamic initialValue;
  final InputDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: key,
      name: name,
      initialValue: initialValue,
      valueTransformer: (value) {
        return value == '' ? 0 : double.parse(value);
      },
      // keyboardType: TextInputType.number,
      // textInputAction: TextInputAction.done,
      decoration: decoration,
      // textDirection: TextDirection.rtl,
      inputFormatters: [
        // FilteringTextInputFormatter.allow(RegExp(r'^\d?\.?\d{0,1}'))
        // MoneyInputFormatter(
        //   thousandSeparator: ThousandSeparator.SpaceAndCommaMantissa,
        //   mantissaLength: 0,
        //   leadingSymbol: '',
        //   trailingSymbol: '',
        //   useSymbolPadding: true,
        //   // maxTextLength: 10,
        //   // onValueChange:
        // ),

        // CurrencyFormatter(decimal: 0), // decimalSeparator: ',', thousandSeparator: ' '),
        // MaskTextInputFormatter(mask: '### ### ### ### ###', initialText: 'QWE'),
        // CurrencyTextInputFormatter(decimalDigits: 0, symbol: '', locale: 'en'),
      ],
      validator: FormBuilderValidators.compose([
        // FormBuilderValidators.required(context),
        // FormBuilderValidators.numeric(context),
      ]),
    );
  }
}
