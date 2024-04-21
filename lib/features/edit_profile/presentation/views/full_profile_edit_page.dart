import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/features/profile/data/model/profile_model.dart';

class FullProfileEditPage extends ConsumerStatefulWidget {
  final MyProfileModel model;
  const FullProfileEditPage(this.model, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FullProfileEditPageState();
}

class _FullProfileEditPageState extends ConsumerState<FullProfileEditPage> {
  //controllers
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController citizenNo = TextEditingController();
  TextEditingController pref = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.model.name!;
    phone.text = widget.model.mobile!;
    citizenNo.text = widget.model.citizenshipNo ?? '';
    // pref.text = widget.model.jobseekerPreferenceCategory!
    //     .map((e) => e.categoryName.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 1.2.h,
              ),
              TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(7),
                      label: Text("Name *"),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)))),
              SizedBox(
                height: 1.2.h,
              ),
              TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(7),
                      label: Text("Phone No. *"),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)))),
              SizedBox(
                height: 1.2.h,
              ),
              TextFormField(
                  controller: citizenNo,
                  decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(7),
                      label: Text("Citizenship No. *"),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)))),
              SizedBox(
                height: 1.2.h,
              ),
              TextFormField(
                  controller: pref,
                  // controller: widget.model.jobseekerPreferenceCategory
                  //     .map((e) => e.categoryName.toString()),
                  decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(7),
                      label: Text("Preferences *"),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)))),
                               SizedBox(
                height: 1.2.h,
              ),
              TextFormField(
                  controller: pref,
                  // controller: widget.model.jobseekerPreferenceCategory
                  //     .map((e) => e.categoryName.toString()),
                  decoration: const InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(7),
                      label: Text("Preferences *"),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: .5)))),
            ],
          ),
        ),
      ),
    );
  }
}
