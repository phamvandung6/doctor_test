import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateRoomFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<CreateRoomFormBloc>(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Tạo phòng mới')),
            body: FormBlocListener<CreateRoomFormBloc, String, String>(
              onSubmitting: (context, state) async {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                // LoadingDialog.show(context);

                LoadingDialog.hide(context);
                Navigator.pop(context);
              },
              onFailure: (context, state) {
                // LoadingDialog.hide(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse.toString())));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 130, left: 12, right: 12),
                child: Column(
                  children: [
                    _roomNameInputField(formBloc),
                    const SizedBox(height: 12),
                    _roomIdInputField(formBloc),
                    const SizedBox(height: 20),
                    _bottomButton(formBloc, context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row _bottomButton(CreateRoomFormBloc formBloc, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            formBloc.submit();
          },
          child: const Text('Tạo phòng'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hủy'),
        ),
      ],
    );
  }

  TextFieldBlocBuilder _roomIdInputField(CreateRoomFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.roomId,
      decoration: InputDecoration(
        labelText: 'Nhập id phòng',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  TextFieldBlocBuilder _roomNameInputField(CreateRoomFormBloc formBloc) {
    return TextFieldBlocBuilder(
      textFieldBloc: formBloc.roomName,
      decoration: InputDecoration(
        labelText: 'Nhập tên phòng',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
