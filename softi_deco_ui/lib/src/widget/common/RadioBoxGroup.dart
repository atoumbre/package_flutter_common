import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import 'DecoCard.dart';

class RadioBoxGroup extends StatefulWidget {
  final List<Widget> items;
  final Function(int) onTap;
  final int selected;

  RadioBoxGroup(this.items, {this.onTap, this.selected = 0});

  @override
  State createState() => _RadioBoxGroupState();
}

class _RadioBoxGroupState extends State<RadioBoxGroup> {
  int selected;

  @override
  Widget build(BuildContext context) {
    if (selected == null) {
      selected = this.widget.selected;
    }

    return Column(
      children: this.widget.items.map((item) {
        int index = this.widget.items.indexOf(item);

        return Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: DecoCard(
              onTap: () => setSelected(index),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  item,
                  Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: index == selected ? DecoColors.primary : DecoColors.secondary,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20.0, offset: Offset(0.0, 10.0))
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ));
      }).toList(),
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
