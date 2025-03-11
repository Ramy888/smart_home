import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthome/screens/intercom/widgets/active_call_widget.dart';
import 'package:smarthome/screens/intercom/widgets/call_history_widget.dart';
import 'package:smarthome/screens/intercom/widgets/intercom_card_widget.dart';
import '../../models/intercom_model.dart';
import '../../providers/intercom_provider.dart';
import '../base_screen.dart';


class IntercomScreen extends StatelessWidget {
  const IntercomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final intercomProvider = context.watch<IntercomProvider>();
    final intercoms = intercomProvider.intercoms;
    final activeCall = intercoms.where((i) => i.status == CallStatus.inCall).toList();

    return BaseScreen(
      title: 'Intercom',
      body:
      // intercomProvider.isLoading
      //     ? const Center(child: CircularProgressIndicator())
      //     :
      CustomScrollView(
        slivers: [
          if (activeCall.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ActiveCallWidget(
                  intercom: activeCall.first,
                  onEndCall: () => intercomProvider.endCall(
                    activeCall.first.id,
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.15,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final intercom = intercoms[index];
                  return IntercomCard(
                    intercom: intercom,
                    onCall: (targetId) {
                      intercomProvider.initiateCall(
                        intercom.id,
                        targetId,
                      );
                    },
                    onVolumeChanged: (volume) {
                      intercomProvider.setVolume(intercom.id, volume);
                    },
                  );
                },
                childCount: intercoms.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CallHistoryWidget(
                recentCalls: intercoms
                    .expand((i) => i.recentCalls)
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}