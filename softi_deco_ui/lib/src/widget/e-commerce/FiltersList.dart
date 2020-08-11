import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/styles.dart';
import '../common/DecoCard.dart';

class FiltersList extends StatelessWidget {
  final List<String> categories;
  final Function(String) onTap;

  FiltersList(this.categories, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return DecoCard(
      padding: 0,
      child: Column(
          children: categories
              .map((category) => Material(
                    child: InkWell(
                      onTap: () => onTap(category),
                      child: Container(
                          height: 48.0,
                          decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFE6E9ED)))),
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(category, style: FiltersListStyle.title),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                                color: DecoColors.textLight,
                              )
                            ],
                          )),
                    ),
                  ))
              .toList()),
    );
  }
}
