import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/core/dbclient.dart';

import 'package:shramsansar/features/all_jobs/data/models/latest_job_model.dart';
import 'package:shramsansar/utils/snackbar/custome_snack_bar.dart';

class LatestJobDisplay extends StatefulWidget {
  final Data dataModel;
  const LatestJobDisplay({super.key, required this.dataModel});

  @override
  State<LatestJobDisplay> createState() => _LatestJobDisplayState();
}

class _LatestJobDisplayState extends State<LatestJobDisplay> {
  String filePath1 = '';
  String fileName = '';
  FormData formData = FormData();

  void cvUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.single.path!;
      String filename = result.files.single.name;
      setState(() {
        filePath1 = filePath;
        fileName = filename;
      });
    }
    //log(fileName);
    //log(filePath1);
  }

  void applyForJob() async {
    log(filePath1);
    if (filePath1.isEmpty) {
      showCustomSnackBar('Please Upload the CV first', context);
    } else {
      formData.files.add(MapEntry(
          'cv', MultipartFile.fromFileSync(filePath1, filename: fileName)));
    }
    String token = '';
    int id = widget.dataModel.id!;
    token = await DbClient().getData(dbKey: 'token');
    log(token);
    log("${ApiConst.JOB_APPLAY_F}$id${ApiConst.JOB_APPLAY_L}");
    BaseOptions options = BaseOptions(baseUrl: ApiConst.URL, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    Dio dio = Dio(options);
    log(formData.files.toString());

    if (formData.files.isEmpty) {
      log('applied');
      var response = await dio.post(
        '${ApiConst.JOB_APPLAY_F}$id${ApiConst.JOB_APPLAY_L}',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );

      if (response.statusCode == 200) {
        Map map = response.data;
        fileName = '';
        filePath1 = '';
        Navigator.pop(context);
        setState(() {});
        String mm = map['message'];
        if (mm == 'Already Applied') {
          showCustomSnackBar(map['message'], context, isError: true);
        } else {
          String m = map['message'];
          showCustomSnackBar(m, context, isError: false);
        }
      }
    } else {
      var response = await dio.post(
        '${ApiConst.JOB_APPLAY_F}$id${ApiConst.JOB_APPLAY_L}',
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! <= 500;
            }),
      );
      if (response.statusCode == 200) {
        Map map = response.data;
        fileName = '';
        filePath1 = '';
        Navigator.pop(context);
        setState(() {});
        String mm = map['message'];
        if (mm == 'Already Applied') {
          showCustomSnackBar(map['message'], context, isError: true);
        } else {
          String m = map['message'];
          showCustomSnackBar(m, context, isError: false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    width: 20.w,
                    image: NetworkImage('${ApiConst.IMAGE_URL}${widget.dataModel.serviceProvider!.logo}')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.dataModel.title.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColorConst.BUTTON_BLUE_COLOR)),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(
                            '${widget.dataModel.serviceProvider!.districtName!},${widget.dataModel.serviceProvider!.muniName!}',
                            style:
                                const TextStyle(color: CupertinoColors.systemGrey)),
                      ],
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Deadline :',
                          style:
                              TextStyle(color: CupertinoColors.destructiveRed)),
                      TextSpan(
                          text: '  ${widget.dataModel.deadline}',
                          style: const TextStyle(color: CupertinoColors.systemGrey))
                    ]))
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cvUpload();
                      },
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColorConst.BUTTON_BLUE_COLOR),
                              color: AppColorConst.BUTTON_BLUE_COLOR),
                          child: const Text(
                            'CV upload',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        applyForJob();
                      },
                      child: const Text('Apply Now'),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Text(
              "Company's details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            Text(widget.dataModel.serviceProviderName.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                    color: CupertinoColors.systemGrey)),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                const SizedBox(
                  width: 6,
                ),
                Text(widget.dataModel.districtName.toString(),
                    style: const TextStyle(fontSize: 12)),
                Text(", ${widget.dataModel.muniName}",
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(Icons.phone_outlined, size: 18),
                const SizedBox(
                  width: 6,
                ),
                Text(widget.dataModel.serviceProvider!.mobile.toString(),
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 18),
                const SizedBox(
                  width: 6,
                ),
                Text(widget.dataModel.serviceProvider!.email.toString(),
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Test details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                Text(widget.dataModel.districtName.toString(),
                    style: const TextStyle(fontSize: 12)),
                Text(", ${widget.dataModel.muniName}",
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(Icons.people_alt_outlined, size: 18),
                Text(widget.dataModel.address.toString(),
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(Icons.calendar_month_outlined, size: 18),
                Text("${widget.dataModel.description} ",
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                Text(
                    "${widget.dataModel.deadline} - ${widget.dataModel.engDeadline}",
                    style: const TextStyle(fontSize: 12))
              ],
            ),
            Html(
              data: widget.dataModel.description.toString(),
              shrinkWrap: true,
              style: {
                "*": Style(
                  fontSize: FontSize(12),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
