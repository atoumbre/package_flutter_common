import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';

class SizePicker extends StatefulWidget {
  final List<String> sizes;
  final Function(int) onTap;
  final int selected;

  SizePicker(this.sizes, {this.selected = 0, this.onTap});

  @override
  State createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  int selected;

  @override
  Widget build(BuildContext context) {
    if (selected == null) {
      selected = this.widget.selected;
    }

    return Wrap(
        alignment: WrapAlignment.center,
        children: this.widget.sizes.map((size) {
          int index = this.widget.sizes.indexOf(size);

          return Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: index == selected ? DecoColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(35.0),
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20.0, offset: Offset(0.0, 10.0))
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 6.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () => setSelected(index),
                  borderRadius: BorderRadius.circular(35.0),
                  child: Center(
                    child: Text(size, style: index == selected ? SizePickerStyle.titleActive : SizePickerStyle.title),
                  )),
            ),
          );
        }).toList());
  }

  void setSelected(int index) {
    setState(() {
      selected = index;
    });

    if (this.widget.onTap != null) {
      this.widget.onTap(index);
    }
  }
}
