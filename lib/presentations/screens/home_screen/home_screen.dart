import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/logic/landing_page_bloc/landing_page_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Image.network(
                  'https://tamanhhospital.vn/wp-content/uploads/2022/04/logo-benh-vien-da-khoa-tam-anh.png',
                  width: 170,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.5,
                decoration: const BoxDecoration(),
                child: Image.network(
                  'https://tamanhhospital.vn/wp-content/uploads/2020/12/benh-vien-da-khoa-tam-anh.jpg',
                  width: 350,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Hãy bắt đầu bằng cách tìm phòng bệnh nhân',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              BlocProvider(
                create: (context) => LandingPageBloc(),
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<LandingPageBloc>(context).add(
                      TabChange(
                        tabIndex: 1,
                      ),
                    );
                  },
                  child: const Text('Bắt đầu'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
