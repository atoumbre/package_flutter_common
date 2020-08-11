import 'package:flutter/material.dart';
import '../Models/page_bubble_view_model.dart';

/// This class contains the UI for page bubble.
class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  //Constructor
  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: 10.0,
          height: 10.0,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow ? Colors.transparent : viewModel.bubbleBackgroundColor,
            border: Border.all(
              color: viewModel.isHollow ? viewModel.bubbleBackgroundColor : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
