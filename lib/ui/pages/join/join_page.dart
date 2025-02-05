// join_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/ui/pages/home/home_page.dart';
import 'package:flutter_onjung/ui/pages/join/join_view_model.dart';
import 'package:flutter_onjung/ui/widgets/email_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/name_text_form_field.dart';
import 'package:flutter_onjung/ui/widgets/primary_button.dart';
import 'package:flutter_onjung/ui/widgets/toast.dart';

class JoinPage extends ConsumerWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinState = ref.watch(joinViewModelProvider);
    final joinViewModel = ref.read(joinViewModelProvider.notifier);

    // build 메서드 내에서 리스너 등록 (회원가입 성공 시 처리)
    ref.listen<AsyncValue>(
      joinViewModelProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          showToast("회원가입이 완료되었습니다!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
    );

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('회원가입', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
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
            NameTextFormField(controller: nameController),
            const SizedBox(height: 16),
            PrimaryButton(
              text: "회원가입",
              onPressed: joinState is AsyncLoading
                  ? null
                  : () async {
                      await joinViewModel.signUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text.trim(),
                      );
                    },
              backgroundColor: Colors.blue,
            ),
            if (joinState is AsyncError)
              Text(
                '회원가입 실패: ${(joinState as AsyncError).error}',
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
