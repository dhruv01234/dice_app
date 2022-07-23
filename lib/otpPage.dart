import 'package:flutter/material.dart';
import 'login_page.dart';

class otppage extends StatelessWidget {
  const otppage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String otpget;
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (otp){
              otpget=otp;
            },
          ),
          TextButton(onPressed: (){

          }, child: Text('SUMBIT'))
        ],
      ),
    );
  }
}
