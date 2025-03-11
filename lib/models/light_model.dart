import 'dart:ui';

import 'device_model.dart';

class Light extends Device {
  final bool isOn;
  final double brightness;
  final Color color;
  final bool supportsColors;
  final double powerConsumption;
  final String schedule;

  Light({
    required super.id,
    required super.name,
    required super.room,
    required super.isOnline,
    required super.lastUpdated,
    required this.isOn,
    required this.brightness,
    required this.color,
    this.supportsColors = false,
    this.powerConsumption = 0.0,
    this.schedule = '',
  });

  factory Light.fromJson(Map<String, dynamic> json) {
    return Light(
      id: json['id'],
      name: json['name'],
      room: json['room'],
      isOnline: json['isOnline'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      isOn: json['isOn'],
      brightness: json['brightness'].toDouble(),
      color: Color(json['color']),
      supportsColors: json['supportsColors'],
      powerConsumption: json['powerConsumption'].toDouble(),
      schedule: json['schedule'],
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
      'isOn': isOn,
      'brightness': brightness,
      'color': color.value,
      'supportsColors': supportsColors,
      'powerConsumption': powerConsumption,
      'schedule': schedule,
    };
  }

  Light copyWith({
    String? id,
    String? name,
    String? room,
    bool? isOnline,
    DateTime? lastUpdated,
    bool? isOn,
    double? brightness,
    Color? color,
    bool? supportsColors,
    double? powerConsumption,
    String? schedule,
  }) {
    return Light(
      id: id ?? this.id,
      name: name ?? this.name,
      room: room ?? this.room,
      isOnline: isOnline ?? this.isOnline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isOn: isOn ?? this.isOn,
      brightness: brightness ?? this.brightness,
      color: color ?? this.color,
      supportsColors: supportsColors ?? this.supportsColors,
      powerConsumption: powerConsumption ?? this.powerConsumption,
      schedule: schedule ?? this.schedule,
    );
  }
}