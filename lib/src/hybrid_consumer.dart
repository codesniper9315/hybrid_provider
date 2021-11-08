import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'hybrid_state.dart';

class HybridConsumer<T extends ChangeNotifier, S extends HybridState>
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

class _HybridConsumerState<T extends ChangeNotifier, S extends HybridState>
    extends State<HybridConsumer<T, S>> {
  late T _provider;
  late S _state;

  _providerListener() {
    if (widget.listener != null) {
      widget.listener!(_provider, _state);
    }
  }

  @override
  void initState() {
    super.initState();
    _state = context.read<S>();
    _provider = context.read<T>();
    _provider.addListener(_providerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, value, child) => widget.builder(value, _state, child),
      child: widget.child,
    );
  }
}
