import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tame_it/values/values.dart';
import 'package:window_manager/window_manager.dart';
import '../VideoCall/navigator_key.dart';
import '../VideoCall/screens/common/join_screen.dart';

class JoinOnlineSession extends StatefulWidget {
  const JoinOnlineSession({Key? key}) : super(key: key);

  @override
  _JoinOnlineSessionState createState() => _JoinOnlineSessionState();
}

class _JoinOnlineSessionState extends State<JoinOnlineSession> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (!kIsWeb && (Platform.isMacOS || Platform.isWindows)) {
      await windowManager.ensureInitialized();
      WindowOptions windowOptions = const WindowOptions(
        size: Size(900, 700),
      );
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        await windowManager.show();
        await windowManager.focus();
      });

      windowManager.setResizable(false);
      windowManager.setMaximizable(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          color: AppColors.black1,
        ),
        primaryColor: AppColors.black1,
        scaffoldBackgroundColor: AppColors.black2,
      ),
      home: const JoinScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
