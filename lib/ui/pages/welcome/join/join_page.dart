import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/ui/pages/welcome/join/join_view_model.dart';
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

    // 컨트롤러
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();

    // 회원가입 성공/실패 리스너
    ref.listen<AsyncValue>(
      joinViewModelProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          showToast("회원가입이 완료되었습니다!");
          Navigator.pushReplacementNamed(context, '/home');
        } else if (next is AsyncError) {
          showToast("회원가입 실패: ${next.error}");
        }
      },
    );

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmailTextFormField(controller: emailController),
            const SizedBox(height: 16),
            PwTextFormField(controller: passwordController),
            const SizedBox(height: 16),
            NameTextFormField(controller: nameController),
            const SizedBox(height: 32),
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
              backgroundColor: const Color(0xFF338BEF),
            ),
            const SizedBox(height: 16),
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
