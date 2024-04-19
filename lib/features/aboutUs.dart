import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shramsansar/const/app_color_const.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        )),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/app_logo.png",
                      width: 60,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Shramsansar',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: AppColorConst.BUTTON_BLUE_COLOR),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("""
Welcome to Shramsansar, your premier destination for job seekers and career development. Our mission is to connect individuals with rewarding job opportunities and professional training to help them succeed in their careers.

Discover thousands of job listings, receive expert career guidance, and access top-notch training centers to enhance your skills. Join our supportive community and embark on a fulfilling career journey with Shramsansar today!


"""),
              SizedBox(
                height: 30.h,
              ),
              const Row(
                children: [
                  Text(
                    'Developed By: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(
                      'assets/images/developer_logo.png',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('youngminds.com.np')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
