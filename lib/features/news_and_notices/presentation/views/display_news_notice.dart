import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/news_and_notices/data/models/news_notice_model.dart'
    as newsNoticeData;

class DisplayNewsNoticeScreen extends StatelessWidget {
  final newsNoticeData.Data data;
  const DisplayNewsNoticeScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.typeName.toString()),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.h),
        child: Column(
          children: [
            Text(
              data.title.toString(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    Text(data.location.toString())
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    Text(data.publishedDate.toString())
                  ],
                )
              ],
            ),
            SizedBox(height: 2.h),
            Divider(
              color: AppColorConst.BUTTON_BLUE_COLOR,
            ),
            Html(
              data: data.description.toString(),
              shrinkWrap: true,
              style: {
                "*": Style(
                  fontSize: FontSize(14),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
