import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FormBasePage<T> extends StatelessWidget {
  final Widget child;
  final String title;
  final Future<T> Function() onSubmit;
  final void Function() onDimissed;
  final bool isBusy;

  FormBasePage({
    Key key,
    @required this.child,
    @required this.title,
    @required this.onSubmit,
    @required this.isBusy,
    this.onDimissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () => Navigator.of(context).pop(),
      //     icon: Icon(MdiIcons.chevronLeft),
      //   ),
      //   title: Text(title, style: Theme.of(context).textTheme.headline6),
      // ),
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: onDimissed != null ? () => onDimissed() : () => Get.back(result: null),
          icon: Icon(FontAwesomeIcons.chevronLeft),
        ),
        title: Text(
          'Translated.editProfile',
          style: TextStyle(fontSize: 16.7),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: child,
      ),
      bottomNavigationBar: BottomBar(
        text: 'Translated.updateInfo',
        onTap: isBusy ? null : () async => await onSubmit(),
      ),
    );
  }
}
//  Row(
// children: [
// Expanded(
//   flex: 1,
//   child: FlatButton(
//     onPressed: isBusy
//         ? null
//         : onDimissed != null
//             ? () => onDimissed()
//             : () => Get.back(result: null),
//     padding: EdgeInsets.symmetric(vertical: 14),
//     color: Colors.transparent,
//     shape: StadiumBorder(),
//     child: Text(
//       'Annuler',
//       textAlign: TextAlign.start,
//       style: TextStyle(color: Theme.of(context).accentColor),
//     ),
//   ),
// ),
// SizedBox(width: 24),
// Expanded(
//   flex: 3,
//   child: FlatButton(
//     onPressed: isBusy ? null : () async => Get.back(result: await onSubmit()),
//     padding: EdgeInsets.symmetric(vertical: 14),
//     color: Theme.of(context).accentColor,
//     shape: StadiumBorder(),
//     child: Text(
//       'Valider',
//       textAlign: TextAlign.start,
//       style: TextStyle(color: Theme.of(context).primaryColor),
//     ),
//   ),

// FlatButton(
//   onPressed: isBusy ? null : () async => await onSubmit(),
//   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//   color: themeData.primaryColor,
//   splashColor: Colors.white,
//   highlightColor: themeData.primaryColor,
//   child: Text(
//     "Valider",
//     style: AppTheme.getTextStyle(themeData.textTheme.bodyText2, fontWeight: 600)
//         .merge(TextStyle(color: themeData.colorScheme.onPrimary)),
//   ),
//   padding: EdgeInsets.only(top: 12, bottom: 12),
// ),
// ),

// ],
// ),
