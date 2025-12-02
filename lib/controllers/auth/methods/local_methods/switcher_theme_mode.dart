import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../main.dart';
/// a [ThemeModeNotifier] has tow part of methods , first part that what should
/// the current theme mode be. and the second part of mthods 
/// that what the theme of every widget should be.
/// a first part of methods =
/// [toggleThemeMode] to toogle between dark theme or light theme.
/// [saveThemeMode] to save a last theme mode after toggle it.
/// [loadThemeMode] to load what the lastest theme mode has been saved.
/// a second part of methods =
/// [containerTheme] for a container widget.
/// [primaryTheme] for a primary widget.
/// [primary300Theme] for the secondary of primary widget.
/// [textTheme] for the text widget.
/// [backgroundAppTheme] for the background of app.
/// the 'isLightMode' told the app, that the theme should app take.
class ThemeModeNotifier extends StateNotifier<bool> {
  ThemeModeNotifier() : super(false) {
    loadThemeMode();
  }

  bool get isLightMode => true
  //state
  ;


  void toggleThemeMode(value) {
    state = value;
    //themeMode.onChanged(value);
    saveThemeMode(value);
    debugPrint("Theme mode updated to: ${state ? 'Light' : 'Dark'}");
  }

  Future<void> saveThemeMode(bool isLight) async {
    (await sp).setBool('isLightMode', isLight);
    debugPrint("Saved theme mode to SharedPreferences: $isLight");
  }

  Future<void> loadThemeMode() async {
    state =
        (await sp).getBool('isLightMode') ?? true; // Default to true (Light
    // mode)
    debugPrint(
        "Loaded theme mode from SharedPreferences: ${state ? 'Light' : 'Dark'}");
  }

  Color containerTheme({required WidgetRef ref, double? withOpacity}) {
    return (isLightMode
        ? ref.read(containerColorLight)
        : ref.read(containerColorDark)).withValues(alpha:withOpacity ?? 1);
  }

  Color primaryTheme({required WidgetRef ref, double? withOpacity}) {
    return withOpacity == null
        ? (isLightMode
            ? ref.read(primaryColorLight)
            : ref.read(primaryColorDark))
        : (isLightMode
            ? ref.read(primaryColorLight).withValues(alpha: withOpacity)
            : ref.read(primaryColorDark).withValues(alpha: withOpacity));
  }

  Color primary300Theme({required WidgetRef ref}) {
    return isLightMode
        ? ref.read(primaryColor300Light)
        : ref.read(primaryColor300Dark);
  }

  Color textTheme({required WidgetRef ref, double? withOpacity}) {
    return withOpacity == null
        ? (isLightMode ? ref.read(textColorLight) : ref.read(textColorDark))
        : (isLightMode
            ? ref.read(textColorLight).withValues(alpha: withOpacity)
            : ref.read(textColorDark).withValues(alpha: withOpacity));
  }

  Color backgroundAppTheme({required WidgetRef ref}) {
    return isLightMode
        ? ref.read(backgroundAppColorLight)
        : ref.read(backgroundAppColorDark);
  }
}
/*
ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref),
ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref)
ref.read(themeModeNotifier.notifier).primary300Theme(ref: ref),

 */
