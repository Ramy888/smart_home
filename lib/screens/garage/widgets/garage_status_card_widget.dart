import 'package:flutter/material.dart';
import '../../../models/garage_model.dart';


class GarageStatusCard extends StatelessWidget {
  final Garage garage;

  const GarageStatusCard({
    super.key,
    required this.garage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      garage.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      garage.room,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                _StatusIndicator(state: garage.state),
              ],
            ),
            const SizedBox(height: 16),
            _InfoGrid(
              batteryLevel: garage.batteryLevel,
              hasVehicle: garage.hasVehiclePresent,
              lastOperation: garage.lastOperation,
              isOnline: garage.isOnline,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final GarageState state;

  const _StatusIndicator({required this.state});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color getStateColor() {
      switch (state) {
        case GarageState.open:
          return Colors.red;
        case GarageState.closed:
          return Colors.green;
        case GarageState.opening:
        case GarageState.closing:
          return Colors.orange;
        case GarageState.stopped:
          return Colors.grey;
      }
    }

    String getStateText() {
      return state.name[0].toUpperCase() + state.name.substring(1);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: getStateColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: getStateColor()),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: getStateColor(),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            getStateText(),
            style: TextStyle(color: getStateColor()),
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final int batteryLevel;
  final bool hasVehicle;
  final DateTime? lastOperation;
  final bool isOnline;

  const _InfoGrid({
    required this.batteryLevel,
    required this.hasVehicle,
    required this.lastOperation,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _InfoTile(
          icon: Icons.battery_charging_full,
          label: 'Battery',
          value: '$batteryLevel%',
          color: batteryLevel > 20 ? Colors.green : Colors.red,
        ),
        _InfoTile(
          icon: Icons.directions_car,
          label: 'Vehicle',
          value: hasVehicle ? 'Present' : 'Absent',
          color: hasVehicle ? Colors.blue : Colors.grey,
        ),
        _InfoTile(
          icon: Icons.access_time,
          label: 'Last Operation',
          value: lastOperation != null
              ? '${lastOperation!.hour}:${lastOperation!.minute.toString().padLeft(2, '0')}'
              : 'N/A',
          color: Colors.orange,
        ),
        _InfoTile(
          icon: Icons.wifi,
          label: 'Status',
          value: isOnline ? 'Online' : 'Offline',
          color: isOnline ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}