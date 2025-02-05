import 'package:flutter/material.dart';
import 'package:flutter_onjung/ui/pages/home/_tab/address_tab/address_tab.dart';
import 'package:flutter_onjung/ui/pages/home/_tab/calendar_tab/calendar_tab.dart';
import 'package:flutter_onjung/ui/pages/home/_tab/home_tab.dart';
import 'package:flutter_onjung/ui/pages/home/_tab/onjung_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_onjung/ui/pages/home/home_view_model.dart';

class HomeIndexedStack extends ConsumerWidget {
  const HomeIndexedStack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeViewModelProvider);
    return IndexedStack(
      index: currentIndex,
      children: const [
        HomeTab(),
        AddressTab(),
        CalendarTab(),
        OnjungTab(),
      ],
    );
  }
}
