import 'package:flutter/widgets.dart';

class ListItemCreationAware extends StatefulWidget {
  final VoidCallback itemCreated;
  final Widget? child;
  const ListItemCreationAware({
    Key? key,
    required this.itemCreated,
    this.child,
  }) : super(key: key);

  @override
  _ListItemCreationAwareState createState() => _ListItemCreationAwareState();
}

class _ListItemCreationAwareState extends State<ListItemCreationAware> {
  @override
  void initState() {
    super.initState();
    // if (widget.itemCreated != null) {
    widget.itemCreated();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}

// class ListItemCreationAware extends StatelessWidget {
//   final Function itemCreated;
//   final Widget child;
//   const ListItemCreationAware({
//     Key key,
//     @required this.itemCreated,
//     this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetX(
//       initState: (state) {
//         if (itemCreated != null) itemCreated();
//       },
//       init: GetxController(),

//     );
//   }
// }
