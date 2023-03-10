import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Lobby extends StatefulWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffef5777),
        title: const Text('Lobby'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.only(top: 15),
          //   width: 250,
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //         backgroundColor:
          //             MaterialStateProperty.all<Color>(const Color(0xffef5777)),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0),
          //         ))),
          //     child: const Text('Filipino'),
          //     onPressed: () {
          //       Get.toNamed('/video');
          //       // Login();
          //     },
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: 250,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xffef5777)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              child: Text('English'),
              onPressed: () {
                Get.toNamed('/video');
                // Login();
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(top: 15),
          //   width: 250,
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //         backgroundColor:
          //             MaterialStateProperty.all<Color>(Color(0xffef5777)),
          //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(18.0),
          //         ))),
          //     child: Text('Japanese'),
          //     onPressed: () {
          //       Get.toNamed('/video');
          //       // Login();
          //     },
          //   ),
          // ),
        ],
      ),
      )
    );
  }
}
