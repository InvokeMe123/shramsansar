import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/core/api_const/api_const.dart';
import 'package:shramsansar/features/training_center/data/model/training_centers_model.dart'
    as trainingCenter;
import 'package:shramsansar/features/training_center/presentation/views/widgets/bold_first_word.dart';

class TrainingCenterCard extends StatelessWidget {
  final trainingCenter.Data data;
  const TrainingCenterCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), side: const BorderSide()),
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                              radius: 34,
                              backgroundImage: NetworkImage(
                                  "${ApiConst.IMAGE_URL}${data.logo}")),
                        ),
                        SizedBox(height: 2.h),
                        BoldFirstWord(
                            firstWord: "Name: ", lastWord: data.name!),
                        BoldFirstWord(
                            firstWord: "Location: ",
                            lastWord:
                                "${data.pradeshName}, ${data.districtName}, ${data.muniName}-${data.ward}"),
                        BoldFirstWord(
                            firstWord: "Mobile: ", lastWord: data.mobile!),
                        BoldFirstWord(
                            firstWord: "Email: ", lastWord: data.email!),
                        if (data.website != null)
                          BoldFirstWord(
                              firstWord: "Website: ", lastWord: data.website!),
                        if (data.description != null)
                          Html(
                            data: data.description.toString(),
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
              });
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage("${ApiConst.IMAGE_URL}${data.logo}"),
        ),
        title: Text(data.name.toString()),
        subtitle: Text(data.districtName.toString()),
      ),
    );
  }
}
