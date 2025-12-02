import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/language_notifier.dart';
import 'package:dz_pub/core/styling/theme_styles.dart';
import 'package:dz_pub/routing/Router_genrator.dart';
import 'package:dz_pub/session/new_session.dart';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/get_it_controller.dart';
final Future<SharedPreferences> sp = SharedPreferences.getInstance();

void main()async  {
  WidgetsFlutterBinding.ensureInitialized();

  await NewSession.init();
  await configureInjection();
  NewSession.save(PrefKeys.userType, 'client');
  //removeUserInfo();
debugPrint("NewSession.userType ${NewSession.get(PrefKeys.userType, '')}");
  runApp(ProviderScope(
      overrides: [
      languageProvider.overrideWith(
      (ref) => LanguageNotifier(initialLocale),
  )
    ],
    child: MyApp(

    ),
  ));
}
final savedLanguage = NewSession.get(PrefKeys.language, 'ar');
final initialLocale = (savedLanguage == 'ar')
    ? const Locale('ar', 'JO')
    : const Locale('en', 'US');
final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>(
      (ref) => LanguageNotifier(initialLocale),
);
class MyApp extends StatelessWidget {
  
  const MyApp({super.key ,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('en'), Locale('fr'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'DZ_PUP',
      theme: ThemeStyles.lightTheme,
      routerConfig: RouterGenrator.mainRouttingInourApp,
     
    );
 
  }
}
