import 'package:flutter/material.dart';

import '../../../models/camera_model.dart';

class CameraCard extends StatelessWidget {
  final Camera camera;
  final VoidCallback onTap;
  final VoidCallback onRecordingToggle;

  const CameraCard({
    super.key,
    required this.camera,
    required this.onTap,
    required this.onRecordingToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    camera.streamUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.videocam_off,
                          color: Colors.white,
                          size: 32,
                        ),
                      );
                    },
                  ),
                  if (!camera.isOnline)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: Text(
                          'Offline',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: camera.isRecording
                            ? Colors.red
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (camera.isRecording) ...[
                            const Icon(
                              Icons.fiber_manual_record,
                              color: Colors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'REC',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    camera.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    camera.room,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Fixed: Restructured the row to prevent overflow
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // Battery indicator now uses Expanded
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.battery_charging_full,
                                size: 16,
                                color: camera.batteryLevel < 20
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${camera.batteryLevel}%',
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Record button
                        IconButton(
                          icon: Icon(
                            camera.isRecording
                                ? Icons.stop_circle
                                : Icons.fiber_manual_record,
                            color: camera.isRecording ? Colors.red : null,
                          ),
                          onPressed: camera.isOnline ? onRecordingToggle : null,
                          constraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}