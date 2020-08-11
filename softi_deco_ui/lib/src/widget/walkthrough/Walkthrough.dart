import 'package:flutter/material.dart';
import 'package:softi_deco_ui/src/models.dart';
import 'package:softi_deco_ui/src/styles.dart';

import './lib/Models/page_view_model.dart';
import './lib/intro_views_flutter.dart';

class Walkthrough extends StatelessWidget {
  final List<WalkthroughModel> pages;
  final VoidCallback onDoneTap;
  final bool showSkipButton;
  final TextStyle pageButtonTextStyles;
  final double pageButtonTextSize;
  final String pageButtonFontFamily;
  final String doneText;
  final String skipText;
  final bool doneButtonPersist;
  final double mainImageSize;

  Walkthrough(
      {this.pages,
      this.onDoneTap,
      this.showSkipButton = true,
      this.pageButtonTextStyles,
      this.pageButtonTextSize = 12.0,
      this.pageButtonFontFamily = 'Roboto',
      this.doneText = 'DONE',
      this.skipText = 'SKIP',
      this.doneButtonPersist = false,
      this.mainImageSize = 200.0});

  @override
  Widget build(BuildContext contect) {
    List<PageViewModel> slides = [];

    for (var i = 0; i < pages.length; i++) {
      slides.add(PageViewModel(
          title: Text(pages[i].title, style: WalkthroughStyle.title),
          body: Text(pages[i].description, style: WalkthroughStyle.description),
          backgroundImage: pages[i].backgroundImage,
          mainImage: ClipRRect(
            borderRadius: BorderRadius.circular(mainImageSize / 2),
            child: Image(
              image: pages[i].mainImage,
              width: mainImageSize,
              height: mainImageSize,
              fit: BoxFit.fill,
            ),
          )));
    }

    return IntroViewsFlutter(slides,
        onTapDoneButton: onDoneTap,
        showSkipButton: showSkipButton,
        pageButtonTextStyles: pageButtonTextStyles,
        pageButtonTextSize: pageButtonTextSize,
        pageButtonFontFamily: pageButtonFontFamily,
        doneText: Text(doneText),
        skipText: Text(skipText),
        doneButtonPersist: doneButtonPersist);
  }
}
