// import 'package:flutter/material.dart';
// import 'package:gdsc_member/Qr_page.dart';
// import 'package:lottie/lottie.dart';
//
//
//
// class VerifyScreen extends StatefulWidget {
//   const VerifyScreen({Key? key}) : super(key: key);
//
//   @override
//   State<VerifyScreen> createState() => _VerifyScreenState();
// }
//
// class _VerifyScreenState extends State<VerifyScreen> with SingleTickerProviderStateMixin{
//    AnimationController? _controller;
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
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => QrScreen()),
//         );
//         _controller?.reset();
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
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.asset("assets/done.json",
//               controller: _controller,
//             repeat: true,
//           onLoaded: (compostion){
//           _controller?.duration = compostion.duration;
//             _controller?.forward();
//           }
//             ),
//
//       ),
//     );
//   }
// }
