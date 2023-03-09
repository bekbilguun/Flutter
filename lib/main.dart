import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile/page/profile_page.dart';
import 'package:profile/themes.dart';
import 'package:profile/utils/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'User Profile';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeProvider.of(context),
          title: title,
          home: const ProfilePage(),
        ),
      ),
    );
  }
}
