// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:gdsc_member/Data/emails.dart';
// import 'package:gdsc_member/Qr_page.dart';
// import 'package:lottie/lottie.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
//
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final user = FirebaseAuth.instance.currentUser;
//   buildSearchField(){
//     return AppBar(
//       backgroundColor: Colors.white,
//       title: TextFormField(
//         decoration: InputDecoration(
//             hintText: "Search for a user...",
//             filled: true,
//             prefixIcon: Icon(Icons.account_box,size: 28.0,),
//             suffixIcon: IconButton(icon: Icon(Icons.clear,), onPressed: () { print('Cleared'); },)
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildSearchField(),
//       body: Search(),
//     );
//   }
// }
//
// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);
//
//   @override
//   _SearchState createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
//   final user = FirebaseAuth.instance.currentUser;
//   AnimationController? _controller;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _controller?.addStatusListener((status) async {
//
//       if (status == AnimationStatus.completed){
//
//         _controller?.stop();
//       }
//     });
//
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//
//   }
//   // buildNoContent(){
//   //   final Orientation orientation =MediaQuery.of(context).orientation;
//   //   return Container(
//   //     height: 950,
//   //     width: 450,
//   //     child: Center(
//   //       child: ListView(
//   //         shrinkWrap: true,
//   //         children: [
//   //
//   //           SizedBox(
//   //             child:Image.asset("images/wallpaper_7.jpg",
//   //               fit: BoxFit.cover,
//   //               height: 900,
//   //               width: 450,
//   //
//   //             ),
//   //           ),
//   //
//   //           Text('Find Users',textAlign: TextAlign.center,style: TextStyle(
//   //             color: Colors.black,
//   //             fontStyle: FontStyle.italic,
//   //             fontWeight: FontWeight.w600,
//   //             fontSize: 60,
//   //           ),),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     bool _flag = false;
//     return Scaffold(
//         backgroundColor: Colors.white54,
//
//
//         body: Stack(
//           children: [
//
//             SizedBox(
//               child:Image.asset("images/wallpaper_11.jpg",
//                 fit: BoxFit.cover,
//                 height: 900,
//                 width: 450,
//
//               ),
//             ),
//
//             FutureBuilder(
//               future: ReadJsonData(),
//               builder: (context, data) {
//                 if (data.hasError) {
//                   return Center(child: Text("${data.error}"));
//                 } else if (data.hasData) {
//                   var items = data.data as List<Email>;
//                   return
//                     ListView.builder(
//
//                       itemCount: items == null ? 0 : items.length,
//                       itemBuilder: (context, index) {
//
//
//                         if (items[index].email.toString() == user?.email){
//
//
//                           return Text(items[index].email.toString());
//                         }else{
//                           return Scaffold(
//                             appBar: appBAR(context, Colors.red),
//                             body: Center(
//                               child: Lottie.asset("assets/not_found.json"),
//                             ),
//                           );
//
//                         }
//
//
//
//
//
//                         return Container(
//                           color:Colors.black.withOpacity(0.1),
//                           //elevation: 5,
//                           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                           child: Container(
//                             padding: EdgeInsets.all(8),
//                             child: Column(
//                               // mainAxisAlignment: MainAxisAlignment.center,
//                               // crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//
//                                 Column(
//                                   children: [
//                                     //
//                                     // SizedBox(width: 8.0,),
//                                     // Column(
//                                     //   children: [
//                                     //     Text(items[index].email.toString(),
//                                     //       style: TextStyle(
//                                     //           color: Colors.white,
//                                     //           fontWeight: FontWeight.bold,
//                                     //           fontSize: 30,
//                                     //           fontFamily: "Panipuri"
//                                     //       ),
//                                     //     ),
//                                     //
//                                     //
//                                     //
//                                     //
//                                     //   ],
//                                     // ),
//                                     // SizedBox(width: 190.0,),
//                                     //
//                                     // const Divider(),
//
//
//
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),
//
//
//           ],
//         )
//     );
//
//   }
//   Future<List> ReadJsonData() async {
//     firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('test/gdsc_emails.json');
//
//     Uint8List? downloadedData  =  await ref.getData();
//     //print(utf8.decode(downloadedData!));
//
//     // final jsondata = await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
//     final list = json.decode(utf8.decode(downloadedData!)) as List<dynamic>;
//
//
//     return list.map((e) => Email.fromJson(e)).toList();
//   }
// }
//
//
// // class SearchContainer extends StatelessWidget {
// //   final User1 user;
// //   const SearchContainer({
// //     Key? key,
// //     required this.user,}) : super(key: key);
// //
// //   @override
// //
// //   Widget build(BuildContext context) {
// //
// //     return Stack(
// //       children: [
// //         Container(
// //           margin:  EdgeInsets.symmetric(vertical: 10.0),
// //           padding: EdgeInsets.symmetric(vertical: 40.0),
// //           color:Colors.black12.withOpacity(0.4),
// //           child: Column(
// //             children: [
// //               Padding(
// //                 padding: EdgeInsets.symmetric(horizontal: 1.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //
// //                     PostHeader(user: user),
// //                     const SizedBox(height: 4.0,),
// //                     Text(user.phone.toString(),style: TextStyle(color: Colors.yellowAccent,
// //                       fontSize: 15.0,
// //                       fontWeight: FontWeight.bold,
// //                       letterSpacing: 2,
// //                       fontFamily: "Panipuri",
// //                     ),),
// //
// //                     CircleAvatar(
// //                       backgroundImage: NetworkImage(imageUrl),
// //                       radius: 50,
// //                     )
// //
// //                   ],
// //                 ),
// //               ),
// //
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
// //                 child: SearchStats(user: user,),
// //               )
// //
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// // class PostHeader extends StatelessWidget {
// //   final User1 user;
// //   const PostHeader({
// //     Key? key,
// //     required this.user,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       children: [
// //         Expanded(
// //
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center ,
// //             children: [
// //               Text(user.name,style: TextStyle(color: Colors.white,
// //                 fontSize: 15.0,
// //                 fontWeight: FontWeight.bold,
// //                 letterSpacing: 2,
// //                 fontFamily: "Panipuri",
// //               ),),
// //             ],
// //           ),
// //         ),
// //
// //
// //       ],
// //     );
// //
// //   }
// // }
//
// //
// // class SearchStats extends StatelessWidget {
// //   final User1 user;
// //
// //   const SearchStats({Key? key, required this.user}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         const Divider(),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //
// //           children: [
// //             _AddButton(),
// //           ],
// //         ),
// //       ],
// //
// //     );
// //   }
// // }
//
//
// // class _AddButton extends StatefulWidget {
// //
// //   const _AddButton({Key? key,}) : super(key: key);
// //
// //   @override
// //   State<_AddButton> createState() => _AddButtonState();
// // }
// //
// // class _AddButtonState extends State<_AddButton> {
// //   bool _flag = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     int count=0;
// //
// //     return ElevatedButton.icon(
// //       onPressed: () {
// //
// //         setState(() => _flag = !_flag);
// //       },
// //       icon: Icon(
// //         _flag ? Icons.add : Icons.done,
// //       ),
// //       label: Text(
// //         _flag ? 'Follow' : 'Followed',
// //       ),
// //       style: ElevatedButton.styleFrom(
// //         primary: _flag ? Colors.lightGreen : Colors.blue,
// //       ),
// //     );
// //
// //   }
// // }
//
//
//
