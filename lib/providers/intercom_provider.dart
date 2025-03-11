import 'package:flutter/foundation.dart';
import '../models/intercom_model.dart';

class IntercomProvider with ChangeNotifier {
  final List<Intercom> _intercoms = [];
  bool _isLoading = false;
  String? _error;
  final String _currentUser = 'User';

  List<Intercom> get intercoms => List.unmodifiable(_intercoms);
  bool get isLoading => _isLoading;
  String? get error => _error;

  IntercomProvider() {
    _initializeIntercoms();
  }

  void _initializeIntercoms() {
    _intercoms.addAll([
      Intercom(
        id: 'intercom_001',
        name: 'Front Door Intercom',
        room: 'Entrance',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        status: CallStatus.idle,
        hasCamera: true,
        hasSpeaker: true,
        hasMicrophone: true,
        volume: 0.8,
        isMuted: false,
        connectedTo: '',
        recentCalls: [
          'Kitchen Intercom - 20:45',
          'Living Room Intercom - 19:30',
        ],
        nightModeEnabled: false,
        autoAnswerEnabled: false,
      ),
      Intercom(
        id: 'intercom_002',
        name: 'Kitchen Intercom',
        room: 'Kitchen',
        isOnline: true,
        lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        status: CallStatus.idle,
        hasCamera: false,
        hasSpeaker: true,
        hasMicrophone: true,
        volume: 0.7,
        isMuted: false,
        connectedTo: '',
        recentCalls: [
          'Front Door Intercom - 20:45',
          'Living Room Intercom - 18:15',
        ],
        nightModeEnabled: true,
        autoAnswerEnabled: false,
      ),
    ]);
  }

  Future<void> initiateCall(String fromId, String toId) async {
    try {
      _setLoading(true);
      final callerIndex = _intercoms.indexWhere((i) => i.id == fromId);
      final receiverIndex = _intercoms.indexWhere((i) => i.id == toId);

      if (callerIndex != -1 && receiverIndex != -1) {
        await Future.delayed(const Duration(milliseconds: 500));

        // Update caller
        _intercoms[callerIndex] = _intercoms[callerIndex].copyWith(
          status: CallStatus.inCall,
          connectedTo: _intercoms[receiverIndex].name,
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );

        // Update receiver
        _intercoms[receiverIndex] = _intercoms[receiverIndex].copyWith(
          status: CallStatus.inCall,
          connectedTo: _intercoms[callerIndex].name,
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );

        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to initiate call: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> endCall(String intercomId) async {
    try {
      _setLoading(true);
      final index = _intercoms.indexWhere((i) => i.id == intercomId);

      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 300));

        final intercom = _intercoms[index];
        final connectedIntercomIndex = _intercoms.indexWhere(
                (i) => i.name == intercom.connectedTo
        );

        // Update current intercom
        _intercoms[index] = intercom.copyWith(
          status: CallStatus.idle,
          connectedTo: '',
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );

        // Update connected intercom if found
        if (connectedIntercomIndex != -1) {
          _intercoms[connectedIntercomIndex] = _intercoms[connectedIntercomIndex].copyWith(
            status: CallStatus.idle,
            connectedTo: '',
            lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
          );
        }

        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to end call: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> setVolume(String intercomId, double volume) async {
    try {
      _setLoading(true);
      final index = _intercoms.indexWhere((i) => i.id == intercomId);

      if (index != -1) {
        await Future.delayed(const Duration(milliseconds: 200));

        _intercoms[index] = _intercoms[index].copyWith(
          volume: volume.clamp(0.0, 1.0),
          lastUpdated: DateTime.parse('2025-03-10 21:09:30'),
        );
        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to set volume: $e');
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

  Intercom? getIntercomById(String id) {
    try {
      return _intercoms.firstWhere((intercom) => intercom.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Intercom> getIntercomsByRoom(String room) {
    return _intercoms.where((intercom) => intercom.room == room).toList();
  }
}