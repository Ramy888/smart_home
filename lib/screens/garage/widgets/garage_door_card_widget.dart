import 'package:flutter/material.dart';
import '../../../models/garage_model.dart';

class GarageDoorCard extends StatelessWidget {
  final Garage garage;
  final VoidCallback onOpen;
  final VoidCallback onClose;
  final VoidCallback onStop;

  const GarageDoorCard({
    super.key,
    required this.garage,
    required this.onOpen,
    required this.onClose,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isMoving = garage.state == GarageState.opening ||
        garage.state == GarageState.closing;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Door Controls',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.arrow_upward,
                  label: 'Open',
                  onPressed: garage.isOnline &&
                      garage.state != GarageState.open &&
                      !garage.hasObstacle
                      ? onOpen
                      : null,
                  color: colorScheme.primary,
                ),
                if (isMoving)
                  _ActionButton(
                    icon: Icons.stop,
                    label: 'Stop',
                    onPressed: garage.isOnline ? onStop : null,
                    color: colorScheme.error,
                  ),
                _ActionButton(
                  icon: Icons.arrow_downward,
                  label: 'Close',
                  onPressed: garage.isOnline &&
                      garage.state != GarageState.closed
                      ? onClose
                      : null,
                  color: colorScheme.primary,
                ),
              ],
            ),
            if (garage.hasObstacle) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Obstacle detected',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color color;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24),
            backgroundColor: color.withOpacity(0.1),
            foregroundColor: color,
          ),
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}