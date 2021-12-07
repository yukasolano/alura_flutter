import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);

  change(String name) => emit(name);

  @override
  void onChange(Change<String> change) {
    super.onChange(change);
    print(change);
  }
}

class NameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => NameCubit("Yuka"), child: NameView());
  }
}

class NameView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;
    return Scaffold(
        appBar: AppBar(title: const Text("Change desired name")),
        body: Column(children: [
          TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Desired name"),
              style: TextStyle(
                fontSize: 24.0,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: Text("Change"),
                onPressed: () {
                  final name = _nameController.text;
                  context.read<NameCubit>().change(name);
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ]));
  }
}
