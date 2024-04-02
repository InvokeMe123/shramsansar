import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/commons/pagination_card.dart';
import 'package:shramsansar/commons/training_card.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/const/app_const.dart';
import 'package:shramsansar/features/getDistricts/data/models/district_model.dart';
import 'package:shramsansar/features/getDistricts/presentation/controller/district_controller.dart';
import 'package:shramsansar/features/getMunicipalities/data/models/municipality_model.dart';
import 'package:shramsansar/features/getMunicipalities/presentation/controller/municipality_controller.dart';
import 'package:shramsansar/features/getPradesh/data/models/pradeshModel.dart';
import 'package:shramsansar/features/getPradesh/presentation/controller/pradesh_controller.dart';
import 'package:shramsansar/features/jobs/data/models/job_category_model.dart';
import 'package:shramsansar/features/jobs/presentation/controller/job_catergory_controller.dart';
import 'package:shramsansar/features/trainings/presentation/controller/view_all_training_controller.dart';
import 'package:shramsansar/features/trainings/provider/page_index_provider.dart';

class TrainingPage extends ConsumerStatefulWidget {
  const TrainingPage({super.key});

  @override
  ConsumerState<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends ConsumerState<TrainingPage> {
  String? selectedJobCategory;
  int? selectedJobCategoryId;

  String? selectedPradesh;
  int selectedPradeshId = 1;

  String? selectedDistrict;
  int selectedDistrictId = 0;

  String? selectedMunicipality;
  int selectedMunicipalityId = 0;

  int pageId = 1;

  PradeshModel? pradeshModel;
  MunicipalityModel? muniModel;
  JobCategoryModel? jobCategoryModel;
  DistrictModel? districtModel;
  int? muniId;
  int? jobcategoryId;
  int? pradeshId;
  int? districtId;

  bool isPradeshSelected = true;
  bool isDistrictSelected = false;
  bool isMunicipalitySelected = false;

  @override
  Widget build(BuildContext context) {
    int pageIndex = ref.watch(pageIndexProvider);

    final result = ref.watch(viewAllTrainingControllerProvider(pageIndex));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training'),
      ),
      body: Column(
        children: [
          getPradesh(context),
          SizedBox(height: 1.h),
          districtsDropDown(context),
          SizedBox(height: 1.h),
          getMuni(context),
          SizedBox(height: 1.h),
          jobCategoryDropDown(context),
          SizedBox(height: 1.h),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius
                          .zero, // Set the border radius to zero for a rectangular shape
                    ),
                    backgroundColor: AppColorConst.BUTTON_BLUE_COLOR),
                onPressed: () async {},
                child: Text(
                  'Apply',
                  style: TextStyle(color: AppColorConst.WHAIT),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // all trainings
          const Text("All training"),

          Expanded(
            child: result.when(
                data: (data) {
                  if (data.data!.isEmpty) {
                    return const Center(child: Text("No data found"));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.data!.length,
                            itemBuilder: (_, index) {
                              var trainingData = data.data![index];

                              return TrainingCard(model: trainingData);
                            }),
                      ),
                      PaginationCard(totalItems: data.meta?.total ?? 10),
                    ],
                  );
                },
                error: (_, __) {
                  return Text("he");
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }

  Widget getPradesh(BuildContext context) {
    var getPradesh = ref.watch(pradeshControllerProvider);
    List<String> pradesh = [];

    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xffF1F1F1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Consumer(
          builder: (context, watch, child) {
            getPradesh.when(
                data: (data) {
                  for (var model in data.data) {
                    pradesh.add(model.name);
                  }
                },
                error: (error, stack) => Text(error.toString()),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                  icon: Padding(
                    padding: EdgeInsets.only(
                        left: 203), // Adjust the left padding as needed
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  hint: const Text('Pradesh'),
                  value:
                      selectedPradesh ?? (pradesh.isEmpty ? null : pradesh[0]),
                  items: pradesh.map((name) {
                    return DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedPradesh = value;
                      selectedDistrict = null;
                      selectedMunicipality = null;

                      selectedPradeshId = pradesh.indexOf(selectedPradesh!) + 1;
                    });
                  }),
            );
          },
        ));
  }

  districtsDropDown(BuildContext context) {
    var getDistricts = ref.watch(districtControllerProvider);
    List<String> districts = [];
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Consumer(
        builder: (context, watch, child) {
          getDistricts.when(
              data: (data) {
                for (var model in data.data) {
                  if (model.pradesh_id == selectedPradeshId) {
                    districts.add(model.name);
                  }
                }
              },
              error: (error, stack) => Text(error.toString()),
              loading: () => const Center(child: CircularProgressIndicator()));
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              icon: Padding(
                padding: EdgeInsets.only(
                    left: 210), // Adjust the left padding as needed
                child: Icon(Icons.arrow_drop_down),
              ),
              hint: const Text('Enter district'),
              value:
                  selectedDistrict ?? (districts.isEmpty ? null : districts[0]),
              items: districts.map((distict) {
                return DropdownMenuItem(
                  value: distict,
                  child: Text(distict),
                );
              }).toList(),
              onTap: () {
                debugPrint(districts.toString());
              },
              onChanged: (newValue) {
                setState(() {
                  selectedDistrict = newValue;
                  selectedMunicipality = null;
                  isDistrictSelected = true;
                  selectedDistrictId = districts.indexOf(selectedDistrict!) + 1;
                });
              },
            ),
          );
        },
      ),
    );
  }

  getMuni(BuildContext context) {
    var getMuni = ref.watch(muniControllerProvider);
    List<String> muni = [];
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xffF1F1F1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Consumer(
          builder: (context, watch, child) {
            getMuni.when(
                data: (data) {
                  for (var model in data.data) {
                    if (model.district_id == selectedDistrictId) {
                      muni.add(model.name);
                    }
                  }
                },
                error: (error, stack) => Text(error.toString()),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                        left: 145), // Adjust the left padding as needed
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  hint: const Text('Municipality'),
                  value:
                      selectedMunicipality ?? (muni.isEmpty ? null : muni[0]),
                  items: muni.map((name) {
                    return DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMunicipality = value;
                      isMunicipalitySelected = true;
                      selectedMunicipalityId =
                          muni.indexOf(selectedMunicipality!) + 1;
                    });
                  }),
            );
          },
        ));
  }

  jobCategoryDropDown(BuildContext context) {
    var jobCat = ref.watch(jobcontrollerProvider);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Consumer(
        builder: (context, watch, child) {
          return jobCat.when(
            data: (data) {
              List<String> jobCate =
                  data.data.map((model) => model.name).toSet().toList();

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButton<String>(
                  icon: Padding(
                    padding: const EdgeInsets.only(
                        left: 75), // Adjust the left padding as needed
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  hint: const Text('Place of interest'),
                  onChanged: (String? value) {
                    setState(() {
                      selectedJobCategory = value;
                    });
                  },
                  value: selectedJobCategory ??
                      (jobCate.isEmpty
                          ? AppConst.selectJobCategory
                          : jobCate[0]),
                  items: jobCate.map((name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                ),
              );
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
