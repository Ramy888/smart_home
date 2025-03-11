import 'package:flutter/material.dart';

class RoomFilter extends StatelessWidget {
  final String? selectedRoom;
  final ValueChanged<String?> onRoomSelected;

  const RoomFilter({
    super.key,
    required this.selectedRoom,
    required this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    final rooms = ['Living Room', 'Kitchen', 'Bedroom', 'Bathroom', 'Garden'];

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: rooms.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: const Text('All Rooms'),
                selected: selectedRoom == null,
                onSelected: (_) => onRoomSelected(null),
              ),
            );
          }
          final room = rooms[index - 1];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(room),
              selected: selectedRoom == room,
              onSelected: (_) => onRoomSelected(room),
            ),
          );
        },
      ),
    );
  }
}