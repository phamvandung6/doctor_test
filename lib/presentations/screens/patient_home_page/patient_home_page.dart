import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/list_regimen_screen/list_regimen.dart';
import 'package:flutter/material.dart';

import '../../../utils/patient_profile.dart';
import '../treatment/treatment.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({Key? key}) : super(key: key);
  @override
  State<PatientHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<PatientHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RoomBloc>.value(
              value: BlocProvider.of<RoomBloc>(context)),
          BlocProvider<PatientBloc>.value(
              value: BlocProvider.of<PatientBloc>(context)),
        ],
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Trang chủ bệnh nhân'),
              bottom: TabBar(
                onTap: (selectedIndex) {},
                tabs: const [
                  Tab(
                    child: Text(
                      'Điều trị',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Danh sách phác đồ',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Hồ sơ bệnh nhân',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                const Treatment(),
                ListRegimen(
                    room: context.read<RoomBloc>().state.chosenRoom,
                    patient: context.read<PatientBloc>().state.chosenPatient),
                PatientProfile(widget: widget)
              ],
            ),
          ),
        ));
  }
}
