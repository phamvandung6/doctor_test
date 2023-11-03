import 'package:doctor_test/logic/landing_page_bloc/landing_page_bloc.dart';
import 'package:doctor_test/presentations/screens/doctor_screen/doctor_screen.dart';
import 'package:doctor_test/presentations/screens/home_screen/home_screen.dart';
import 'package:doctor_test/presentations/screens/patient_screen/create_room_screen.dart';
import 'package:doctor_test/presentations/screens/patient_screen/room_screen.dart';
import 'package:doctor_test/presentations/screens/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_3_outlined),
    label: 'Bệnh Nhân',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_3_rounded),
    label: 'Bác sĩ',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Cài đặt',
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  HomeScreen(),
  // PatientScreen(),
  RoomScreen(),
  DoctorScreen(),
  SettingScreen(),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  static const id = 'landing_page';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: bottomNavScreen.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<LandingPageBloc>().add(TabChange(tabIndex: index));
            },
          ),
        );
      },
    );
  }
}
