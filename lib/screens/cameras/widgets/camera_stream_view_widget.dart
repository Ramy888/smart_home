import 'package:flutter/material.dart';
import '../../../models/camera_model.dart';

class CameraStreamView extends StatelessWidget {
  final Camera camera;

  const CameraStreamView({
    super.key,
    required this.camera,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(camera.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  camera.streamUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.black,
                      child: const Center(
                        child: Icon(
                          Icons.videocam_off,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
                if (!camera.isOnline)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Text(
                        'Camera Offline',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    camera.hasNightVision ? Icons.nightlight : Icons.wb_sunny,
                  ),
                  title: Text(
                    camera.hasNightVision ? 'Night Vision On' : 'Day Mode',
                  ),
                  trailing: Switch(
                    value: camera.hasNightVision,
                    onChanged: camera.isOnline
                        ? (value) {
                      // Implement night vision toggle
                    }
                        : null,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.rotate_right),
                  title: const Text('Camera Angle'),
                  trailing: RotationControls(
                    onRotateLeft: camera.isOnline
                        ? () {
                      // Implement rotate left
                    }
                        : null,
                    onRotateRight: camera.isOnline
                        ? () {
                      // Implement rotate right
                    }
                        : null,
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

class RotationControls extends StatelessWidget {
  final VoidCallback? onRotateLeft;
  final VoidCallback? onRotateRight;

  const RotationControls({
    super.key,
    this.onRotateLeft,
    this.onRotateRight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.rotate_left),
          onPressed: onRotateLeft,
        ),
        IconButton(
          icon: const Icon(Icons.rotate_right),
          onPressed: onRotateRight,
        ),
      ],
    );
  }
}