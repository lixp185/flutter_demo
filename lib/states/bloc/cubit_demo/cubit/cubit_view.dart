import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit_cubit.dart';
import 'cubit_state.dart';

/// 写页面
class CubitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<CubitCubit>(context);
    return Stack(
      children: [
        BlocBuilder<CubitCubit, CubitState>(
          builder: (context, state) {
            return Center(
              child: Text("点击了${state.num}次"),
            );
          },
        ),
        Positioned(
          child: FloatingActionButton(
            onPressed: () {
              cubit.increment();
            },
            child: Icon(Icons.add),
          ),
          bottom: 20,
          right: 20,
        ),
      ],
    );
  }
}
