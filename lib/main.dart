import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otpPage.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  List<Color> kLightHeaderColors = [
    Color(0xffD66D75),
    Color(0xffE29587),
    Color(0xffba5370),
    Color(0xfff4e2d8),
    Color(0xff2C919F),
    Color(0xff85DBDA),
    Color(0xff636FA4),
    Color(0xffE8CBC0),
    Color(0xffC5796D),
    Color(0xffDBE6F6),
    Color(0xffeacda3),
    Color(0xffd6ae7b),
  ];
  List<Color> kDarkHeaderColors = [
    Color(0xff355C7D),
    Color(0xff6C5B7B),
    Color(0xff42275a),
    Color(0xff734b6d),
    Color(0xff516395),
    Color(0xff614385),
    Color(0xff0F2027),
    Color(0xff2C5364),
    Color(0xff292E49),
    Color(0xff536976),
    Color(0xff525252),
    Color(0xff3d72b4),
  ];
  BoxDecoration kAppGradHeader(int i, bool light) => BoxDecoration(
    gradient: LinearGradient(colors: [
      light ? kLightHeaderColors[2 * i] : kDarkHeaderColors[2 * i],
      light ? kLightHeaderColors[2 * i + 1] : kDarkHeaderColors[2 * i + 1],
    ]),
  );
  late String otp;
  Widget build(BuildContext context) {
    String number='';
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: sidebar(),
        drawerEdgeDragWidth: 20,
        appBar: AppBar(
          title: Text('Sign-In'),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration : kAppGradHeader(
                0,
                Theme.of(context).primaryColor == Colors.pinkAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25),
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.redAccent,
                ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        autofocus: true,
                        onChanged: (num){
                          number = num;
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18,),
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(Icons.contact_page,color: Colors.redAccent,),
                          hintText: '10 digit phone number',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          prefixText: '+91',
                          prefixStyle: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextButton(onPressed:  ()async{

                await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91$number',
                    verificationCompleted: (PhoneAuthCredential credential) async{
                      await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
                        if(value.user!=null){
                          print('user logged in');
                        }
                      });
                    },
                    verificationFailed: (FirebaseAuthException e){
                      print(e.message);
                },

                  timeout: Duration(seconds: 60), codeSent: (String verificationId, int? forceResendingToken) {
                     setState((){
                       otp = verificationId;
                     });


                }, codeAutoRetrievalTimeout: (String verificationId) {
                  setState((){
                    otp = verificationId;
                  });
                },
                );
                setState((){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>otppage()));
                });
                },
                    child: Text('Get OTP',
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
