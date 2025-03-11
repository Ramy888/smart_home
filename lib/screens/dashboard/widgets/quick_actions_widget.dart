import 'package:flutter/material.dart';


class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _QuickActionButton(
            icon: Icons.lightbulb,
            label: 'All Lights',
            onPressed: () {
              // Implement all lights toggle
            },
          ),
          const SizedBox(width: 12),
          _QuickActionButton(
            icon: Icons.lock,
            label: 'Lock All',
            onPressed: () {
              // Implement all doors lock
            },
          ),
          const SizedBox(width: 12),
          _QuickActionButton(
            icon: Icons.shield,
            label: 'Away Mode',
            onPressed: () {
              // Implement away mode
            },
          ),
          const SizedBox(width: 12),
          _QuickActionButton(
            icon: Icons.nightlight_round,
            label: 'Night Mode',
            onPressed: () {
              // Implement night mode
            },
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}