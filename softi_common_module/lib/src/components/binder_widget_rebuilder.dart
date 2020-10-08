// library architecture;

// import 'package:flutter/material.dart';
// import 'package:states_rebuilder/states_rebuilder.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// abstract class BinderWidget<T> extends StatelessWidget {
//   const BinderWidget({Key key}) : super(key: key);

//   Widget builder(T state, ReactiveModel<T> model);

//   T controller();

//   void ready(ReactiveModel<T> model) {
//     return null;
//   }

//   void dispose(ReactiveModel<T> model) {
//     return null;
//   }

//   List<StatesRebuilder> get observe => [];

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<T>(
//       builder: builder,
//       model: () => RM.create<T>(controller()),
//       observe: observe,
//       ready: ready,
//       dispose: dispose,
//     );
//   }
// }

// class ViewModelBuilder<T> extends StatelessWidget {
//   ViewModelBuilder({
//     this.model,
//     this.builder,
//     this.ready,
//     this.dispose,
//     this.observe = const [],
//   }) : withHook = true;

//   final List<dynamic> observe;
//   final ReactiveModel<T> Function() model;
//   final Widget Function(T, ReactiveModel<T>) builder;
//   final Function(ReactiveModel<T>) ready;
//   final void Function(ReactiveModel<T>) dispose;
//   final bool withHook;

//   ViewModelBuilder.withHook({
//     this.model,
//     this.builder,
//     this.ready,
//     this.dispose,
//     this.observe = const [],
//   }) : withHook = true;

//   @override
//   Widget build(BuildContext context) {
//     return StateBuilder<T>(
//       observe: model,
//       observeMany: observe
//           .map((rm) => rm is ReactiveModel Function() // return
//               ? rm
//               : rm is ReactiveModel //
//                   ? () => rm
//                   : null)
//           .where((rm) => rm != null)
//           .toList(),
//       initState: (_, model) {
//         if (ready != null) ready(model);
//       },
//       builder: (_, model) {
//         return withHook
//             ? _BuilderChildWithHook<T>(builder: builder, model: model)
//             : _BuilderChild<T>(builder: builder, model: model);
//       },
//       dispose: (_, model) => dispose(model),
//       disposeModels: true,
//     );
//   }
// }

// // ignore: unused_element
// class _BuilderChild<T> extends StatelessWidget {
//   _BuilderChild({this.builder, this.model});

//   final Widget Function(T, ReactiveModel<T>) builder;
//   final ReactiveModel<T> model;

//   @override
//   Widget build(BuildContext context) => builder(model.state, model);
// }

// // ignore: unused_element
// class _BuilderChildWithHook<T> extends HookWidget {
//   _BuilderChildWithHook({this.builder, this.model});

//   final Widget Function(T, ReactiveModel<T>) builder;
//   final ReactiveModel<T> model;

//   @override
//   Widget build(BuildContext context) => builder(model.state, model);
// }
