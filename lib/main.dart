import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/providers/camera_provider.dart';
import 'package:smarthome/providers/door_lock_provider.dart';
import 'package:smarthome/providers/garage_provider.dart';
import 'package:smarthome/providers/intercom_provider.dart';
import 'package:smarthome/providers/light_provider.dart';
import 'package:smarthome/providers/theme_provider.dart';
import 'package:smarthome/screens/dashboard/dashboard_screen.dart';
import 'package:smarthome/screens/splash_screen.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
        ChangeNotifierProvider(create: (_) => LightProvider()),
        ChangeNotifierProvider(create: (_) => GarageProvider()),
        ChangeNotifierProvider(create: (_) => DoorLockProvider()),
        ChangeNotifierProvider(create: (_) => IntercomProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Smart House Control',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            onGenerateRoute: AppRouter.onGenerateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}