import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import 'providers.dart';
import 'router/app_router.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLanguage = ref.watch(languageProvider);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFa91145),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'TVK Grievance',

      // Global application language.
      locale: appLanguage.locale,

      // Flutter generated localization configuration.
      localizationsDelegates:
          AppLocalizations.localizationsDelegates,

      supportedLocales:
          AppLocalizations.supportedLocales,

      theme: ThemeData(
        fontFamily: 'Poppins',
      ),

      routerConfig: appRouter,

      builder: (context, child) {
        return Container(
          color: const Color(0xFFa91145),
          child: SafeArea(
            bottom: false,
            child: child ?? const SizedBox(),
          ),
        );
      },
    );
  }
}