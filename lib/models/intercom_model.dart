
import 'device_model.dart';

enum CallStatus { idle, ringing, inCall, missed }

class Intercom extends Device {
  final CallStatus status;
  final bool hasCamera;
  final bool hasSpeaker;
  final bool hasMicrophone;
  final double volume;
  final bool isMuted;
  final String connectedTo;
  final List<String> recentCalls;
  final bool nightModeEnabled;
  final bool autoAnswerEnabled;

  Intercom({
    required super.id,
    required super.name,
    required super.room,
    required super.isOnline,
    required super.lastUpdated,
    required this.status,
    required this.hasCamera,
    required this.hasSpeaker,
    required this.hasMicrophone,
    required this.volume,
    this.isMuted = false,
    this.connectedTo = '',
    this.recentCalls = const [],
    this.nightModeEnabled = false,
    this.autoAnswerEnabled = false,
  });

  bool get isAvailable => isOnline && status == CallStatus.idle;
  bool get isBusy => status == CallStatus.inCall;

  factory Intercom.fromJson(Map<String, dynamic> json) {
    return Intercom(
      id: json['id'],
      name: json['name'],
      room: json['room'],
      isOnline: json['isOnline'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      status: CallStatus.values.byName(json['status']),
      hasCamera: json['hasCamera'],
      hasSpeaker: json['hasSpeaker'],
      hasMicrophone: json['hasMicrophone'],
      volume: json['volume'].toDouble(),
      isMuted: json['isMuted'],
      connectedTo: json['connectedTo'],
      recentCalls: List<String>.from(json['recentCalls']),
      nightModeEnabled: json['nightModeEnabled'],
      autoAnswerEnabled: json['autoAnswerEnabled'],
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
      'status': status.name,
      'hasCamera': hasCamera,
      'hasSpeaker': hasSpeaker,
      'hasMicrophone': hasMicrophone,
      'volume': volume,
      'isMuted': isMuted,
      'connectedTo': connectedTo,
      'recentCalls': recentCalls,
      'nightModeEnabled': nightModeEnabled,
      'autoAnswerEnabled': autoAnswerEnabled,
    };
  }

  Intercom copyWith({
    String? id,
    String? name,
    String? room,
    bool? isOnline,
    DateTime? lastUpdated,
    CallStatus? status,
    bool? hasCamera,
    bool? hasSpeaker,
    bool? hasMicrophone,
    double? volume,
    bool? isMuted,
    String? connectedTo,
    List<String>? recentCalls,
    bool? nightModeEnabled,
    bool? autoAnswerEnabled,
  }) {
    return Intercom(
      id: id ?? this.id,
      name: name ?? this.name,
      room: room ?? this.room,
      isOnline: isOnline ?? this.isOnline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      status: status ?? this.status,
      hasCamera: hasCamera ?? this.hasCamera,
      hasSpeaker: hasSpeaker ?? this.hasSpeaker,
      hasMicrophone: hasMicrophone ?? this.hasMicrophone,
      volume: volume ?? this.volume,
      isMuted: isMuted ?? this.isMuted,
      connectedTo: connectedTo ?? this.connectedTo,
      recentCalls: recentCalls ?? this.recentCalls,
      nightModeEnabled: nightModeEnabled ?? this.nightModeEnabled,
      autoAnswerEnabled: autoAnswerEnabled ?? this.autoAnswerEnabled,
    );
  }
}