import 'package:asl/config/global.dart';
import 'package:asl/home/views.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final List<CameraDescription> cameras;
  Login(this.cameras);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static String BASE_URL = '' + Global.url + '/login/';
  bool _load = false;
  bool isReveal = true;
  void pageValidation() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getBool("isLoggedIn"));

    if (prefs.getBool("isLoggedIn")!) {
      Navigator.pop(context);
      Get.toNamed('/home');
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    // pageValidation();
  }

  void notify(DialogType type, title, desc) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: desc,
      btnOkOnPress: () {},
    )..show();
  }

  void Login() async {
    final prefs = await SharedPreferences.getInstance();
    var params = {"email": _email.text, "password": _password.text};
    setState(() {
      _load = true;
    });
    final response = await http.post(Uri.parse(BASE_URL),
        headers: {"Content-Type": "application/json"},
        body: json.encode(params));
    String jsonsDataString = response.body.toString();
    if (response.statusCode == 404) {
      notify(DialogType.ERROR, 'Wrong Credentials', "Please try again.");
      setState(() {
        _load = false;
      });
      return;
    }
    final _data = jsonDecode(jsonsDataString);
    if (_data != 'no_data') {
      // if(_data[0]['status']!='Activated'){
      //   notify(DialogType.ERROR, 'Not yet activate', "Please check your email to verify this account.");
      //    setState(() {
      //      _load=false;
      //   });
      //   return;

      // }
      prefs.setInt("_id", _data[0]['id']);
      prefs.setString("permanent_address", _data[0]['permanent_address']);
      prefs.setString("fullname", _data[0]['fullname']);
      if (_data[0]['user_type'] == 'Finder') {
        Get.toNamed('/finder');
      } else if (_data[0]['user_type'] == 'Donor') {
        Get.toNamed('/home');
      } else {
        Get.toNamed('/homeInstitution');
      }
    } else {
      notify(DialogType.ERROR, 'Wrong Credentials', "Please try again.");
      setState(() {
        _load = false;
      });
    }
  }

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/logo_login.jpg",
                    height: 200,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(top: 20),
                  //     child: TextField(
                  //       controller: _email,
                  //       decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.all(8.0),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide:
                  //                 BorderSide(color: Colors.grey, width: 1.5),
                  //             borderRadius: BorderRadius.circular(20.0),
                  //           ),
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide(
                  //                 color: Color(0xff222f3e), width: 5.0),
                  //             borderRadius: BorderRadius.circular(20.0),
                  //           ),
                  //           filled: true,
                  //           hintStyle: TextStyle(color: Colors.grey[800]),
                  //           hintText: "Email",
                  //           fillColor: Colors.white70),
                  //     )),
                  // Container(
                  //     height: 100,
                  //     padding: EdgeInsets.only(top: 10),
                  //     child: TextField(
                  //       obscureText: isReveal,
                  //       controller: _password,
                  //       decoration: InputDecoration(
                  //           suffixIcon: !isReveal
                  //               ? InkWell(
                  //                   child: Icon(Icons.remove_red_eye),
                  //                   onTap: () => {
                  //                         setState(() {
                  //                           isReveal = true;
                  //                         })
                  //                       })
                  //               : InkWell(
                  //                   child: Icon(Icons.remove_red_eye_sharp),
                  //                   onTap: () => {
                  //                     setState(() {
                  //                       isReveal = false;
                  //                     })
                  //                   },
                  //                 ),
                  //           contentPadding: EdgeInsets.all(8.0),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide:
                  //                 BorderSide(color: Colors.grey, width: 1.5),
                  //             borderRadius: BorderRadius.circular(20.0),
                  //           ),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20.0),
                  //           ),
                  //           filled: true,
                  //           hintStyle: TextStyle(color: Colors.grey[800]),
                  //           hintText: "Password",
                  //           fillColor: Colors.white70),
                  //     )),
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed('/reset_password');
                  //   },
                  //   child: Text('Forgot Password?'),
                  // ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    width: 250,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffef5777)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      child: Text('Get Started'),
                      onPressed: () {
                        Get.toNamed('/home');
                        // Get.toNamed('/video',arguments: [widget.cameras]);
                        // Login();
                      },
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(top: 5),
                  //   width: 250,
                  //   child: ElevatedButton(
                  //       child: Text('Sign up',style: TextStyle(color: Colors.black),),
                  //     onPressed: () {
                  //       Get.toNamed('/register');
                  //     },
                  //       style: ElevatedButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(18.0),
                  //                 ),
                  //       primary: Colors.white,
                  //       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  //       textStyle: TextStyle(
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.bold)),

                  //   ),
                  //   ),
                  _load
                      ? Container(
                          color: Colors.white10,
                          width: 70.0,
                          height: 70.0,
                          child: new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Center(
                                  child: new CircularProgressIndicator())),
                        )
                      : Text('')
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
