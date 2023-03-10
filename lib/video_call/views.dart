import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'dart:io' as io;
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';

const appId = "9068b160533c425bbe81f1a70594a26f";
const token =
    "007eJxTYHD+NWkCk2SymUHpgz8h9VH8j3ZpROeJ8IToz5v1ePc9X2YFBksDM4skQzMDU2PjZBMj06SkVAvDNMNEcwNTS5NEI7O0bf2PkxsCGRm6Vu5jYWSAQBCfiaHMkIEBAIQpHUE=";
const channel = "v1";

class VideoCall extends StatefulWidget {
  final List<CameraDescription> cameras;
  VideoCall(this.cameras);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late InAppWebViewController _webViewController;
  @override
void initState(){

  super.initState();
  print("OKAYYYYYYYDFAWEFAEWFEWFAWEFA");
  initCamera();
}
 void initCamera() async{
   WidgetsFlutterBinding.ensureInitialized();
  await [Permission.microphone, Permission.camera].request();
}

@override
Widget build(BuildContext context) {



 var controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://asl-w.netlify.app')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://asl-w.netlify.app'));
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xffef5777),
      title: Text('Video Cal'),
    ),
    body: InAppWebView(
                      initialUrlRequest:URLRequest(url: Uri.parse('https://asl-w.netlify.app')),
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          mediaPlaybackRequiresUserGesture: false,
                          // debuggingEnabled: true,
                        ),
                      ),
                      onWebViewCreated: (InAppWebViewController controller) {
                        _webViewController = controller;
                      },
                      androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                        return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                      }
                  ),
                
  );
}

}