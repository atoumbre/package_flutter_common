import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import '../common/DecoCard.dart';

class DecoRangeSlider extends StatefulWidget {
  final double min;
  final double max;
  final double lowerValue;
  final double upperValue;
  final String prefix;
  final bool showValueIndicator;
  final Color overlayColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final Color valueIndicatorColor;
  final Function(double, double) onChanged;
  final Function(double, double) onChangeStart;
  final Function(double, double) onChangeEnd;

  DecoRangeSlider({
    this.min = 0,
    this.max = 100,
    this.lowerValue = 10,
    this.upperValue = 90,
    this.prefix,
    this.showValueIndicator = false,
    this.overlayColor,
    this.activeTrackColor = DecoColors.primary,
    this.inactiveTrackColor = const Color(0xFFE6E9ED),
    this.thumbColor = DecoColors.primary,
    this.valueIndicatorColor = DecoColors.primary,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  });

  @override
  State createState() => _DecoRangeSliderState();
}

class _DecoRangeSliderState extends State<DecoRangeSlider> {
  RangeValues _values;
  double min;
  double max;
  double lowerValue;
  double upperValue;

  @override
  void initState() {
    super.initState();

    if (min == null) {
      min = this.widget.min;
    }

    if (max == null) {
      max = this.widget.max;
    }

    if (lowerValue == null) {
      lowerValue = this.widget.lowerValue;
    }

    if (upperValue == null) {
      upperValue = this.widget.upperValue;
    }

    _values = RangeValues(lowerValue, upperValue);
  }

  @override
  Widget build(BuildContext context) {
    // set overlay color
    var overlayColor = DecoColors.primary.withOpacity(0.2);
    if (widget.overlayColor != null) {
      overlayColor = widget.overlayColor;
    }

    return DecoCard(
        child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                this.widget.prefix.toString() + lowerValue.toString(),
                style: DecoRangeSliderStyle.label,
              ),
            ),
            Container(
              child: Text(
                this.widget.prefix.toString() + upperValue.toString(),
                style: DecoRangeSliderStyle.label,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  overlayColor: overlayColor,
                  activeTrackColor: this.widget.activeTrackColor,
                  inactiveTrackColor: this.widget.inactiveTrackColor,
                  thumbColor: this.widget.thumbColor,
                  valueIndicatorColor: this.widget.valueIndicatorColor,
                  showValueIndicator:
                      this.widget.showValueIndicator ? ShowValueIndicator.always : ShowValueIndicator.onlyForDiscrete,
                ),
                child: RangeSlider(
                  values: _values,
                  min: min,
                  max: max,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _values = values;

                      lowerValue = values.start.ceilToDouble();
                      upperValue = values.end.ceilToDouble();
                    });

                    if (this.widget.onChanged != null) {
                      this.widget.onChanged(values.start, values.end);
                    }
                  },
                  onChangeStart: (RangeValues values) {
                    if (this.widget.onChangeStart != null) {
                      this.widget.onChangeStart(values.start, values.end);
                    }
                  },
                  onChangeEnd: (RangeValues values) {
                    if (this.widget.onChangeEnd != null) {
                      this.widget.onChangeEnd(values.start, values.end);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
