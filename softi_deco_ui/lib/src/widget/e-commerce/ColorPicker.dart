import 'package:flutter/material.dart';

class ColorPicker extends StatefulWidget {
  final List<Color> colors;
  final Function(int) onTap;
  final int selected;

  ColorPicker(
    this.colors,
    {
      this.selected = 0,
      this.onTap
    }
  );

  @override
  State createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selected;

  @override
  Widget build(BuildContext context) {
    if (selected == null) {
      selected = this.widget.selected;
    }

    return Wrap(
      alignment: WrapAlignment.center,
      children: this.widget.colors.map((color) {
        int index = this.widget.colors.indexOf(color);

        return Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20.0,
                offset: Offset(0.0, 10.0)
              )
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 6.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => setSelected(index),
              borderRadius: BorderRadius.circular(16.0),
              child: Center(
                child: selected == index ? Icon(
                  Icons.check,
                  color: Colors.white,
                ): Container()
              )
            ),
          ),
        );
      }).toList()
    );
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
