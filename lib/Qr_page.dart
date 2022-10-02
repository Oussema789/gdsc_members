// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdsc_member/Data/emails.dart';
import 'package:gdsc_member/verifie.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrScreen extends StatefulWidget {

  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;


  AnimationController? _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _controller?.addStatusListener((status) async {

      if (status == AnimationStatus.completed){

         _controller?.stop();
      }
    });

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size ;

    return Stack(
        children: [




          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: BoxDecoration(

              image: DecorationImage(

                image: AssetImage(
                  'images/background2.jpg',

                ),
                fit: BoxFit.cover,

              ),
            ),

          ),
          Center(
            child: function(user,context,_controller!),
          ),

          ]
      );
  }
}



function(User? user,BuildContext context,AnimationController _controller) async {


  //
  // for (var i =0; i < GDSC_Emails.length; i++) {
  //
  //    if (getData(GDSC_Emails,i) == user?.email) {
  //      print("***********************");
  //
  //     return Scaffold(
  //       appBar: appBAR(context, Colors.green),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //
  //             Lottie.asset("assets/done.json",
  //                 controller: _controller,
  //
  //                 onLoaded: (compostion){
  //                   _controller.duration = compostion.duration;
  //                   _controller.forward();
  //                 }
  //             ),
  //
  //             QrImage(
  //                 data: '${user?.photoURL}',
  //                 version: QrVersions.auto,
  //                 size: 320,
  //                 gapless: false,
  //                 embeddedImage: AssetImage('images/image1.jpg'),
  //                 embeddedImageStyle: QrEmbeddedImageStyle(
  //                   size: Size(80, 80),
  //                 ),
  //               ),
  //
  //             Text("This is your unique QR Code"),
  //
  //
  //
  //
  //           ],
  //         ),
  //       ),
  //     );
  //   } else{
  //     return Scaffold(
  //       appBar: appBAR(context, Colors.red),
  //       body: Center(
  //         child: Lottie.asset("assets/not_found.json"),
  //       ),
  //     );
  //
  //   }
  // }
  return null;
}


AppBar appBAR(BuildContext context,Color color){
  return AppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )
    ),
    centerTitle: true,
   backgroundColor: color,
    title: Text("GDSC ENSTAB"),
    toolbarHeight: 70,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    ),


  );
}