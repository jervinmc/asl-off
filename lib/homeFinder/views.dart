import 'package:asl/config/global.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Finder extends StatefulWidget {
  const Finder({Key? key}) : super(key: key);

  @override
  _FinderState createState() => _FinderState();
}

class _FinderState extends State<Finder> {
  TextEditingController _search = new TextEditingController();
  final List<String> imgList = [
    'https://img.freepik.com/free-vector/flat-design-international-day-charity-concept_23-2148625885.jpg?t=st=1657249860~exp=1657250460~hmac=593e196e9461ed047aad8898bed5a338954c5fa18c32de5fdc0da827aa8754e5&w=996',
    'https://img.freepik.com/free-vector/flat-design-international-day-charity-concept_23-2148625885.jpg?t=st=1657249860~exp=1657250460~hmac=593e196e9461ed047aad8898bed5a338954c5fa18c32de5fdc0da827aa8754e5&w=996',
    'https://img.freepik.com/free-vector/flat-design-international-day-charity-concept_23-2148625885.jpg?t=st=1657249860~exp=1657250460~hmac=593e196e9461ed047aad8898bed5a338954c5fa18c32de5fdc0da827aa8754e5&w=996',
  ];
  String _email = '';
  bool _load = false;
  List data = [];
  List data_breakfast = [];
  List data_lunch = [];
  String category_data = "";
  List data_dinner = [];
  List data_recommend = [];
  bool isLoggedin = false;
  late String channel;
  static String BASE_URL = '' + Global.url + '/product/';
  List feature = [];
  Future<String> getData() async {
    _load = true;
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isLoggedIn") == null ||
        prefs.getBool("isLoggedIn") == false) {
      isLoggedin = false;
    } else {
      isLoggedin = true;
    }
    _email = prefs.getString("_email").toString();
    channel = prefs.getString("_channel").toString();
    print(channel);
    setState(() {});
    var _id = prefs.getInt("_id");
    final response = await http.get(Uri.parse(BASE_URL),
        headers: {"Content-Type": "application/json"});
    String jsonsDataString = response.body.toString();
    final _data = jsonDecode(jsonsDataString);
    data = data;
    print(_data);
    setState(() {
      try {
        data = _data;
        print(data.length);
        print(response);
      } finally {
        _load = false;
      }
    });
    return "";
  }

  @override
  void initState() {
    // // TODO: implement initState
    // super.initState();
    // getData();
    // _initPusher();
    //  tz.initializeTimeZones();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    _email,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffef5777),
                ),
              ),
              // ListTile(
              //   trailing: Icon(Icons.settings),
              //   title: const Text('Settings'),
              //   onTap: () {
              //     Get.toNamed('/profile');
              //   },
              // ),
              Divider(),
              ListTile(
                trailing: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      animType: AnimType.BOTTOMSLIDE,
                      title: "Are you sure you want to logout ?",
                      btnOkOnPress: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isLoggedIn', false);
                        Navigator.pop(context);
                        Get.toNamed('/login');
                        // runApp(());
                      },
                      btnCancelOnPress: () {})
                    ..show();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Dashboard'),
            Row(children: [
              InkWell(
                onTap: () {
                  Get.toNamed('/profile');
                },
                child: Icon((Icons.account_circle_outlined)),
              ),
              Icon((Icons.notifications))
            ])
          ]),
          backgroundColor: Color(0xffef5777),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: CarouselSlider(
                options: CarouselOptions(),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1000)),
                        ))
                    .toList(),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Color(0xffef5777),
                          onTap: () {
                            Get.toNamed('/sales');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.medication,
                                size: 120,
                                color: Color(0xffef5777),
                              ),
                              Text(
                                'Medicines',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                  Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Color(0xffef5777),
                          onTap: () {
                            Get.toNamed('/search');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                size: 120,
                                color: Color(0xffef5777),
                              ),
                              Text(
                                'Search for donation.',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Color(0xffef5777),
                          onTap: () {
                            Get.toNamed('/addinventory');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                size: 120,
                                color: Color(0xffef5777),
                              ),
                              Text(
                                'About donating blood.',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                  Card(
                      elevation: 5,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                          splashColor: Color(0xffef5777),
                          onTap: () {
                            Get.toNamed('/inventory');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.inventory,
                                size: 120,
                                color: Color(0xffef5777),
                              ),
                              Text(
                                'About us',
                                style: TextStyle(color: Colors.black87),
                              )
                            ],
                          ))),
                ],
              ),
            ],
          ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      required this.name,
      required this.picture,
      required this.price})
      : super(key: key);
  final name;
  final picture;
  final price;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: name,
        child: Material(
          child: InkWell(
            child: GridTile(
              child: Image.network(
                picture,
                fit: BoxFit.cover,
              ),
              footer: Container(
                height: 80,
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // leading: Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("Php $price"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationService {
  void selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print("okayyyy");
      Get.toNamed('/transaction');
    });
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_launcher'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
