import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/door_lock_provider.dart';

class SecuritySummary extends StatelessWidget {
  const SecuritySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final doorProvider = context.watch<DoorLockProvider>();
    final locks = doorProvider.locks;

    final totalLocks = locks.length;
    final lockedCount = locks.where((l) => l.state == LockState.locked).length;
    final unlockedCount = totalLocks - lockedCount;
    final tamperAlerts = locks.where((l) => l.tamperAlert).length;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatWidget(
                  icon: Icons.lock,
                  label: 'Locked',
                  value: lockedCount,
                  color: Colors.green,
                ),
                _StatWidget(
                  icon: Icons.lock_open,
                  label: 'Unlocked',
                  value: unlockedCount,
                  color: Colors.red,
                ),
                _StatWidget(
                  icon: Icons.warning_amber_rounded,
                  label: 'Alerts',
                  value: tamperAlerts,
                  color: Colors.orange,
                ),
              ],
            ),
            if (tamperAlerts > 0) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tamper alerts detected! Check affected locks.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
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

class _StatWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final Color color;

  const _StatWidget({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}