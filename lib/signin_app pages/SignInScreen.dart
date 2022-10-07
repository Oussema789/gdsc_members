
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_member/signin_app%20pages/userInfoScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((onError){});

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    final user=FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInfoScreen(user: user)),
      );



    }
  }


  bool _isSigningIn=false;
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();





  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size ;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [

              // Container(
              //   height: deviceSize.height,
              //   width: deviceSize.width,
              //   decoration: BoxDecoration(
              //
              //     image: DecorationImage(
              //
              //       image: AssetImage(
              //           'images/background2.jpg',
              //
              //       ),
              //       fit: BoxFit.cover,
              //
              //     ),
              //   ),
              //
              // ),
              SingleChildScrollView(
                child:Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceSize.height*0.1,
                      ),

                      // Container(
                      //   height: deviceSize.height/3,
                      //   width: deviceSize.width/1.5,
                      //   decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image:
                      //       AssetImage('images/gdsc_logo.png',
                      //       ),
                      //     ),),
                      // ),
                      _AnimationWorksOnlyForTheFirstTime(context),
                         SizedBox(
                           height: deviceSize.height/22,
                         ),
                         InkWell(
                           onTap: (){
                             signInWithGoogle();
                             setState(() {
                               _isSigningIn = true;
                             });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                               color: Colors.black.withOpacity(0.2),
                               borderRadius: BorderRadius.circular(12),
                             ),

                             height: deviceSize.height/13,
                             width: deviceSize.width/1.1 ,
                             child: Row(
                               children: [

                                 Expanded(
                                   flex:1,

                                     child: Image.asset("images/googlelogo.png")),
                                 Expanded(
                                     flex:3,
                                     child:

                                 //     Text("Sign In with Google",style: TextStyle(
                                 //   fontSize: 25,
                                 //   color: Color(0xff11844C),
                                 //   fontFamily: "Roboto",
                                 //   fontWeight: FontWeight.bold,
                                 // ),)),
                                     Text(
                                       'Sign In with google',
                                       style: GoogleFonts.kalam(
                                         color: Colors.black,
                                         fontSize: 25,
                                         fontWeight: FontWeight.w700,
                                         fontStyle: FontStyle.italic,
                                       ),
                                     ),
                                 ),

                               ],
                             ),
                           ),
                         ),

                    ],),
                ),
              ),

            ],
          ),

        ),
      ),
      onWillPop: () async {
      //  model.clearAllModels();
        return false;
      },
    );

}
}

PageRouteBuilder slideTransitionBuilder({required Widget child}) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final _position = animation.drive(
            Tween<Offset>(begin: const Offset(-1, 1), end: Offset(0, 0)));

        return SlideTransition(position: _position, child: child);
      });
}



Widget _AnimationWorksOnlyForTheFirstTime(BuildContext context){
  Size deviceSize = MediaQuery.of(context).size;

  return TweenAnimationBuilder(
    child: Container(
      alignment: Alignment.center,
      height: deviceSize.height*0.7,
      width: deviceSize.width*0.7,
      child: Container(
        height: deviceSize.height/4,
        width: deviceSize.width/1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
            AssetImage('images/gdsc_logo.png',
            ),
          ),
        ),
      ),
    ),

    tween: Tween<double>(begin: 0,end: 1),
    duration: Duration(milliseconds: 3000),
    builder: (BuildContext context,double _val ,Widget? child){
      return Opacity(
        opacity: _val,
        child: Padding(
          padding: EdgeInsets.only(top: _val*30),
          child: child,
        ),
      );
    },

  );
}