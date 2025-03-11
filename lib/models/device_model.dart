abstract class Device {
  final String id;
  final String name;
  final String room;
  final bool isOnline;
  final DateTime lastUpdated;

  Device({
    required this.id,
    required this.name,
    required this.room,
    required this.isOnline,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'Device{id: $id, name: $name, room: $room, isOnline: $isOnline, lastUpdated: $lastUpdated}';
  }
}