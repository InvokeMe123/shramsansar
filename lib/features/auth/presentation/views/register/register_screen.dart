import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/dashboard.dart';

import 'package:shramsansar/features/auth/presentation/controller/register_controller.dart/register_controller.dart';
import 'package:shramsansar/features/auth/presentation/views/register/widgets/national_id_card_button.dart';
import 'package:shramsansar/features/auth/presentation/views/register/widgets/skills_drop_down.dart';
import 'package:shramsansar/features/caste/presentation/controller/caste_controller.dart';
import 'package:shramsansar/features/gender/presentation/controller/gender_controller.dart';
import 'package:shramsansar/features/getDistricts/presentation/controller/district_controller.dart';
import 'package:shramsansar/features/getDocumentType/data/models/document_type_model.dart';
import 'package:shramsansar/features/getDocumentType/presentation/controller/document_type_controller.dart';
import 'package:shramsansar/features/getMunicipalities/presentation/controller/municipality_controller.dart';
import 'package:shramsansar/features/getPradesh/presentation/controller/pradesh_controller.dart';
import 'package:shramsansar/features/getWardnumber/presentation/controller/ward_controller.dart';
import 'package:shramsansar/features/jobs/presentation/controller/job_catergory_controller.dart';
import 'package:shramsansar/features/profile/presentation/controller/profile_controller.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  String? selectedGender;
  int selectedGenderId = 0;

  String? selectedJobCategory;
  int selectedJobCategoryId = -1;

  String? selectedCaste;
  int selectedCasteId = 0;

  int selectedDocumentTypeID = -1;

  //permanent address
  String? selectedPradesh;
  int selectedPradeshId = -1;

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

  // required text field
  List<Map<String, dynamic>> requiredTextField = [
    {"title": "Name", "controller": TextEditingController()},
    {"title": "Email", "controller": TextEditingController()},
    {"title": "Password", "controller": TextEditingController()},
    {"title": "Confirm Password", "controller": TextEditingController()},
    {"title": "Mobile Number", "controller": TextEditingController()},
  ];

  final _formKey = GlobalKey<FormState>();

  String imagePath = "";
  FormData formData = FormData();

  final otherSkillsController = TextEditingController();

  List<String> selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register here'),
      ),
      body: FutureBuilder(
          future: null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Placeholder for loading state
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Handle error state
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        for (var item in requiredTextField) ...[
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: item['controller'],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: "${item['title']} *",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter ${item['title']}';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 1.2.h),
                        ],

                        genderDropDown(context),
                        SizedBox(
                          height: 2.1.h,
                        ),

                        ref.read(jobCategoryControllerProvider).when(
                          data: (data) {
                            return TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Select your skills",
                              ),
                              textInputAction: TextInputAction.next,
                              controller: TextEditingController(
                                  text: selectedSkills.join(', ')),
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                final result = await showDialog<List<String>>(
                                    context: context,
                                    builder: (_) {
                                      return SkillsDropDown(
                                        options: data.data
                                            .map((model) => model.name)
                                            .toSet()
                                            .toList(),
                                      );
                                    });

                                if (result!.isNotEmpty) {
                                  setState(() {
                                    selectedSkills = result;
                                  });
                                }
                              },
                            );
                          },
                          error: (error, stackTrace) {
                            log(error.toString());
                            return const SizedBox();
                          },
                          loading: () {
                            return const CircularProgressIndicator();
                          },
                        ),

                        SizedBox(
                          height: 2.1.h,
                        ),

                        TextFormField(
                          controller: otherSkillsController,
                          decoration: const InputDecoration(
                            hintText: 'Other Skills',
                          ),
                        ),

                        SizedBox(
                          height: 2.1.h,
                        ),
                        casteDropDown(context),
                        SizedBox(
                          height: 2.1.h,
                        ),

                        // National ID card
                        NationalIdCardButton(
                          imagePath: (path) {
                            imagePath = path;

                            formData.files.add(MapEntry(
                                "document_type_file",
                                MultipartFile.fromFileSync(
                                  path,
                                  filename: path.split('/').last,
                                )));
                          },
                        ),

                        SizedBox(height: 2.1.h),

                        documentTypeDropDown(context),

                        SizedBox(height: 3.5.h),

                        const Text(
                          'Permanent address Details *',
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

                        CheckboxListTile(
                            title: const Text('Same as permanent'),
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
                                  tSelectedDistrictId = selectedDistrictId;
                                  tselectedMunicipalityId =
                                      selectedMunicipalityId;
                                  tselectedWardId = selectedWardId;
                                } else {
                                  tSelectedDistrict = null;
                                  tSelectedPradesh = null;
                                  tSelectedMunicipality = null;
                                  tSelectedWard = null;
                                }
                              });
                            }),

                        SizedBox(
                          height: 1.h,
                        ),
                        const Text(
                          'Temporary address Details',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          height: 2.4.h,
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
                          height: 3.5.h,
                        ),
                        InkWell(
                            onTap: () async {
                              // loop over the required text field to find if the value is missing
                              // for (var item in requiredTextField) {
                              //   if (item['controller'].text == '') {
                              //     return showCustomSnackBar(
                              //         'Please enter ${item['title']}', context);
                              //   }
                              //   if (item["title"] == "Mobile Number") {
                              //     if (item['controller'].text.length != 10) {
                              //       return showCustomSnackBar(
                              //           'Mobile number must be equal to 10 digit',
                              //           context);
                              //     }
                              //   }
                              // }

                              bool isRequiredFieldValid = _formKey.currentState!
                                  .validate(); // validate the form

                              if (isRequiredFieldValid) {
                                // register request model write in map
                                final formData = FormData.fromMap({
                                  "name":
                                      requiredTextField[0]['controller'].text,
                                  "email":
                                      requiredTextField[1]['controller'].text,
                                  "password":
                                      requiredTextField[2]['controller'].text,
                                  "password_confirmation":
                                      requiredTextField[3]['controller'].text,
                                  "per_pradesh_id": selectedPradeshId,
                                  "per_district_id": selectedDistrictId,
                                  "per_muni_id": selectedMunicipalityId,
                                  "per_ward": selectedWardId,
                                  "pradesh_id": tselectedPradeshId,
                                  "district_id": tSelectedDistrictId,
                                  "muni_id": tselectedMunicipalityId,
                                  "ward": tselectedWardId,
                                  "mobile": int.parse(
                                      requiredTextField[4]['controller'].text),
                                  "document_type": selectedDocumentTypeID,
                                  "document_type_file": imagePath.isEmpty
                                      ? ""
                                      : MultipartFile.fromFileSync(imagePath,
                                          filename: imagePath.split('/').last),
                                  "gender": selectedGenderId,
                                  "other_skills": otherSkillsController.text,
                                  "ethnicity_type": selectedCasteId,
                                });

                                for (int a = 0;
                                    a < selectedSkills.length;
                                    a++) {
                                  formData.fields.add(MapEntry(
                                      "preference_job_cat[$a]",
                                      selectedSkills[a]));
                                }
                                ref
                                    .read(registerControllerProvider.notifier)
                                    .registerWithFormData(
                                        formData: formData, context: context)
                                    .then((value) async {
                                  if (value) {
                                    ref
                                        .read(
                                            profileControllerProvider.notifier)
                                        .getMyProfile()
                                        .then((_) {
                                      pushAndRemoveUntil(
                                          context, const Dashboard());
                                    });
                                  } else {
                                    showCustomSnackBar(
                                        "Something went wrong", context);
                                  }
                                }).onError((error, stackTrace) {
                                  showCustomSnackBar(
                                      "Something went wrong.", context);
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColorConst.PRAYMARY_TEXT_COLOR),
                              child: const Center(
                                  child: Text(
                                'REGISTER',
                                style: TextStyle(color: Colors.white),
                              )),
                            ))
                      ],
                    ),
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

    return Consumer(
      builder: (context, watch, child) {
        getPradesh.when(
            data: (data) {
              for (var model in data.data) {
                pradesh.add(model.name);
              }
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()));
        return DropdownButtonFormField<String>(
            hint: const Text('Pradesh'),
            validator: (value) {
              if (value == null) {
                return 'Please select pradesh';
              }
              return null;
            },
            value: selectedPradesh,
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
            });
      },
    );
  }

  districtsDropDown(BuildContext context) {
    var getDistricts = ref.watch(districtControllerProvider);
    List<String> districts = [];
    return Consumer(
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
        return DropdownButtonFormField<String>(
          hint: const Text('Enter district'),
          value: selectedDistrict,
          validator: (value) {
            if (value == null) {
              return 'Please select district';
            }
            return null;
          },
          items: districts.map((distict) {
            return DropdownMenuItem(
              value: distict,
              child: Text(distict),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedDistrict = newValue;
              selectedDistrictId = districts.indexOf(selectedDistrict!) + 1;
            });
          },
        );
      },
    );
  }

  getMuni(BuildContext context) {
    var getMuni = ref.watch(muniControllerProvider);
    List<String> muni = [];
    return Consumer(
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
            loading: () => const Center(child: CircularProgressIndicator()));
        return DropdownButtonFormField<String>(
            hint: const Text('Municipality'),
            value: selectedMunicipality,
            validator: (value) {
              if (value == null) {
                return 'Please select Municipality';
              }
              return null;
            },
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
            });
      },
    );
  }

  getWard(BuildContext context) {
    var getWard = ref.watch(wardControllerProvider);
    List<String> wardNo = [];
    return Consumer(
      builder: (context, watch, ref) {
        getWard.when(
            data: (data) {
              for (var model in data.data) {
                wardNo.add(model.ward_no);
              }
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ));
        return DropdownButtonFormField<String>(
            hint: const Text('Ward'),
            value: selectedWard,
            validator: (value) {
              if (value == null) {
                return 'Please select Ward';
              }
              return null;
            },
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
              selectedWardId = wardNo.indexOf(selectedWard!) + 1;
            });
      },
    );
  }

  tgetPradesh(BuildContext context) {
    var getPradesh = ref.watch(pradeshControllerProvider);
    List<String> pradesh = [];

    return Consumer(
      builder: (context, watch, child) {
        getPradesh.when(
            data: (data) {
              for (var model in data.data) {
                pradesh.add(model.name);
              }
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()));
        return DropdownButtonFormField<String>(
            hint: const Text('Pradesh'),
            value: tSelectedPradesh,
            validator: (value) {
              if (value == null) {
                return 'Please select pradesh';
              }
              return null;
            },
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

                tselectedPradeshId = pradesh.indexOf(tSelectedPradesh!) + 1;
              });
            });
      },
    );
  }

  tgetDistrict(BuildContext context) {
    var getDistricts = ref.watch(districtControllerProvider);
    List<String> districts = [];
    return Consumer(
      builder: (context, watch, child) {
        getDistricts.when(
            data: (data) {
              for (var model in data.data) {
                if (model.pradesh_id == tselectedPradeshId) {
                  districts.add(model.name);
                }
              }
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()));
        return DropdownButtonFormField<String>(
          hint: const Text('Enter district'),
          value: tSelectedDistrict,
          validator: (value) {
            if (value == null) {
              return 'Please select district';
            }
            return null;
          },
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

              tSelectedDistrictId = districts.indexOf(tSelectedDistrict!) + 1;
            });
          },
        );
      },
    );
  }

  tgetMuni(BuildContext context) {
    var getMuni = ref.watch(muniControllerProvider);
    List<String> muni = [];
    return Consumer(
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
            loading: () => const Center(child: CircularProgressIndicator()));
        return DropdownButtonFormField<String>(
            hint: const Text('Municipality'),
            value: tSelectedMunicipality,
            validator: (value) {
              if (value == null) {
                return 'Please select municipality';
              }
              return null;
            },
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
            });
      },
    );
  }

  tgetWard(BuildContext context) {
    var getWard = ref.watch(wardControllerProvider);
    List<String> wardNo = [];
    return Consumer(
      builder: (context, watch, ref) {
        getWard.when(
            data: (data) {
              for (var model in data.data) {
                wardNo.add(model.ward_no);
              }
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ));
        return DropdownButtonFormField<String>(
            hint: const Text('Ward'),
            value: tSelectedWard,
            validator: (value) {
              if (value == null) {
                return 'Please select ward';
              }
              return null;
            },
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
            });
      },
    );
  }

  casteDropDown(BuildContext context) {
    var getCaste = ref.watch(casteControllerProvicer);
    List<String> caste = [];
    return Consumer(
      builder: (context, watch, child) {
        getCaste.when(
            data: (data) {
              for (var model in data.data) {
                caste.add(model.name);
              }
            },
            error: (error, stack) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator()));
        return DropdownButtonFormField<String>(
            hint: const Text('Caste *'),
            value: selectedCaste,
            validator: (value) {
              if (value == null) {
                return 'Please select caste';
              }
              return null;
            },
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

              selectedCasteId = caste.indexOf(selectedCaste!) + 1;
            });
      },
    );
  }

  documentTypeDropDown(BuildContext context) {
    List<Data> documentTypes = [];
    ref.read(documentTypeControllerProvider).when(
        data: (data) {
          documentTypes = data.data!;
        },
        error: (error, stackTrace) {},
        loading: () => const SizedBox());

    return DropdownButtonFormField<String>(
      hint: const Text('Document Type'),
      items: documentTypes.map((doc) {
        return DropdownMenuItem<String>(
          value: doc.name,
          child: Text(doc.name.toString()),
        );
      }).toList(),
      onChanged: (String? value) {
        selectedDocumentTypeID =
            documentTypes.firstWhere((element) => element.name == value).id!;
      },
    );
  }

  genderDropDown(BuildContext context) {
    var gen = ref.watch(genderControllerProvider);
    List<String> itemGender = [];

    return Consumer(
      builder: (context, watch, child) {
        gen.when(
          data: (data) {
            for (var model in data.data) {
              itemGender.add(model.gender);
            }
          },
          error: (error, stack) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );

        return DropdownButtonFormField<String>(
          hint: const Text('Gender *'),
          value: selectedGender,
          validator: (value) {
            if (value == null) {
              return 'Please select gender';
            }
            return null;
          },
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
            selectedGenderId = itemGender.indexOf(selectedGender!) + 1;
          },
        );
      },
    );
  }
}
