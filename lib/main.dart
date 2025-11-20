import 'package:dz_pub/core/styling/theme_styles.dart';
import 'package:dz_pub/routing/Router_genrator.dart';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main()  {
  
  runApp(MyApp(
   
  ));
}
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
