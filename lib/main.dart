import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/auth_screen/login_screen.dart';
import 'package:doctor_test/presentations/screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDfUDDHaskFfoxVIDWb0WRfLilYSjWDSpI',
      appId: '1:905253298603:android:955786ed24f896073072ee',
      messagingSenderId: '905253298603',
      projectId: 'doctor-test-5ddc4',
    ),
  );

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LandingPageBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doctor',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        // initialRoute: '/',
        // onGenerateRoute: RouteGenerator().generateRoute,
        home: isLogin ? const LandingPage() : const LoginScreen(),
      ),
    );
  }
}
