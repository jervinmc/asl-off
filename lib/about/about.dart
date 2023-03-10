import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffef5777),
          title: const Text('About'),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/about.png",
                      height: 200,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'We are a team of passionate developers who believe that technology can bridge communication gaps between individuals who speak different languages, including those who use sign language. Our mission is to make communication easier and more accessible for the deaf and hard of hearing community by providing a fast and reliable Sign Language to Text Translation App.')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'Our team includes experts in machine learning, artificial intelligence, and linguistics. We have carefully designed and developed our app to ensure that it accurately translates American Sign Language (ASL) into written text in real-time. With our app, you can easily communicate with deaf and hard of hearing individuals, regardless of your own sign language proficiency.')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'We have also focused on creating a user-friendly interface. We understand that communication needs to be quick and seamless, which is why our app is simple and easy to use. You can simply hold up your phone to the person signing, and our app will immediately translate their signs into text.')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'We are proud to offer our app as a tool to help bridge communication gaps and improve the quality of life for those in the deaf and hard of hearing community. Our commitment to accessibility and innovation drives us to continue developing and improving our app, so that everyone can communicate effectively and effortlessly.')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'Thank you for choosing our Sign Language to Text Translation App. We are excited to be part of your journey towards better communication.')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'A Thesis Presented to the Faculty of College of Information Technology and Computer Science University of the Cordilleras')
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Text(
                              'This application was made In Partial Fulfillment Of The Requirement for the Degree BACHELOR OF SCIENCE IN COMPUTER SCIENCE')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
