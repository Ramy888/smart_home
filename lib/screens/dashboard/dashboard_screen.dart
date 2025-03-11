import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/screens/dashboard/widgets/device_summary_card.dart';
import 'package:smarthome/screens/dashboard/widgets/quick_actions_widget.dart';
import 'package:smarthome/screens/dashboard/widgets/weather_widget.dart';
import '../../models/garage_model.dart';
import '../../providers/camera_provider.dart';
import '../../providers/light_provider.dart';
import '../../providers/garage_provider.dart';
import '../../providers/door_lock_provider.dart';
import '../../providers/intercom_provider.dart';
import '../base_screen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Smart Home',
      showBackButton: false,
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh logic here
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WeatherWidget(),
                    const SizedBox(height: 24),
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    const QuickActions(),
                    const SizedBox(height: 24),
                    Text(
                      'Device Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildListDelegate([
                  DeviceSummaryCard(
                    title: 'Cameras',
                    icon: Icons.videocam,
                    count: context.watch<CameraProvider>().cameras.length,
                    activeCount: context
                        .watch<CameraProvider>()
                        .cameras
                        .where((c) => c.isOnline)
                        .length,
                    onTap: () => Navigator.pushNamed(context, '/cameras'),
                  ),
                  DeviceSummaryCard(
                    title: 'Lights',
                    icon: Icons.lightbulb,
                    count: context.watch<LightProvider>().lights.length,
                    activeCount: context
                        .watch<LightProvider>()
                        .lights
                        .where((l) => l.isOn)
                        .length,
                    onTap: () => Navigator.pushNamed(context, '/lights'),
                  ),
                  DeviceSummaryCard(
                    title: 'Doors',
                    icon: Icons.lock,
                    count: context.watch<DoorLockProvider>().locks.length,
                    activeCount: context
                        .watch<DoorLockProvider>()
                        .locks
                        .where((l) => l.state == LockState.locked)
                        .length,
                    onTap: () => Navigator.pushNamed(context, '/doors'),
                  ),
                  DeviceSummaryCard(
                    title: 'Garage',
                    icon: Icons.garage,
                    count: context.watch<GarageProvider>().garages.length,
                    activeCount: context
                        .watch<GarageProvider>()
                        .garages
                        .where((g) => g.state == GarageState.closed)
                        .length,
                    onTap: () => Navigator.pushNamed(context, '/garage'),
                  ),
                  DeviceSummaryCard(
                    title: 'Intercom',
                    icon: Icons.phone_in_talk,
                    count: context.watch<IntercomProvider>().intercoms.length,
                    activeCount: context
                        .watch<IntercomProvider>()
                        .intercoms
                        .where((i) => i.isOnline)
                        .length,
                    onTap: () => Navigator.pushNamed(context, '/intercom'),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}