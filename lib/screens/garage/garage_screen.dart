import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/screens/garage/widgets/garage_door_card_widget.dart';
import 'package:smarthome/screens/garage/widgets/garage_status_card_widget.dart';
import '../../models/garage_model.dart';
import '../../providers/garage_provider.dart';
import '../base_screen.dart';


class GarageScreen extends StatelessWidget {
  const GarageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final garageProvider = context.watch<GarageProvider>();
    final garages = garageProvider.garages;

    return BaseScreen(
      title: 'Garage',
      body:
      // garageProvider.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     :
      garages.isEmpty
          ? const Center(child: Text('No garage doors found'))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: garages.length,
        itemBuilder: (context, index) {
          final garage = garages[index];
          return Column(
            children: [
              GarageStatusCard(garage: garage),
              const SizedBox(height: 16),
              GarageDoorCard(
                garage: garage,
                onOpen: () => garageProvider.operateGarage(
                  garage.id,
                  GarageState.opening,
                ),
                onClose: () => garageProvider.operateGarage(
                  garage.id,
                  GarageState.closing,
                ),
                onStop: () => garageProvider.operateGarage(
                  garage.id,
                  GarageState.stopped,
                ),
              ),
              if (index < garages.length - 1)
                const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}