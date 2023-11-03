import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/models/room_model.dart';
import 'package:doctor_test/utils/guid_gen.dart';
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
              onSubmitting: (context, state) {
                var room = Room(
                  roomId: formBloc.roomId.value,
                  roomName: formBloc.roomName.value,
                  id: GUIDGen.generate(),
                );
                context.read<RoomBloc>().add(AddRoom(room: room));
                context.read<RoomBloc>().add(GetAllRooms());
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                Navigator.pop(context);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse.toString())));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 130, left: 12, right: 12),
                child: Column(
                  children: [
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.roomName,
                      decoration: InputDecoration(
                        labelText: 'Nhập tên phòng',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.roomId,
                      decoration: InputDecoration(
                        labelText: 'Nhập id phòng',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        formBloc.submit();
                      },
                      child: const Text('Tạo phòng'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
