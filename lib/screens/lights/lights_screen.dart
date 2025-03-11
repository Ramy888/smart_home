import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/screens/lights/widgets/light_card.dart';
import 'package:smarthome/screens/lights/widgets/room_filter.dart';
import '../../providers/light_provider.dart';
import '../base_screen.dart';


class LightsScreen extends StatefulWidget {
  const LightsScreen({super.key});

  @override
  State<LightsScreen> createState() => _LightsScreenState();
}

class _LightsScreenState extends State<LightsScreen> {
  String? _selectedRoom;

  @override
  Widget build(BuildContext context) {
    final lightProvider = context.watch<LightProvider>();
    final lights = _selectedRoom != null
        ? lightProvider.getLightsByRoom(_selectedRoom!)
        : lightProvider.lights;

    return BaseScreen(
      title: 'Lights',
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // Implement add new light
          },
        ),
      ],
      body: Column(
        children: [
          RoomFilter(
            selectedRoom: _selectedRoom,
            onRoomSelected: (room) {
              setState(() => _selectedRoom = room);
            },
          ),
          Expanded(
            child:
            // lightProvider.isLoading
            //     ? const Center(child: CircularProgressIndicator())
            //     :
            lights.isEmpty
                ? const Center(child: Text('No lights found'))
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: lights.length,
              itemBuilder: (context, index) {
                final light = lights[index];
                return LightCard(
                  light: light,
                  onToggle: () =>
                      lightProvider.toggleLight(light.id),
                  onBrightnessChanged: (value) =>
                      lightProvider.setBrightness(light.id, value),
                  onColorChanged: light.supportsColors
                      ? (color) =>
                      lightProvider.setColor(light.id, color)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}