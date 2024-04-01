import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/caste/presentation/controller/caste_controller.dart';
import 'package:shramsansar/features/gender/presentation/controller/gender_controller.dart';
import 'package:shramsansar/features/getDistricts/presentation/controller/district_controller.dart';
import 'package:shramsansar/features/getMunicipalities/presentation/controller/municipality_controller.dart';
import 'package:shramsansar/features/getPradesh/presentation/controller/pradesh_controller.dart';
import 'package:shramsansar/features/getWardnumber/presentation/controller/ward_controller.dart';
import 'package:shramsansar/features/jobs/presentation/controller/job_catergory_controller.dart';
import 'package:shramsansar/utils/custom_form/custom_form.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _numberController = TextEditingController();
  late final TextEditingController _passwordConfirmationController =
      TextEditingController();

  String? selectedGender;
  int selectedGenderId = 0;

  String? selectedJobCategory;
  int? selectedJobCategoryId;

  String? selectedCaste;
  int? selectedCasteId = 0;

  //permanent address
  String? selectedPradesh;
  int selectedPradeshId = 0;

  String? selectedDistrict;
  int selectedDistrictId = 0;

  String? selectedMunicipality;
  int selectedMunicipalityId = 0;

  String? selectedWard;
  int selectedWardId = 0;

  //temporary address

  String? tSelectedPradesh;
  int tselectedPradeshId = 0;

  String? tSelectedDistrict;
  int tSelectedDistrictId = 0;

  String? tSelectedMunicipality;
  int tselectedMunicipalityId = 0;

  String? tSelectedWard;
  int tselectedWardId = 0;

  //check box
  bool isCheckBoxSelected = false;

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Register here'),
      ),
      body: FutureBuilder(
          future: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Placeholder for loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Handle error state
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CustomTextformFormField(
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        isLablerequire: true,
                        hintText: 'Name',
                        isFieldrequired: true,
                      ),
                      CustomTextformFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        isLablerequire: true,
                        hintText: 'E-mail',
                        isFieldrequired: true,
                      ),
                      CustomTextformFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        isLablerequire: true,
                        hintText: 'Password',
                        isFieldrequired: true,
                      ),
                      CustomTextformFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordConfirmationController,
                        textInputAction: TextInputAction.next,
                        isLablerequire: true,
                        hintText: 'Confirm Password',
                        isFieldrequired: true,
                      ),
                      CustomTextformFormField(
                        keyboardType: TextInputType.number,
                        controller: _numberController,
                        textInputAction: TextInputAction.next,
                        isLablerequire: true,
                        hintText: 'Mobile Number',
                        isFieldrequired: true,
                      ),
                      SizedBox(
                        height: 1.2.h,
                      ),
                      genderDropDown(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      jobCategoryDropDown(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      casteDropDown(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      const Text(
                        'Permanent address Details',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      getPradesh(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      districtsDropDown(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      getMuni(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      getWard(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      CheckboxListTile(
                          title: Text('Same as permanent'),
                          value: isCheckBoxSelected,
                          onChanged: (value) {
                            setState(() {
                              isCheckBoxSelected = !isCheckBoxSelected;
                              if (isCheckBoxSelected) {
                                //clear the selected things first
                                tSelectedPradesh = null;
                                tSelectedDistrict = null;

                                tSelectedMunicipality = null;
                                tSelectedWard = null;

                                tSelectedPradesh = selectedPradesh;
                                tSelectedDistrict = selectedDistrict;
                                tSelectedMunicipality = selectedMunicipality;
                                tSelectedWard = selectedWard;
                                tselectedPradeshId = selectedPradeshId;
                                log(selectedDistrict.toString());
                                log(tSelectedDistrict.toString());
                                //log(selectedPradesh.toString());
                                //log(selectedPradesh.toString());
                              } else {
                                tSelectedDistrict = null;
                                tSelectedPradesh = null;
                                tSelectedMunicipality = null;
                                tSelectedWard = null;
                              }
                            });
                          }),
                      const Text(
                        'Temporary address Details',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      tgetPradesh(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      tgetDistrict(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      tgetMuni(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      tgetWard(context),
                      SizedBox(
                        height: 2.1.h,
                      ),
                      InkWell(
                          onTap: () async {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String password_confirmation =
                                _passwordConfirmationController.text;
                            String number = _numberController.text;
                            int gender = selectedGenderId;

                            //permanent address
                            int per_pradesh_id = selectedPradeshId;
                            int per_distric_id = selectedDistrictId;
                            int per_muni_id = selectedMunicipalityId;
                            int per_ward = selectedWardId;

                            if (name == '') {
                              return showCustomSnackBar(
                                  ' Please enter name', context);
                            }
                            if (password == '') {
                              return showCustomSnackBar(
                                  ' Please enter password', context);
                            }
                            if (password_confirmation == '') {
                              return showCustomSnackBar(
                                  ' Please re-enter password', context);
                            }
                            if (email == '') {
                              return showCustomSnackBar(
                                  ' Please enter email', context);
                            }
                            if (_numberController.text == '') {
                              return showCustomSnackBar(
                                  ' Please enter number', context);
                            }
                            if (number.length > 10) {
                              return showCustomSnackBar(
                                  'Number can not be greater than 10', context);
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColorConst.PRAYMARY_TEXT_COLOR),
                            child: Center(
                                child: Text(
                              'REGISTER',
                              style: TextStyle(color: Colors.white),
                            )),
                          ))
                    ],
                  ),
                ),
              );
            }
          }),
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
                      selectedWard = null;
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
              hint: const Text('Enter district'),
              value: selectedDistrict,
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
                  hint: const Text('Municipality'),
                  value: selectedMunicipality,
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
                          muni.indexOf(selectedMunicipality!)+1;
                    });
                  }),
            );
          },
        ));
  }

  getWard(BuildContext context) {
    var getWard = ref.watch(wardControllerProvider);
    List<String> wardNo = [];
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Consumer(
        builder: (context, watch, ref) {
          getWard.when(
              data: (data) {
                for (var model in data.data) {
                  wardNo.add(model.ward_no);
                }
              },
              error: (error, stack) => Text(error.toString()),
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  ));
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
                hint: const Text('Ward'),
                value: selectedWard,
                items: wardNo.map((name) {
                  return DropdownMenuItem(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedWard = value;
                  });
                }),
          );
        },
      ),
    );
  }

  tgetPradesh(BuildContext context) {
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
                  hint: const Text('Pradesh'),
                  value: tSelectedPradesh,
                  items: pradesh.map((name) {
                    return DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      tSelectedPradesh = value;
                      isCheckBoxSelected = false;

                      tSelectedDistrict = null;
                      tSelectedMunicipality = null;
                      tSelectedWard = null;

                      tselectedPradeshId =
                          pradesh.indexOf(tSelectedPradesh!) + 1;
                    });
                  }),
            );
          },
        ));
  }

  tgetDistrict(BuildContext context) {
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
                  if (model.pradesh_id == tselectedPradeshId.toString()) {
                    districts.add(model.name);
                  }
                }
              },
              error: (error, stack) => Text(error.toString()),
              loading: () => const Center(child: CircularProgressIndicator()));
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              hint: const Text('Enter district'),
              value: tSelectedDistrict,
              items: districts.map((distict) {
                return DropdownMenuItem(
                  value: distict,
                  child: Text(distict),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  tSelectedDistrict = newValue;
                  isCheckBoxSelected = false;

                  tSelectedMunicipality = null;
                  tSelectedDistrictId =
                      districts.indexOf(tSelectedDistrict!) + 1;
                });
              },
            ),
          );
        },
      ),
    );
  }

  tgetMuni(BuildContext context) {
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
                  hint: const Text('Municipality'),
                  value: tSelectedMunicipality,
                  items: muni.map((name) {
                    return DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      tSelectedMunicipality = value;
                      isCheckBoxSelected = false;
                    });
                  }),
            );
          },
        ));
  }

  tgetWard(BuildContext context) {
    var getWard = ref.watch(wardControllerProvider);
    List<String> wardNo = [];
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Consumer(
        builder: (context, watch, ref) {
          getWard.when(
              data: (data) {
                for (var model in data.data) {
                  wardNo.add(model.ward_no);
                }
              },
              error: (error, stack) => Text(error.toString()),
              loading: () => Center(
                    child: CircularProgressIndicator(),
                  ));
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
                hint: const Text('Ward'),
                value: tSelectedWard,
                items: wardNo.map((name) {
                  return DropdownMenuItem(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    tSelectedWard = value;
                    isCheckBoxSelected = false;
                  });
                }),
          );
        },
      ),
    );
  }

  casteDropDown(BuildContext context) {
    log(selectedPradeshId.toString());
    var getCaste = ref.watch(casteControllerProvicer);
    List<String> caste = [];
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xffF1F1F1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Consumer(
          builder: (context, watch, child) {
            getCaste.when(
                data: (data) {
                  for (var model in data.data) {
                    caste.add(model.name);
                  }
                },
                error: (error, stack) => Text(error.toString()),
                loading: () =>
                    const Center(child: CircularProgressIndicator()));
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                  hint: const Text('Caste'),
                  value: selectedCaste,
                  items: caste.map((name) {
                    return DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCaste = value;
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
                  hint: const Text('Place of interest'),
                  onChanged: (String? value) {
                    setState(() {
                      selectedJobCategory = value;
                    });
                  },
                  value: selectedJobCategory ??
                      (jobCate.isEmpty ? jobCate[0] : null),
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

  genderDropDown(BuildContext context) {
    var gen = ref.watch(genderControllerProvider);
    List<String> itemGender = [];

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Consumer(
        builder: (context, watch, child) {
          gen.when(
            data: (data) {
              for (var model in data.data) {
                itemGender.add(model.gender);
              }
              // log(itemGender
              //     .toString()); // Optionally, you can log the itemGender list here
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          );

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              hint: const Text('Gender'),
              value: selectedGender,
              items: itemGender.map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
