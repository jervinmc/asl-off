
import 'package:asl/about/about.dart';
import 'package:asl/home/views.dart';
import 'package:asl/homeFinder/views.dart';
import 'package:asl/lobby/views.dart';
import 'package:asl/login/views.dart';
import 'package:asl/video_call/views.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
List<CameraDescription>? cameras;
void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter',
      theme: ThemeData(
      ),
      getPages: [
        
        GetPage(name: "/video", page:()=>VideoCall(cameras!)),
        GetPage(name: "/login", page:()=>Login(cameras!)),
        GetPage(name: "/lobby", page:()=>Lobby()),
        // GetPage(name: "/register", page:()=>SignUp()),
        GetPage(name: "/home", page:()=>Home()),
         GetPage(name: "/finder", page:()=>Finder()),
         GetPage(name: "/about", page:()=>About()),
         
          // GetPage(name: "/qrprofile", page:()=>QRProfile()),
          //  GetPage(name: "/qrprofile", page:()=>QRProfile()),
          //   GetPage(name: "/homeInstitution", page:()=>Institution()),
          //   GetPage(name: "/testvideo", page:()=>TestVideo(cameras!)),
           
      //   GetPage(name: "/home", page:()=>Home()),
      //   GetPage(name: "/details", page:()=>Details()),
      //   GetPage(name: "/cart", page:()=>Carts()),
      //   GetPage(name: "/chat", page:()=>ChatPage()),
      //   GetPage(name: "/transaction", page:()=>Transaction()),
      //   GetPage(name: "/checkout", page:()=>Checkout()),
      //  GetPage(name: "/item_status", page:()=>ItemStatus()),
      //  GetPage(name: "/notification", page:()=>Notifications()),
      //   GetPage(name: "/profile", page:()=>Profile()),
      //   GetPage(name: "/search", page:()=>Search()),
      //   GetPage(name: "/checkout_cart", page:()=>CheckoutCart()),
      //   GetPage(name: "/about", page:()=>About()),
      //  GetPage(name: "/reset_password", page:()=>ResetPassword()),
      //  GetPage(name: "/most_buy", page:()=>MostBuy()),
      //  GetPage(name: "/wishlist", page:()=>Wishlist()),
      //  GetPage(name: "/most_view", page:()=>MostView()),
        
        // GetPage(name: "/signup", page:()=>SignUp()),
        // GetPage(name: "/profile", page:()=>Profile()),
        // GetPage(name: "/resetPassword", page:()=>ResetPassword()),
        // GetPage(name: "/receiptList", page:()=>receiptList()),
        // GetPage(name: "/receipt", page:()=>receipt()),
        // GetPage(name: "/products", page:()=>Products()),
        // GetPage(name: "/cart", page:()=>Cart()),
        // GetPage(name: "/favorites", page:()=>Favorites()),
        // GetPage(name: "/product_details", page:()=>ProductDetails()),
      ],
      initialRoute: "/login"  ,
    );
  }
}
