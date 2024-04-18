import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shramsansar/const/app_color_const.dart';
import 'package:shramsansar/features/news_and_notices/presentation/controller/news_notice_controller.dart';
import 'package:shramsansar/utils/custom_form/custom_form.dart';

class NewsNotice extends ConsumerStatefulWidget {
  const NewsNotice({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsNoticeState();
}

class _NewsNoticeState extends ConsumerState<NewsNotice> {
  String? _selectedItem;
  dropDown(BuildContext context) {
    return SizedBox(
        height: 100,
        width: 100,
        child: DropdownButton<String>(
          value: _selectedItem,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedItem = newValue;
              });
            }
          },
          items: <String>['News', 'Notice'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }

  TextEditingController search = TextEditingController();
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    var newsnotice = ref.watch(newsnoticeControllerProvider(1));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorConst.BUTTON_BLUE_COLOR,
        title: Text(
          'News and Notice',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search with title of the new or notice",
                style: TextStyle(
                    color: AppColorConst.BUTTON_BLUE_COLOR, fontSize: 14),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    child: TextFormField(
                      controller: search,
                      decoration: InputDecoration(
                          constraints:
                              BoxConstraints.tight(Size.fromHeight(35)),
                          contentPadding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColorConst.BUTTON_BLUE_COLOR,
                                  width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColorConst.BUTTON_BLUE_COLOR))),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 35,
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: AppColorConst.BUTTON_BLUE_COLOR, width: 1)),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedValue.isEmpty
                                  ? null
                                  : selectedValue, // Example initial value
                              onChanged: (String? newValue) {
                                // Handle dropdown item selection
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: <String>['News', 'Notice']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.sizeOf(context).width * .24, 25),
                        fixedSize:
                            Size(MediaQuery.sizeOf(context).width * .24, 25),
                        elevation: .99,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        backgroundColor: AppColorConst.BUTTON_BLUE_COLOR),
                  )
                ],
              ),
              const Divider(
                color: CupertinoColors.systemGrey3,
              ),
              newsnotice.when(data: (data) {
                if (data.data!.isEmpty) {
                  return const Center(
                    child: Text("No data found"),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: data.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            height: 65,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color:
                                    CupertinoColors.extraLightBackgroundGray),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //title of news and notice
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      child: Text(
                                        data.data!
                                            .map((e) => e.title)
                                            .toString(),
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColorConst
                                                .BUTTON_BLUE_COLOR),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: AppColorConst.PRAYMERY_COLOR),
                                      child: Text(
                                        selectedValue,
                                        style: TextStyle(
                                            color: AppColorConst
                                                .PRAYMARY_TEXT_COLOR),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                        size: 18, color: Colors.grey),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('biratnagar'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.calendar_month_outlined,
                                        size: 18, color: Colors.grey),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("2080-1-21")
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }, error: (_, __) {
                return Text('error');
              }, loading: () {
                return Text('Loading.....');
              })
            ],
          ),
        ),
      ),
    );
  }
}
