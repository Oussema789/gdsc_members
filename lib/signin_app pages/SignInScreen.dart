
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_member/signin_app%20pages/userInfoScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<UserCredential> signInWithGoogle() async {
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  User? user = FirebaseAuth.instance.currentUser;
  bool _isSigningIn=false;
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();





  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size ;
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFE6E6E6),
          body: Stack(
            children: <Widget>[

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
              SingleChildScrollView(
                child:Column(
                  children: <Widget>[
                    SizedBox(
                      height: deviceSize.height*0.1,
                    ),
                    Container(

                      child: Text("GDSC ENSTAB MEMEBER",style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),),
                    ),
                    Container(
                      height: deviceSize.height/2.4,
                      width: deviceSize.width/3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                          AssetImage('images/gdsc_logo.png',
                          ),
                        ),),),

                    Container(
                      child: Form(
                        key: _userLoginFormKey,
                        child: Padding(
                          padding: const EdgeInsets.only(top:5.0,bottom:15,left: 10,right: 10),
                          child: Container(
                            decoration:
                            BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Sign In",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 25,color: Colors.white,),),
                                ),

                                SizedBox(
                                width: deviceSize.width,),
                                InkWell(
                                  child: Container(
                                      width: deviceSize
                                          .width/2,
                                      height: deviceSize.height/18,
                                      margin: EdgeInsets.only(top: 25),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color:Colors.black
                                      ),
                                      child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                      AssetImage('images/googlelogo.png'),
                                                      fit: BoxFit.cover),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text('Sign in with Google ',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ],
                                          )
                                      )
                                  ),
                                  onTap: () async{

                                    signInWithGoogle();

                                    setState(() {
                                      _isSigningIn = false;
                                    });
                                    setState(() {
                                      _isSigningIn = true;
                                    });
                                    User? user = FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => UserInfoScreen(user: user,)
                                        ),
                                      );

                                    }
                                  },
                                ),
                                SizedBox(height: 16,),
                              ],),
                          ),),
                      ),),
                  ],),
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