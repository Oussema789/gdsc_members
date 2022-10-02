import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_member/Qr_page.dart';
import 'package:gdsc_member/signin_app%20pages/SignInScreen.dart';
import 'package:gdsc_member/signin_app%20pages/test1.dart';
import 'package:google_sign_in/google_sign_in.dart';



class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  User? _user;
  bool _isSigningOut = false;
  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size ;
    return Scaffold(

      body: Stack(
        children: [

          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: BoxDecoration(

              image: DecorationImage(

                image: AssetImage(
                  'images/wallpaper_4.jpg',

                ),
                fit: BoxFit.cover,

              ),
            ),

          ),

          SafeArea(

            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: deviceSize.height/6.5,),
                  Row(),

                  _user?.photoURL != null
                      ? ClipOval(
                       child: Material(
                          color: Colors.orange.withOpacity(0.2),
                          child:
                          Image.network(
                        '${_user?.photoURL}',
                        fit: BoxFit.fitHeight,
                        height: deviceSize.height/5,
                      ),
                    ),
                  )
                      : ClipOval(
                    child: Material(
                      color: Colors.orange.withOpacity(0.3),
                      child: Padding(

                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.orange,
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: Text(
                      'Hello',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 30,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  Expanded(
                    child: Text(
                      '${_user?.displayName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),

                  Expanded(
                    child: Text(
                      '( ${_user?.email} )',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 0.5,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),
                  _isSigningOut
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      :
                  SizedBox(height: deviceSize.height/30),


                  Text(
                    'You are now signed in using your Google account.\nTo sign out of your account, click the "Sign Out" button below.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 0.5,
                      fontFamily: "Roboto",
                    ),
                  ),


                  Flexible(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.blue,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {

                        Future.delayed(Duration(milliseconds: 100), () {
                          CircularProgressIndicator();
                        });

                        if (_user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QrPage()),
                          );

                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Check your QR',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                  ),


                  Flexible(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.redAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });
                        //await Authentication.signOut(context: context);
                        setState(() {
                          _isSigningOut = false;
                        });
                        await GoogleSignIn().disconnect().catchError((onError){});
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(

                            builder: (context) => SignInScreen()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

AppBar AppBarTitle (){
  return AppBar(
    title: Text("SignIn"),
  );
}
