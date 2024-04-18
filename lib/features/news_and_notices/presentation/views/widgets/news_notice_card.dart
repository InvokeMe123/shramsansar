import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/news_and_notices/data/models/news_notice_model.dart'
    as newsNoticeData;
import 'package:shramsansar/features/news_and_notices/presentation/views/display_news_notice.dart';
import 'package:shramsansar/utils/navigation/nav_app.dart';

class NewsNoticeCard extends StatelessWidget {
  final newsNoticeData.Data data;
  const NewsNoticeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        normalNav(context, DisplayNewsNoticeScreen(data: data));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.only(left: 12),
          height: 65,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: CupertinoColors.extraLightBackgroundGray),
          child: Column(
            children: [
              Row(
                children: [
                  //title of news and notice
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: Text(
                      data.title!,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColorConst.BUTTON_BLUE_COLOR),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration:
                        BoxDecoration(color: AppColorConst.PRAYMERY_COLOR),
                    child: Text(
                      data.typeName.toString(),
                      style:
                          TextStyle(color: AppColorConst.PRAYMARY_TEXT_COLOR),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 18, color: Colors.grey),
                  SizedBox(
                    width: 5,
                  ),
                  Text(data.location!),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.calendar_month_outlined,
                      size: 18, color: Colors.grey),
                  SizedBox(
                    width: 5,
                  ),
                  Text(data.publishedDate!),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
