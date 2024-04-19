import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/features/training_center/data/data_source/training_center_data_source.dart';
import 'package:shramsansar/features/training_center/presentation/controller/training_center_controller.dart';
import 'package:shramsansar/features/training_center/presentation/views/widgets/training_center_card.dart';

class TrainingCenters extends ConsumerWidget {
  const TrainingCenters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingCenters = ref.watch(trainingCenterControllerProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('Training Centers')),
        body: trainingCenters.when(data: (data) {
          final trainingCenters = data.data;
          if (data.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          return ListView.builder(
              itemCount: trainingCenters!.length,
              itemBuilder: (context, index) {
                final trainingCenter = trainingCenters[index];
                return TrainingCenterCard(data: trainingCenter);
              });
        }, error: (error, _) {
          return Center(child: Text(error.toString()));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
