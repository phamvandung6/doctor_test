import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/auth_screen/forgot_password_screen.dart';
import 'package:doctor_test/presentations/screens/auth_screen/register_screen.dart';
import 'package:doctor_test/presentations/screens/landing_page.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Color myColor;
  late Size mediaSize;

  final LandingPageBloc landingPageBloc = LandingPageBloc();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: FormBlocListener<LoginFormBloc, String, String>(
        onSubmitting: (context, state) {
          LoadingDialog.show(context);
        },
        onSuccess: (context, state) async {
          LoadingDialog.hide(context);

          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: landingPageBloc,
                child: const LandingPage(),
              ),
            ),
          );
        },
        onFailure: (context, state) {
          LoadingDialog.hide(context);

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.failureResponse!)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: myColor,
            image: DecorationImage(
              image: const AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(myColor.withOpacity(0.7), BlendMode.dstATop),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              // Positioned(top: 80, child: _buildTop()),
              Positioned(bottom: 0, child: _buildBottom()),
            ]),
          ),
        ),
      ),
    );
  }

  // Widget _buildTop() {
  //   return SizedBox(
  //     width: mediaSize.width,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Image.asset('assets/images/logo.png', width: 100, height: 100),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Builder(builder: (context) {
      final loginFormBloc = context.read<LoginFormBloc>();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chào mừng",
            style: TextStyle(
                color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: loginFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [
              AutofillHints.username,
            ],
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 20),
          TextFieldBlocBuilder(
            textFieldBloc: loginFormBloc.password,
            suffixButton: SuffixButton.obscureText,
            autofillHints: const [AutofillHints.password],
            decoration: const InputDecoration(
              labelText: 'Mật khẩu',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 20),
          _buildRememberForgot(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Theme.of(context).primaryColor,
                  ),
                  width: 140,
                  child: TextButton(
                    onPressed: loginFormBloc.submit,
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                },
                child: const Text('Đăng kí'),
              )
            ],
          ),
        ],
      );
    });
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            const Text("Lưu đăng nhập"),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            );
          },
          child: const Text("Quên mật khẩu"),
        )
      ],
    );
  }
}
