import 'package:flutter/material.dart';
import 'package:flutter_onjung/ui/pages/welcome/login/login_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loginViewModel is AsyncLoading
                  ? null
                  : () {
                      ref.read(loginViewModelProvider.notifier).signIn(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                    },
              child: loginViewModel is AsyncLoading
                  ? const CircularProgressIndicator()
                  : const Text('로그인'),
            ),
            if (loginViewModel is AsyncError)
              Text('로그인 실패: ${(loginViewModel as AsyncError).error}',
                  style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
