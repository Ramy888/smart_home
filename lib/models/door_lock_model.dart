
import 'device_model.dart';

enum LockState { locked, unlocked, jammed }
enum LockType { pinCode, fingerprint, rfid, keypad }

class DoorLock extends Device {
  final LockState state;
  final Set<LockType> supportedTypes;
  final bool autoLock;
  final int batteryLevel;
  final List<String> authorizedUsers;
  final DateTime? lastUnlocked;
  final bool tamperAlert;
  final Duration autoLockDelay;

  DoorLock({
    required super.id,
    required super.name,
    required super.room,
    required super.isOnline,
    required super.lastUpdated,
    required this.state,
    required this.supportedTypes,
    required this.batteryLevel,
    this.autoLock = true,
    this.authorizedUsers = const [],
    this.lastUnlocked,
    this.tamperAlert = false,
    this.autoLockDelay = const Duration(seconds: 30),
  });

  bool get isLocked => state == LockState.locked;
  bool get isJammed => state == LockState.jammed;
  bool get needsBatteryReplacement => batteryLevel < 20;

  factory DoorLock.fromJson(Map<String, dynamic> json) {
    return DoorLock(
      id: json['id'],
      name: json['name'],
      room: json['room'],
      isOnline: json['isOnline'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      state: LockState.values.byName(json['state']),
      supportedTypes: (json['supportedTypes'] as List)
          .map((type) => LockType.values.byName(type))
          .toSet(),
      autoLock: json['autoLock'],
      batteryLevel: json['batteryLevel'],
      authorizedUsers: List<String>.from(json['authorizedUsers']),
      lastUnlocked: json['lastUnlocked'] != null
          ? DateTime.parse(json['lastUnlocked'])
          : null,
      tamperAlert: json['tamperAlert'],
      autoLockDelay: Duration(seconds: json['autoLockDelay']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'room': room,
      'isOnline': isOnline,
      'lastUpdated': lastUpdated.toIso8601String(),
      'state': state.name,
      'supportedTypes': supportedTypes.map((type) => type.name).toList(),
      'autoLock': autoLock,
      'batteryLevel': batteryLevel,
      'authorizedUsers': authorizedUsers,
      'lastUnlocked': lastUnlocked?.toIso8601String(),
      'tamperAlert': tamperAlert,
      'autoLockDelay': autoLockDelay.inSeconds,
    };
  }

  DoorLock copyWith({
    String? id,
    String? name,
    String? room,
    bool? isOnline,
    DateTime? lastUpdated,
    LockState? state,
    Set<LockType>? supportedTypes,
    bool? autoLock,
    int? batteryLevel,
    List<String>? authorizedUsers,
    DateTime? lastUnlocked,
    bool? tamperAlert,
    Duration? autoLockDelay,
  }) {
    return DoorLock(
      id: id ?? this.id,
      name: name ?? this.name,
      room: room ?? this.room,
      isOnline: isOnline ?? this.isOnline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      state: state ?? this.state,
      supportedTypes: supportedTypes ?? this.supportedTypes,
      autoLock: autoLock ?? this.autoLock,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      authorizedUsers: authorizedUsers ?? this.authorizedUsers,
      lastUnlocked: lastUnlocked ?? this.lastUnlocked,
      tamperAlert: tamperAlert ?? this.tamperAlert,
      autoLockDelay: autoLockDelay ?? this.autoLockDelay,
    );
  }
}