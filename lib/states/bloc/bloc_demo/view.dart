import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

/// 视图页面
class BlocNumPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DemoBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DemoBloc>(context);
    return Stack(
      children: [
        Center(
          child: BlocBuilder<DemoBloc, DemoState>(
            builder: (context, state) {
              return Text("点击了${bloc.state.num}次");
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              bloc.add(IncrementEvent());
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
