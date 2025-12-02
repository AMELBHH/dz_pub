import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../methods/local_methods/switcher_theme_mode.dart';

final themeModeNotifier = StateNotifierProvider<ThemeModeNotifier, bool>((ref) {
  return ThemeModeNotifier();
});

//EB9B6A->GOLD
//WHITE
//GRAY -> E6E6E6
//06273A -> DARK BLUE

// dark theme
final containerColorDark =
    StateProvider<Color>((ref) => const Color(0xf3333333));
final primaryColorDark = StateProvider<Color>((ref) => const Color(0xffca7733));
final primaryColor300Dark =
    StateProvider<Color>((ref) => const Color(0x99FFB74D));
final textColorDark = StateProvider<Color>((ref) => const Color(0xfdfCfCfC));
final backgroundAppColorDark =
    StateProvider<Color>((ref) => const Color(0xff2B2B2B));

// light theme
final containerColorLight =
    StateProvider<Color>((ref) => const Color(0xffffffff));
final primaryColorLight =
    StateProvider<Color>((ref) => const Color(0xff5459FF));
final primaryColor300Light =
    StateProvider<Color>((ref) => const Color(0xff5459FF).withOpacity(0.3));
final textColorLight = StateProvider<Color>((ref) => const Color(0xdd000000));
final backgroundAppColorLight =
    StateProvider<Color>((ref) => const Color(0xffeeeeee));
