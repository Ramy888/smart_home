import 'package:flutter/material.dart';
import '../../../models/intercom_model.dart';

class ActiveCallWidget extends StatelessWidget {
  final Intercom intercom;
  final VoidCallback onEndCall;

  const ActiveCallWidget({
    super.key,
    required this.intercom,
    required this.onEndCall,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.phone_in_talk,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Active Call',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Connected to: ${intercom.connectedTo}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onEndCall,
                  icon: const Icon(Icons.call_end),
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CallActionButton(
                  icon: Icons.volume_up,
                  label: 'Speaker',
                  onPressed: () {
                    // Toggle speaker
                  },
                ),
                _CallActionButton(
                  icon: Icons.mic,
                  label: 'Mute',
                  onPressed: () {
                    // Toggle mute
                  },
                ),
                if (intercom.hasCamera)
                  _CallActionButton(
                    icon: Icons.videocam,
                    label: 'Video',
                    onPressed: () {
                      // Toggle video
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CallActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _CallActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}