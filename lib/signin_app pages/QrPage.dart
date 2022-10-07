
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gdsc_member/Data/emails.dart';
import 'package:gdsc_member/Qr_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  const QrPage({Key? key}) : super(key: key);

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> with SingleTickerProviderStateMixin {

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

     return FutureBuilder(
         future: VerifEmail(user?.email),
         builder: (context,data){
           if (data.connectionState == ConnectionState.waiting)
             return Center(child: CircularProgressIndicator());
           else if (data.connectionState == ConnectionState.done)
           {
             bool? hasEmail = data.data;
             if( hasEmail!){
               return Valid(context,user,_controller!);
             }
             return NoValid(context);
           }

           else
             return Container();
         });





}

AppBar appBAR(BuildContext context,Color color){
  return AppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(25, 25),
        )
    ),
    centerTitle: true,
    backgroundColor: color,
    title: Text(
      'GDSC ENSTAB',
      style: GoogleFonts.kalam(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    ),
    toolbarHeight: 70,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    ),


  );
}

Widget NoValid(BuildContext context){

  return Scaffold(
    appBar: appBAR(context, Colors.deepOrange),
    body: Center(
      child: Lottie.asset("assets/notfound.json"),
    ),
  );
}


Widget Valid(BuildContext context, User? user, AnimationController _controller){
   return Scaffold(
     appBar: appBAR(context, Colors.green),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [

           Lottie.asset("assets/done.json",
               controller: _controller,

               onLoaded: (compostion) {
                 _controller.duration = compostion.duration;
                 _controller.forward();
               }
           ),

           QrImage(
             data: '${user?.photoURL}',
             version: QrVersions.auto,
             size: 320,
             gapless: false,
             embeddedImage: AssetImage('images/image1.jpg'),
             embeddedImageStyle: QrEmbeddedImageStyle(
               size: Size(80, 80),
             ),
           ),

           Text("This is your unique QR Code",),


         ],
       ),
     ),
   );

}
Future<bool> VerifEmail(email) async {
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('test/gdsc_emails.json');
  Uint8List? downloadedData  =  await ref.getData();
  final list = json.decode(utf8.decode(downloadedData!)) as List<dynamic>;
  var Data = list.map((e) => Email.fromJson(e)).toList();
  var data= Data as List<Email>;
  for (var i=0;i<data.length;i++){
    if (data[i].email == email){
      return true;
    }
  }
  return false;
}




}