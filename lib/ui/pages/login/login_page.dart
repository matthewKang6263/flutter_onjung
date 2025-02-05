// login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/ui/pages/home/home_page.dart';
import 'package:flutter_onjung/ui/pages/login/login_view_model.dart';
import 'package:flutter_onjung/ui/widgets/email_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/primary_button.dart';
import 'package:flutter_onjung/ui/widgets/toast.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // loginState와 loginViewModel 선언
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    // build 메서드 내에서 ref.listen을 등록합니다.
    ref.listen<AsyncValue>(
      loginViewModelProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          showToast("로그인 성공!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
    );

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white, // 배경 흰색
      appBar: AppBar(
        title: const Text('로그인', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white, // 앱바 흰색
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EmailTextFormField(controller: emailController),
            const SizedBox(height: 16),
            PwTextFormField(controller: passwordController),
            const SizedBox(height: 16),
            PrimaryButton(
              text: "로그인",
              onPressed: loginState is AsyncLoading
                  ? null
                  : () async {
                      await loginViewModel.signIn(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    },
              backgroundColor: Colors.blue,
            ),
            if (loginState is AsyncError)
              Text(
                '로그인 실패: ${(loginState as AsyncError).error}',
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
