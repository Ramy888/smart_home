import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/light_model.dart';

class LightProvider with ChangeNotifier {
  final List<Light> _lights = [];
  bool _isLoading = false;
  String? _error;

  List<Light> get lights => List.unmodifiable(_lights);
  bool get isLoading => _isLoading;
  String? get error => _error;

  LightProvider() {
    _initializeLights();
  }

  void _initializeLights() {
    _lights.addAll([
      Light(
        id: 'light_001',
        name: 'Living Room Main',
        room: 'Living Room',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:06:04'),
        isOn: true,
        brightness: 0.8,
        color: Colors.white,
        supportsColors: true,
        powerConsumption: 8.5,
        schedule: '07:00-23:00',
      ),
      Light(
        id: 'light_002',
        name: 'Kitchen Ceiling',
        room: 'Kitchen',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:06:04'),
        isOn: false,
        brightness: 1.0,
        color: Colors.white,
        supportsColors: false,
        powerConsumption: 12.0,
        schedule: '06:00-22:00',
      ),
    ]);
  }

  Future<void> toggleLight(String lightId) async {
    try {
      _setLoading(true);
      final index = _lights.indexWhere((light) => light.id == lightId);
      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 300));
        final light = _lights[index];
        _lights[index] = light.copyWith(
          isOn: !light.isOn,
          lastUpdated: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to toggle light: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> setBrightness(String lightId, double brightness) async {
    try {
      _setLoading(true);
      final index = _lights.indexWhere((light) => light.id == lightId);
      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 300));
        final light = _lights[index];
        _lights[index] = light.copyWith(
          brightness: brightness.clamp(0.0, 1.0),
          lastUpdated: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to set brightness: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> setColor(String lightId, Color color) async {
    try {
      _setLoading(true);
      final index = _lights.indexWhere((light) => light.id == lightId);
      if (index != -1 && _lights[index].supportsColors) {
        await Future.delayed(const Duration(milliseconds: 300));
        final light = _lights[index];
        _lights[index] = light.copyWith(
          color: color,
          lastUpdated: DateTime.now(),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to set color: $e');
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

  Light? getLightById(String id) {
    try {
      return _lights.firstWhere((light) => light.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Light> getLightsByRoom(String room) {
    return _lights.where((light) => light.room == room).toList();
  }
}