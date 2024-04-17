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
    return Expanded(
      child: latestTraining.when(data: (data) {
        return ListView.builder(
            itemCount: 10, // returns all data so displaying first 10 only
            itemBuilder: (_, index) {
              var trainingData = data.data![index];
              return TrainingCard(model: trainingData);
            });
      }, error: (obj, trace) {
        return Center(child: Text(obj.toString()));
      }, loading: () {
        return const Center(
            child: ShimmerSkeleton(
          count: 3,
        ));
      }),
    );
  }
}
