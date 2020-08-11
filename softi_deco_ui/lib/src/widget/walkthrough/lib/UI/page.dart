import 'package:flutter/material.dart';
import './../Models/page_view_model.dart';

/// This is the class which contains the Page UI.
class WalkthroughPageBiss extends StatelessWidget {
  ///page details
  final PageViewModel pageViewModel;

  ///percent visible of page
  final double percentVisible;

  /// [MainAxisAligment]
  final MainAxisAlignment columnMainAxisAlignment;

  //Constructor
  WalkthroughPageBiss({
    this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // show background image if is set
      decoration: pageViewModel.backgroundImage != null
          ? BoxDecoration(image: DecorationImage(image: pageViewModel.backgroundImage, fit: BoxFit.cover))
          : null,

      // show color if there is no background image and if set
      color: pageViewModel.backgroundImage == null && pageViewModel.pageColor != null ? pageViewModel.pageColor : null,

      // padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Opacity(
        //Opacity is used to create fade in effect
        opacity: percentVisible,
        child: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait ? _buildPortraitPage(context) : __buildLandscapePage(context);
        }), //OrientationBuilder
      ),
    );
  }

  /// when device is Portrait place title, image and body in a column
  Widget _buildPortraitPage(BuildContext context) {
    return Column(
      children: <Widget>[
        // image
        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(top: 70.0),
            child: pageViewModel.mainImage,
          )),
        ),

        // text
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: DefaultTextStyle.merge(
                    style: pageViewModel.titleTextStyle,
                    child: pageViewModel.title,
                  ),
                ),
                DefaultTextStyle.merge(
                  style: pageViewModel.bodyTextStyle,
                  textAlign: TextAlign.center,
                  child: pageViewModel.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// if Device is Landscape reorder with row and column
  Widget __buildLandscapePage(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width / 2,
          child: Center(
            child: pageViewModel.mainImage,
          ),
        ),
        Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width / 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: DefaultTextStyle.merge(
                    style: pageViewModel.titleTextStyle,
                    child: pageViewModel.title,
                  ),
                ),
                DefaultTextStyle.merge(
                  style: pageViewModel.bodyTextStyle,
                  textAlign: TextAlign.center,
                  child: pageViewModel.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
