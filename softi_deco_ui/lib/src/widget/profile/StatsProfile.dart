import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import '../common/DecoCard.dart';

class StatsProfile extends StatelessWidget {
  final Map<String, int> stats;
  final bool clear;

  StatsProfile(this.stats, {this.clear: false});

  @override
  Widget build(BuildContext context) {
    List<Widget> content = [];

    // generate widget content
    stats.forEach((key, value) => content.add(Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(value.toString(), style: StatsProfileStyle.number),
            ),
            Text(key, style: StatsProfileStyle.text)
          ],
        )));

    var row = Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: content);

    return clear ? row : DecoCard(child: row);
  }
}
