import 'package:kelola_product/kelola_produk/core/theme/theme.dart';
import 'package:kelola_product/kelola_produk/modules/dashboard/dashboard_view.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

void main() async {
  LazyUi.config(
    theme: AppTheme.light,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelola Produk',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home:  const DashboardView(),
      builder: (BuildContext context, Widget? widget) {
        double fontDeviceSize = MediaQuery.of(context).textScaleFactor;

        // prevent user from scaling font size
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: fontDeviceSize > 1.1 ? 1.1 : 1.0,
            ),
            child: LzToastOverlay(child: widget));
      },
    );
  }
}