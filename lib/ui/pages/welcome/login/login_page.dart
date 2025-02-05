import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/ui/pages/welcome/login/login_view_model.dart';
import 'package:flutter_onjung/ui/widgets/email_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/primary_button.dart';
import 'package:flutter_onjung/ui/widgets/toast.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인 상태 및 뷰모델
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    // 컨트롤러 생성
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    // 로그인 성공/실패 리스너
    ref.listen<AsyncValue>(
      loginViewModelProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          showToast("로그인 성공!");
          Navigator.pushReplacementNamed(context, '/home');
        } else if (next is AsyncError) {
          showToast("로그인 실패: ${next.error}");
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('로그인', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이메일 입력 필드 (회원가입 페이지와 동일한 스타일)
            EmailTextFormField(controller: emailController),
            const SizedBox(height: 16),
            // 비밀번호 입력 필드 (회원가입 페이지와 동일한 스타일)
            PwTextFormField(controller: passwordController),
            const SizedBox(height: 32),
            // PrimaryButton: 로그인 버튼
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
              backgroundColor: const Color(0xFF338BEF),
            ),
            const SizedBox(height: 16),
            // 에러 메시지 (로그인 실패 시)
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
