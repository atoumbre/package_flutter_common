library architecture;

import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class ViewModeWidget<T> extends StatelessWidget {
  const ViewModeWidget({Key key}) : super(key: key);

  Widget builder(BuildContext context, T state, ReactiveModel<T> model);
  T model();

  void ready(BuildContext context, ReactiveModel<T> model) {
    return null;
  }

  void dispose(BuildContext context, ReactiveModel<T> model) {
    return null;
  }

  List<StatesRebuilder> get observe => [];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>(
      builder: builder,
      model: () => RM.create<T>(model()),
      observe: observe,
      ready: ready,
      dispose: dispose,
    );
  }
}

class ViewModelBuilder<T> extends StatelessWidget {
  ViewModelBuilder({
    this.model,
    this.builder,
    this.ready,
    this.dispose,
    this.observe = const [],
  });

  final List<StatesRebuilder> observe;
  final StatesRebuilder Function() model;
  final Widget Function(BuildContext, T, ReactiveModel<T>) builder;
  final Function(BuildContext, ReactiveModel<T>) ready;
  final void Function(BuildContext, ReactiveModel<T>) dispose;

  @override
  Widget build(BuildContext context) {
    return StateBuilder<T>(
      observe: model,
      observeMany: observe.map((rm) => () => rm).toList(),
      initState: (context, model) {
        if (ready != null) ready(context, model);
      },
      builder: (context, model) {
        return _BuilderChildWithKeepState<T>(builder: builder, model: model);
      },
      dispose: dispose,
      disposeModels: true,
    );
  }
}

// ignore: unused_element
class _BuilderChild<T> extends StatelessWidget {
  _BuilderChild({this.builder, this.model});

  final Widget Function(BuildContext, T, ReactiveModel<T>) builder;
  final ReactiveModel<T> model;

  @override
  Widget build(BuildContext context) => builder(context, model.state, model);
}

// ignore: unused_element
class _BuilderChildWithHook<T> extends HookWidget {
  _BuilderChildWithHook({this.builder, this.model});

  final Widget Function(BuildContext, T, ReactiveModel<T>) builder;
  final ReactiveModel<T> model;

  @override
  Widget build(BuildContext context) => builder(context, model.state, model);
}

class _BuilderChildWithKeepState<T> extends StatefulWidget {
  _BuilderChildWithKeepState({this.builder, this.model});
  final Widget Function(BuildContext, T, ReactiveModel<T>) builder;
  final ReactiveModel<T> model;
  @override
  __BuilderChildWithKeepStateState createState() => __BuilderChildWithKeepStateState();
}

class __BuilderChildWithKeepStateState extends State<_BuilderChildWithKeepState> {
  @override
  @override
  Widget build(BuildContext context) => widget.builder(context, widget.model.state, widget.model);
}
