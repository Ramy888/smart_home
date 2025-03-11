import 'package:flutter/foundation.dart';
import '../models/camera_model.dart';

class CameraProvider with ChangeNotifier {
  final List<Camera> _cameras = [];
  bool _isLoading = false;
  String? _error;

  List<Camera> get cameras => List.unmodifiable(_cameras);
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Mock initial data
  CameraProvider() {
    _initializeCameras();
  }

  void _initializeCameras() {
    _cameras.addAll([
      Camera(
        id: 'cam_001',
        name: 'Front Door Camera',
        room: 'Entrance',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:06:04'),
        isRecording: true,
        hasMotionDetected: false,
        streamUrl: 'https://example.com/stream/cam_001',
        batteryLevel: 85,
        hasNightVision: true,
        rotationAngle: 0,
      ),
      Camera(
        id: 'cam_002',
        name: 'Backyard Camera',
        room: 'Garden',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:06:04'),
        isRecording: false,
        hasMotionDetected: true,
        streamUrl: 'https://example.com/stream/cam_002',
        batteryLevel: 72,
        hasNightVision: true,
        rotationAngle: 45,
      ),
    ]);
  }

  Future<void> toggleRecording(String cameraId) async {
    try {
      _setLoading(true);
      final index = _cameras.indexWhere((cam) => cam.id == cameraId);
      if (index != -1) {
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 500));
        final camera = _cameras[index];
        _cameras[index] = camera.copyWith(
          isRecording: !camera.isRecording,
          lastUpdated: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to toggle recording: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> rotateCamera(String cameraId, int angle) async {
    try {
      _setLoading(true);
      final index = _cameras.indexWhere((cam) => cam.id == cameraId);
      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 300));
        final camera = _cameras[index];
        _cameras[index] = camera.copyWith(
          rotationAngle: angle,
          lastUpdated: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to rotate camera: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? errorMessage) {
    _error = errorMessage;
    notifyListeners();
  }

  Camera? getCameraById(String id) {
    try {
      return _cameras.firstWhere((camera) => camera.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Camera> getCamerasByRoom(String room) {
    return _cameras.where((camera) => camera.room == room).toList();
  }
}