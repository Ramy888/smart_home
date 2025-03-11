import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/screens/cameras/widgets/camera_stream_view_widget.dart';
import '../../providers/camera_provider.dart';
import '../base_screen.dart';
import 'widgets/camera_card.dart';

class CamerasScreen extends StatelessWidget {
  const CamerasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cameraProvider = context.watch<CameraProvider>();
    final cameras = cameraProvider.cameras;

    return BaseScreen(
      title: 'Cameras',
      body:
      // cameraProvider.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     :
      cameras.isEmpty
          ? const Center(child: Text('No cameras found'))
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: cameras.length,
        itemBuilder: (context, index) {
          final camera = cameras[index];
          return CameraCard(
            camera: camera,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CameraStreamView(camera: camera),
                ),
              );
            },
            onRecordingToggle: () {
              cameraProvider.toggleRecording(camera.id);
            },
          );
        },
      ),
    );
  }
}