import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class HybridProvider extends StatelessWidget {
  const HybridProvider({
    Key? key,
    required this.states,
    required this.providers,
    required this.child,
  }) : super(key: key);

  final List<SingleChildWidget> states;
  final List<SingleChildWidget> providers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: states,
      child: MultiProvider(
        providers: providers,
        child: child,
      ),
    );
  }
}
