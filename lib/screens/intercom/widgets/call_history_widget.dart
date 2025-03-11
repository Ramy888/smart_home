import 'package:flutter/material.dart';

class CallHistoryWidget extends StatelessWidget {
  final List<String> recentCalls;

  const CallHistoryWidget({
    super.key,
    required this.recentCalls,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Calls',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (recentCalls.isEmpty)
              const Center(
                child: Text('No recent calls'),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentCalls.length,
                itemBuilder: (context, index) {
                  final call = recentCalls[index];
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    title: Text(call.split(' - ')[0]),
                    subtitle: Text(call.split(' - ')[1]),
                    trailing: IconButton(
                      icon: const Icon(Icons.phone),
                      onPressed: () {
                        // Implement callback functionality
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}