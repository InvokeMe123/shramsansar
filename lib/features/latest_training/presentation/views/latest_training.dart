import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/commons/training_card.dart';
import 'package:shramsansar/features/latest_training/presentation/controller/latest_training_controller.dart';
import 'package:shramsansar/utils/shimmer/shimmer.dart';

class LatestTraining extends ConsumerWidget {
  const LatestTraining({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestTraining = ref.watch(latestTrainingControllerProvider);
    return latestTraining.when(data: (data) {
      return Column(
        children: [
          for (int a = 0; a < 10; a++) TrainingCard(model: data.data![a]),
        ],
      );
    }, error: (_, __) {
      return Text('error');
    }, loading: () {
      return ShimmerSkeleton(
        count: 3,
      );
    });
  }
}
