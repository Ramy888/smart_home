import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/screens/doors/widgets/security_summary_widget.dart';
import '../../providers/door_lock_provider.dart';
import '../base_screen.dart';
import 'widgets/door_lock_card.dart';

class DoorsScreen extends StatelessWidget {
  const DoorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doorProvider = context.watch<DoorLockProvider>();
    final locks = doorProvider.locks;

    return BaseScreen(
      title: 'Door Locks',
      body:
      // doorProvider.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     :
      Column(
        children: [
          const SecuritySummary(),
          Expanded(
            child: locks.isEmpty
                ? const Center(child: Text('No door locks found'))
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: locks.length,
              itemBuilder: (context, index) {
                final lock = locks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DoorLockCard(
                    lock: lock,
                    onToggle: () => doorProvider.toggleLock(lock.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}