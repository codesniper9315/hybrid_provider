import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HybridConsumer<T extends ChangeNotifier, S extends ChangeNotifier>
    extends StatefulWidget {
  const HybridConsumer({
    Key? key,
    required this.builder,
    this.listener,
    this.child,
  }) : super(key: key);

  final Widget Function(T value, S state, Widget? child) builder;
  final void Function(T value, S state)? listener;
  final Widget? child;

  @override
  State<HybridConsumer<T, S>> createState() => _HybridConsumerState<T, S>();
}

class _HybridConsumerState<T extends ChangeNotifier, S extends ChangeNotifier>
    extends State<HybridConsumer<T, S>> {
  late T _provider;
  late S _state;

  _onChangeState() {
    if (widget.listener != null) {
      widget.listener!(_provider, _state);
    }
  }

  @override
  void initState() {
    super.initState();
    _provider = context.read<T>();
    _state = context.read<S>();
    _state.addListener(_onChangeState);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<S>(
      builder: (context, value, child) =>
          widget.builder(_provider, value, child),
      child: widget.child,
    );
  }
}
