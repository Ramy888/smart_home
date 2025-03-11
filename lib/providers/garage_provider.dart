import 'package:flutter/foundation.dart';
import '../models/garage_model.dart';

class GarageProvider with ChangeNotifier {
  final List<Garage> _garages = [];
  bool _isLoading = false;
  String? _error;
  final String _currentUser = 'User';

  List<Garage> get garages => List.unmodifiable(_garages);
  bool get isLoading => _isLoading;
  String? get error => _error;

  GarageProvider() {
    _initializeGarages();
  }

  void _initializeGarages() {
    _garages.addAll([
      Garage(
        id: 'garage_001',
        name: 'Main Garage',
        room: 'Garage',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        state: GarageState.closed,
        hasObstacle: false,
        batteryLevel: 95,
        lastOperation: DateTime.parse('2025-03-10 21:00:00'),
        hasVehiclePresent: true,
      ),
      Garage(
        id: 'garage_002',
        name: 'Workshop Garage',
        room: 'Workshop',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        state: GarageState.closed,
        hasObstacle: false,
        batteryLevel: 87,
        lastOperation: DateTime.parse('2025-03-10 20:45:00'),
        hasVehiclePresent: false,
      ),
    ]);
  }

  Future<void> operateGarage(String garageId, GarageState targetState) async {
    try {
      _setLoading(true);
      final index = _garages.indexWhere((garage) => garage.id == garageId);
      if (index != -1) {
        final garage = _garages[index];

        // Validate operation
        if (garage.hasObstacle && targetState == GarageState.closing) {
          throw Exception('Cannot close garage: Obstacle detected');
        }

        // Simulate operation delay
        await Future.delayed(const Duration(seconds: 2));

        _garages[index] = garage.copyWith(
          state: targetState,
          lastOperation: DateTime.parse('2025-03-10 21:09:30'),
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to operate garage: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> checkObstacle(String garageId) async {
    try {
      _setLoading(true);
      final index = _garages.indexWhere((garage) => garage.id == garageId);
      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 500));
        final garage = _garages[index];
        _garages[index] = garage.copyWith(
          hasObstacle: false,
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to check obstacle: $e');
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

  Garage? getGarageById(String id) {
    try {
      return _garages.firstWhere((garage) => garage.id == id);
    } catch (e) {
      return null;
    }
  }
}