
import 'device_model.dart';

class Camera extends Device {
  final bool isRecording;
  final bool hasMotionDetected;
  final String streamUrl;
  final double batteryLevel;
  final bool hasNightVision;
  final int rotationAngle;

  Camera({
    required super.id,
    required super.name,
    required super.room,
    required super.isOnline,
    required super.lastUpdated,
    required this.isRecording,
    required this.hasMotionDetected,
    required this.streamUrl,
    required this.batteryLevel,
    this.hasNightVision = false,
    this.rotationAngle = 0,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      name: json['name'],
      room: json['room'],
      isOnline: json['isOnline'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      isRecording: json['isRecording'],
      hasMotionDetected: json['hasMotionDetected'],
      streamUrl: json['streamUrl'],
      batteryLevel: json['batteryLevel'].toDouble(),
      hasNightVision: json['hasNightVision'],
      rotationAngle: json['rotationAngle'],
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
      'isRecording': isRecording,
      'hasMotionDetected': hasMotionDetected,
      'streamUrl': streamUrl,
      'batteryLevel': batteryLevel,
      'hasNightVision': hasNightVision,
      'rotationAngle': rotationAngle,
    };
  }

  Camera copyWith({
    String? id,
    String? name,
    String? room,
    bool? isOnline,
    DateTime? lastUpdated,
    bool? isRecording,
    bool? hasMotionDetected,
    String? streamUrl,
    double? batteryLevel,
    bool? hasNightVision,
    int? rotationAngle,
  }) {
    return Camera(
      id: id ?? this.id,
      name: name ?? this.name,
      room: room ?? this.room,
      isOnline: isOnline ?? this.isOnline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isRecording: isRecording ?? this.isRecording,
      hasMotionDetected: hasMotionDetected ?? this.hasMotionDetected,
      streamUrl: streamUrl ?? this.streamUrl,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      hasNightVision: hasNightVision ?? this.hasNightVision,
      rotationAngle: rotationAngle ?? this.rotationAngle,
    );
  }
}