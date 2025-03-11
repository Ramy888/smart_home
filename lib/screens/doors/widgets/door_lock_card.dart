import 'package:flutter/material.dart';
import '../../../models/door_lock_model.dart';

class DoorLockCard extends StatelessWidget {
  final DoorLock lock;
  final VoidCallback onToggle;

  const DoorLockCard({
    super.key,
    required this.lock,
    required this.onToggle,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lock.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        lock.room,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (lock.tamperAlert)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: colorScheme.error,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tamper Alert',
                          style: TextStyle(
                            color: colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _LockStatus(lock: lock),
                ElevatedButton.icon(
                  onPressed: lock.isOnline ? onToggle : null,
                  icon: Icon(
                    lock.isLocked ? Icons.lock_open : Icons.lock,
                  ),
                  label: Text(
                    lock.isLocked ? 'Unlock' : 'Lock',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _LockInfo(lock: lock),
          ],
        ),
      ),
    );
  }
}

class _LockStatus extends StatelessWidget {
  final DoorLock lock;

  const _LockStatus({required this.lock});

  @override
  Widget build(BuildContext context) {
    final color = lock.isLocked ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            lock.isLocked ? 'Locked' : 'Unlocked',
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}

class _LockInfo extends StatelessWidget {
  final DoorLock lock;

  const _LockInfo({required this.lock});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(
          icon: Icons.battery_charging_full,
          label: 'Battery',
          value: '${lock.batteryLevel}%',
          color: lock.needsBatteryReplacement ? Colors.red : Colors.green,
        ),
        if (lock.lastUnlocked != null) ...[
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.access_time,
            label: 'Last Unlocked',
            value: '${lock.lastUnlocked!.hour}:${lock.lastUnlocked!.minute.toString().padLeft(2, '0')}',
            color: Colors.blue,
          ),
        ],
        const SizedBox(height: 8),
        _InfoRow(
          icon: Icons.security,
          label: 'Auto Lock',
          value: '${lock.autoLock ? 'On' : 'Off'} (${lock.autoLockDelay.inSeconds}s)',
          color: lock.autoLock ? Colors.green : Colors.grey,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: lock.supportedTypes.map((type) {
            IconData getTypeIcon() {
              switch (type) {
                case LockType.pinCode:
                  return Icons.keyboard;
                case LockType.fingerprint:
                  return Icons.fingerprint;
                case LockType.rfid:
                  return Icons.nfc;
                case LockType.keypad:
                  return Icons.dialpad;
              }
            }

            return Chip(
              avatar: Icon(
                getTypeIcon(),
                size: 16,
              ),
              label: Text(
                type.name,
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}