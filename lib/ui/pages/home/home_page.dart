import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_onjung/ui/pages/home/widgets/home_bottom_navigation_bar.dart';
import 'package:flutter_onjung/ui/pages/home/widgets/home_indexed_stack.dart';
import 'package:flutter_onjung/ui/pages/home/home_view_model.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeViewModelProvider);
    final vm = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      body: HomeIndexedStack(),
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: vm.onIndexChanged,
      ),
    );
  }
}
