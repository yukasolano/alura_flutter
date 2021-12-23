import 'package:alura_flutter/components/bloc_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  increment() => emit(state + 1);

  decrement() => emit(state - 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}

class CounterContainer extends BlocContainer {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterView()
    );
  }

}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Nosso contador")),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          return Text("$state", style: textTheme.headline2);
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          )
        ],
      ),
    );
  }
}
