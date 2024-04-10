import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/core/api_client/api_client.dart';
import 'package:shramsansar/features/training_center/data/data_source/training_center_data_source.dart';
import 'package:shramsansar/features/training_center/presentation/controller/training_center_controller.dart';

class TrainingCenters extends ConsumerWidget {
  const TrainingCenters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingCenters = ref.watch(trainingCenterControllerProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('Training Centers')),
        body: trainingCenters.when(data: (data) {
          final trainingCenters = data.data;

          return ListView.builder(
              itemCount: trainingCenters!.length,
              itemBuilder: (context, index) {
                final trainingCenter = trainingCenters[index];
                return ListTile(
                  title: Text(trainingCenter.name.toString()),
                  subtitle: Text(trainingCenter.districtName.toString()),
                );
              });
        }, error: (error, _) {
          return Center(child: Text(error.toString()));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
