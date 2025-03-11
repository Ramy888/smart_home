import 'package:flutter/foundation.dart';
import '../models/door_lock_model.dart';

class DoorLockProvider with ChangeNotifier {
  final List<DoorLock> _locks = [];
  bool _isLoading = false;
  String? _error;
  final String _currentUser = 'User';

  List<DoorLock> get locks => List.unmodifiable(_locks);
  bool get isLoading => _isLoading;
  String? get error => _error;

  DoorLockProvider() {
    _initializeLocks();
  }

  void _initializeLocks() {
    _locks.addAll([
      DoorLock(
        id: 'lock_001',
        name: 'Front Door',
        room: 'Entrance',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        state: LockState.locked,
        supportedTypes: {LockType.pinCode, LockType.fingerprint, LockType.rfid},
        batteryLevel: 90,
        autoLock: true,
        authorizedUsers: ['User', 'Admin'],
        lastUnlocked: DateTime.parse('2025-03-10 20:30:00'),
        tamperAlert: false,
        autoLockDelay: const Duration(seconds: 30),
      ),
      DoorLock(
        id: 'lock_002',
        name: 'Back Door',
        room: 'Kitchen',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        state: LockState.locked,
        supportedTypes: {LockType.pinCode, LockType.keypad},
        batteryLevel: 85,
        autoLock: true,
        authorizedUsers: ['User', 'Admin'],
        lastUnlocked: DateTime.parse('2025-03-10 19:45:00'),
        tamperAlert: false,
        autoLockDelay: const Duration(seconds: 45),
      ),
    ]);
  }

  Future<void> toggleLock(String lockId) async {
    try {
      _setLoading(true);
      final index = _locks.indexWhere((lock) => lock.id == lockId);
      if (index != -1) {
        final lock = _locks[index];

        // Check authorization
        if (!lock.authorizedUsers.contains(_currentUser)) {
          throw Exception('User not authorized');
        }

        await Future.delayed(const Duration(milliseconds: 800));

        final newState = lock.state == LockState.locked
            ? LockState.unlocked
            : LockState.locked;

        _locks[index] = lock.copyWith(
          state: newState,
          lastUnlocked: newState == LockState.unlocked
              ? DateTime.parse('2025-03-10 21:09:30')
              : lock.lastUnlocked,
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to toggle lock: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addAuthorizedUser(String lockId, String userId) async {
    try {
      _setLoading(true);
      final index = _locks.indexWhere((lock) => lock.id == lockId);
      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 500));
        final lock = _locks[index];
        final updatedUsers = List<String>.from(lock.authorizedUsers)..add(userId);

        _locks[index] = lock.copyWith(
          authorizedUsers: updatedUsers,
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to add authorized user: $e');
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

  DoorLock? getLockById(String id) {
    try {
      return _locks.firstWhere((lock) => lock.id == id);
    } catch (e) {
      return null;
    }
  }

  List<DoorLock> getLocksByRoom(String room) {
    return _locks.where((lock) => lock.room == room).toList();
  }
}