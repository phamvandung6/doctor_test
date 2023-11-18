import 'package:doctor_test/logic/export_bloc.dart';
import 'package:doctor_test/presentations/screens/auth_screen/login_screen.dart';
import 'package:doctor_test/utils/loading_dialog.dart';
import 'package:flutter/material.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordFormBloc(),
      child: Builder(
        builder: (context) {
          final forgotPasswordFormBloc = context.read<ForgotPasswordFormBloc>();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quên mật khẩu'),
            ),
            body: FormBlocListener<ForgotPasswordFormBloc, String, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSubmissionFailed: (context, state) {
                LoadingDialog.hide(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse!)));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: Column(
                  children: [
                    const Text(
                      'Hãy nhập email của bạn, chúng tôi sẽ gửi đường dẫn để bạn cập nhật mật khẩu mới',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: forgotPasswordFormBloc.email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [
                        AutofillHints.username,
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: forgotPasswordFormBloc.submit,
                        child: const Text(
                          'Xác nhận',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
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
