
import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gdsc_member/Data/emails.dart';
import 'package:gdsc_member/Qr_page.dart';
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
          FutureBuilder(
            future: ReadJsonData(),

            builder: (context, data)  {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<Email>;

                for ( int i= 0 ; i < items.length; i++) {

                  print(user?.email == items[0].email);
                  print(user?.email == items[1].email);


                  print("***************HERE:${i}");

                  if ( user?.email == items[i].email) {
                    print("*****************************************${items[i].email}" );
                    print("*****************************************${user?.email}" );
                    print(i);
                    print("nombre d'items  === ${items.length}");
                    print(items);


                    return Scaffold(
                      appBar: appBAR(context, Colors.green),
                        body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Lottie.asset("assets/done.json",
                                controller: _controller,

                                onLoaded: (compostion) {
                                  _controller?.duration = compostion.duration;
                                  _controller?.forward();
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
                  else {
                    return Scaffold(
                      appBar: appBAR(context, Colors.red),
                      body: Center(
                        child: Lottie.asset("assets/not_found.json"),
                      ),
                    );
                  }
                }
              }
              else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                color: Colors.red,
              );
            },
          ),

        ]
    );
  }


  Future<List> ReadJsonData() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('test/gdsc_emails.json');

    Uint8List? downloadedData  =  await ref.getData();
    //print(utf8.decode(downloadedData!));

    // final jsondata = await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
    final list = json.decode(utf8.decode(downloadedData!)) as List<dynamic>;


    return list.map((e) => Email.fromJson(e)).toList();
  }
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