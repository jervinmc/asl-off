import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'dart:io' as io;
// import 'package:tflite/tflite.dart';

const appId = "9068b160533c425bbe81f1a70594a26f";
const token =
    "007eJxTYIhIYtnBsu62k8KmQ61qmXrq1+J/eoV4yW86oX88ykS/skuBwdLAzCLJ0MzA1Ng42cTINCkp1cIwzTDR3MDU0iTRyCwtS/1WckMgIwNr3itGRgYIBPGZGMoMGRgAQvgbkA==";
const channel = "v1";

class VideoCall extends StatefulWidget {
  final List<CameraDescription> cameras;
  VideoCall(this.cameras);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
    bool isDetecting = false;
  var strin = 'test';
  late CameraController controller;
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  void initState() {
    super.initState();
    // if (cameras == null || cameras.length < 1) {
    //   print('No camera is found');
    // } else {
    //   controller = new CameraController(
    //     cameras[0],
    //     ResolutionPreset.high,
    //   );
    //   controller.initialize().then((_) {
  
    //   });
    // }
    
    initAgora();
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      // loadMyModel();
      // controller = new CameraController(
      //   widget.cameras[0],
      //   ResolutionPreset.high,
      // );
      // controller.initialize().then((_) {
      //   if (!mounted) {
      //     return;
      //   }
      //   setState(() {});

      //   controller.startImageStream((CameraImage img) {
      //     if (!isDetecting) {
      //       isDetecting = true;
      //       int startTime = new DateTime.now().millisecondsSinceEpoch;

      //       if (true) {
      //         Tflite.runModelOnFrame(
      //           bytesList: img.planes.map((plane) {
      //             return plane.bytes;
      //           }).toList(),
      //           imageHeight: img.height,
      //           imageWidth: img.width,
      //           numResults: 2,
      //         ).then((recognitions) {
      //           setState(() {
                  
      //           });
      //           strin = recognitions![0]['label'];
      //           int endTime = new DateTime.now().millisecondsSinceEpoch;
      //           print("Detection took ${endTime - startTime}");
      //           isDetecting = false;
      //           print(recognitions);
      //           print("OKAYYYYY");
      //         });
      //       } 
      //     }
      //   });
      // });
    }
  
    
  }

  // loadMyModel() async {
  //   var resultant = await Tflite.loadModel(
  //       model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  // }

  // applyModelOnImage(io.File file) async {
  //   var res = await Tflite.runModelOnImage(
  //       path: file.path,
  //       numResults: 2,
  //       threshold: 0.5,
  //       imageMean: 127.5,
  //       imageStd: 127.5);
  //   print(res);
  //   setState(() {
  //     print(res![0]['label'].toString());
  //   });
  // }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          // print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          // print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.joinChannel(token, channel, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xffef5777),
        title: Text('Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? RtcLocalView.SurfaceView()
                    : CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: channel,
      );
    } else {
      return Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
