import 'package:flutter/material.dart';

import '../screens/cameras/camera_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/doors/doors_screen.dart';
import '../screens/garage/garage_screen.dart';
import '../screens/intercom/intercom_screen.dart';
import '../screens/lights/lights_screen.dart';

class AppRouter {
  static const String dashboard = '/dashboard';
  static const String cameras = '/cameras';
  static const String lights = '/lights';
  static const String garage = '/garage';
  static const String doors = '/doors';
  static const String intercom = '/intercom';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case cameras:
        return MaterialPageRoute(builder: (_) => const CamerasScreen());
      case lights:
        return MaterialPageRoute(builder: (_) => const LightsScreen());
      case garage:
        return MaterialPageRoute(builder: (_) => const GarageScreen());
      case doors:
        return MaterialPageRoute(builder: (_) => const DoorsScreen());
      case intercom:
        return MaterialPageRoute(builder: (_) => const IntercomScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}