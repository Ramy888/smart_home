import 'package:flutter/material.dart';
import '../../../models/intercom_model.dart';

class IntercomCard extends StatelessWidget {
  final Intercom intercom;
  final Function(String) onCall;
  final Function(double) onVolumeChanged;

  const IntercomCard({
    super.key,
    required this.intercom,
    required this.onCall,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = intercom.isOnline && intercom.status == CallStatus.idle;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left section with info and features
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and room
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          intercom.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          intercom.room,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Features
                    Expanded(
                      child: _DeviceFeatures(intercom: intercom),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Right section with controls
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatusBadge(status: intercom.status),
                    if (isActive) ...[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Volume control
                          Row(
                            children: [
                              const Icon(Icons.volume_up, size: 18),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 2,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                    ),
                                  ),
                                  child: Slider(
                                    value: intercom.volume,
                                    onChanged: onVolumeChanged,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Call button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => _showCallDialog(context),
                              icon: const Icon(Icons.phone, size: 18),
                              label: const Text('Call'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Intercom to Call'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final target in ['Kitchen Intercom', 'Living Room Intercom'])
              if (target != intercom.name)
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(target),
                  onTap: () {
                    Navigator.pop(context);
                    onCall(target);
                  },
                ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final CallStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (status) {
        case CallStatus.idle:
          return Colors.green;
        case CallStatus.ringing:
          return Colors.orange;
        case CallStatus.inCall:
          return Colors.blue;
        case CallStatus.missed:
          return Colors.red;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: getStatusColor()),
      ),
      child: Text(
        status.name[0].toUpperCase() + status.name.substring(1),
        style: TextStyle(
          color: getStatusColor(),
          fontSize: 12,
        ),
      ),
    );
  }
}

class _DeviceFeatures extends StatelessWidget {
  final Intercom intercom;

  const _DeviceFeatures({required this.intercom});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (intercom.hasCamera)
          const _FeatureChip(
            icon: Icons.videocam,
            label: 'Camera',
          ),
        if (intercom.hasSpeaker)
          const _FeatureChip(
            icon: Icons.volume_up,
            label: 'Speaker',
          ),
        if (intercom.hasMicrophone)
          const _FeatureChip(
            icon: Icons.mic,
            label: 'Mic',
          ),
        if (intercom.nightModeEnabled)
          const _FeatureChip(
            icon: Icons.nightlight_round,
            label: 'Night Mode',
          ),
      ],
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
      padding: const EdgeInsets.all(4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}