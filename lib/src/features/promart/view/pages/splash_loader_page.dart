import 'package:flutter/material.dart';

/// TODO: Finish the docs
/// SplashLoaderPage to...
class SplashLoaderPage extends StatelessWidget {
  const SplashLoaderPage({super.key});

  /// Static named route for page
  static const String route = 'SplashLoader';

  /// Static method to return the widget as a PageRoute
  static Route go() =>
      MaterialPageRoute<void>(builder: (_) => const SplashLoaderPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
