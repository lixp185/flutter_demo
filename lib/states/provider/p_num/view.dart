import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

/// UI层
class PNumPage extends StatelessWidget {
  const PNumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PNumProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<PNumProvider>();
    // final state = providerer.state;
    return Stack(
      children: [
        Consumer<PNumProvider>(
          builder: (context, provider, child) {
            return Center(child: Text("点击了${provider.state.num}次"));
          },
        ),
        Positioned(
          child: FloatingActionButton(
            onPressed: () {
              provider.add();
            },
            child: Icon(Icons.add),
          ),
          bottom: 20,
          right: 20,
        )
      ],
    );
  }
}
