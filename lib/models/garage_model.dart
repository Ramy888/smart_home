import 'device_model.dart';

enum GarageState { closed, opening, open, closing, stopped }

class Garage extends Device {
  final GarageState state;
  final bool hasObstacle;
  final int batteryLevel;
  final DateTime? lastOperation;
  final bool hasVehiclePresent;

  Garage({
    required super.id,
    required super.name,
    required super.room,
    required super.isOnline,
    required super.lastUpdated,
    required this.state,
    required this.hasObstacle,
    required this.batteryLevel,
    this.lastOperation,
    this.hasVehiclePresent = false,
  });

  factory Garage.fromJson(Map<String, dynamic> json) {
    return Garage(
      id: json['id'],
      name: json['name'],
      room: json['room'],
      isOnline: json['isOnline'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      state: GarageState.values.byName(json['state']),
      hasObstacle: json['hasObstacle'],
      batteryLevel: json['batteryLevel'],
      lastOperation: json['lastOperation'] != null
          ? DateTime.parse(json['lastOperation'])
          : null,
      hasVehiclePresent: json['hasVehiclePresent'],
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
      'hasObstacle': hasObstacle,
      'batteryLevel': batteryLevel,
      'lastOperation': lastOperation?.toIso8601String(),
      'hasVehiclePresent': hasVehiclePresent,
    };
  }

  Garage copyWith({
    String? id,
    String? name,
    String? room,
    bool? isOnline,
    DateTime? lastUpdated,
    GarageState? state,
    bool? hasObstacle,
    int? batteryLevel,
    DateTime? lastOperation,
    bool? hasVehiclePresent,
  }) {
    return Garage(
      id: id ?? this.id,
      name: name ?? this.name,
      room: room ?? this.room,
      isOnline: isOnline ?? this.isOnline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      state: state ?? this.state,
      hasObstacle: hasObstacle ?? this.hasObstacle,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      lastOperation: lastOperation ?? this.lastOperation,
      hasVehiclePresent: hasVehiclePresent ?? this.hasVehiclePresent,
    );
  }
}