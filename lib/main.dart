import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:restaurantes/core/bindings/home_binding.dart';
import 'package:restaurantes/pages/restaurant/home/home_page.dart';
import 'package:restaurantes/routes/app_pages.dart';
import 'package:restaurantes/routes/app_routes.dart';
import 'package:restaurantes/utils/themes/dark_theme.dart';
import 'package:restaurantes/translations/app_translation.dart';
import 'package:restaurantes/utils/themes/light_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main()async {
  GetTimeAgo.setDefaultLocale('es');
  FlutterNativeSplash.remove();
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.light,
    translations: Messages(),
    locale: Get.deviceLocale,
    fallbackLocale:  Locale('en', 'US'),
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
    home: const HomePage(),
  ),);
}
