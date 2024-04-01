import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/const/app_const.dart';
import 'package:shramsansar/features/all_jobs/data/models/all_jobs_model.dart';
import 'package:shramsansar/features/all_jobs/presentation/controller/all_jobs_controller.dart';
import 'package:shramsansar/features/all_jobs/presentation/views/all_jobs_list.dart';
import 'package:shramsansar/features/getDistricts/data/models/district_model.dart';
import 'package:shramsansar/features/getDistricts/presentation/controller/district_controller.dart';
import 'package:shramsansar/features/getMunicipalities/data/models/municipality_model.dart';
import 'package:shramsansar/features/getMunicipalities/presentation/controller/municipality_controller.dart';
import 'package:shramsansar/features/getPradesh/data/models/pradeshModel.dart';
import 'package:shramsansar/features/getPradesh/presentation/controller/pradesh_controller.dart';
import 'package:shramsansar/features/jobs/data/models/job_category_model.dart';
import 'package:shramsansar/features/jobs/presentation/controller/job_catergory_controller.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class AllJobs extends ConsumerStatefulWidget {
  const AllJobs({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllJobsState();
}

class _AllJobsState extends ConsumerState<AllJobs> {
  String? selectedJobCategory;
  int? selectedJobCategoryId;

  String? selectedPradesh;
  int selectedPradeshId = 0;

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

  AllJobsModel? allJobsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Jobs'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getPradesh(context),
            SizedBox(
              height: 10,
            ),
            districtsDropDown(context),
            SizedBox(
              height: 10,
            ),
            getMuni(context),
            SizedBox(
              height: 10,
            ),
            jobCategoryDropDown(context),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(),
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Related Jobs',
              style: TextStyle(
                  color: AppColorConst.BUTTON_BLUE_COLOR, fontSize: 18),
            ),
            Container(
              decoration: BoxDecoration(color: AppColorConst.BUTTON_BLUE_COLOR),
              width: MediaQuery.sizeOf(context).width,
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
            viewAllJobsList(context),
          ],
        ),
      )),
    );
  }

  viewAllJobsList(BuildContext context) {
    var addList = ref.watch(allJobsControllerProvider.notifier);
    var jobsList = ref.watch(allJobsControllerProvider);
    return Container(
      child: Column(
        children: [
          Consumer(builder: (context, watch, child) {
            addList.addAllJobs();
            jobsList.when(
                data: (data) {
                  log('inside data');
                },
                error: (error, stack) => Text(error.toString()),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
            return Container(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Text('ss');
                },
              ),
            );
          }),
          Text('This is bad'),
        ],
      ),
    );
  }

  getJobs(BuildContext context) {
    if (muniModel != null && muniModel!.data.isNotEmpty) {
      // Iterate over the data list and access the muni_id of each DataModel
      for (var dataModel in muniModel!.data) {
        muniId = dataModel.muni_id;
        // Now you can use the muniId as needed
        print('Muni ID: $muniId');
      }
    } else {
      print('Municipality model is null or data is empty');
    }
    if (pradeshModel != null && pradeshModel!.data.isNotEmpty) {
      for (var dataModel in pradeshModel!.data) {
        pradeshId = dataModel.id;

        print('Muni ID: $pradeshId');
      }
    } else {
      print('Municipality model is null or data is empty');
    }
    if (jobCategoryModel != null && jobCategoryModel!.data.isNotEmpty) {
      for (var dataModel in jobCategoryModel!.data) {
        jobcategoryId = dataModel.id;

        print('Muni ID: $jobcategoryId');
      }
    } else {
      print('Municipality model is null or data is empty');
    }
    if (districtModel != null && districtModel!.data.isNotEmpty) {
      for (var dataModel in districtModel!.data) {
        districtId = dataModel.id;

        print('Muni ID: $districtId');
      }
    } else {
      print('Municipality model is null or data is empty');
    }
    var getJobs = ref.watch(allJobsControllerProvider.notifier);

    return ListView.builder(
      itemCount: allJobsModel!.meta!.links!.length,
      itemBuilder: (BuildContext context, int index) {
        List<LinksMeta>? linkList = allJobsModel!.meta!.links!;
        LinksMeta linkMeta = allJobsModel!.meta!.links![index];
        int lastItemIndexNumber = linkList.length - 1;
        if (index == 0) {
          getJobs.getAllJobs(
              pageId, muniId, jobcategoryId, pradeshId, districtId);
        } else {
          showCustomSnackBar('Error', context);
        }
      },
    );
  }

  myBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColorConst.WHAIT,
      border: Border.all(
        color: AppColorConst.PRAYMARY_TEXT_COLOR,
        width: 1,
      ),
    );
  }

  selectNextButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: AppColorConst.TEXT_GRAY_COLOR_LOW,
      border: Border.all(
        color: AppColorConst.TEXT_GRAY_COLOR_LOW,
        width: 1,
      ),
    );
  }

  unselectNextButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: AppColorConst.WHAIT,
      border: Border.all(
        color: AppColorConst.TEXT_GRAY_COLOR_LOW,
        width: 1,
      ),
    );
  }

  selectPossitionButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: AppColorConst.WHAIT,
      border: Border.all(
        color: AppColorConst.PRAYMARY_TEXT_COLOR,
        width: 2,
      ),
    );
  }

  unselectPossitionButtonBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      color: AppColorConst.WHAIT,
      border: Border.all(
        color: AppColorConst.TEXT_GRAY_COLOR,
        width: 1,
      ),
    );
  }

  getPradesh(BuildContext context) {
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
                  if (model.pradesh_id == selectedPradeshId.toString()) {
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
              onChanged: (newValue) {
                setState(() {
                  selectedDistrict = newValue;
                  selectedMunicipality = null;
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
                    if (model.district_id == selectedDistrictId.toString()) {
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
                  data.data.map((model) => model.name).toList();
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
