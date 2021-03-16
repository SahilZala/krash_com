import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krash_company/home/address_picker.dart';
import 'package:krash_company/home/home_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'home/new_address_picker.dart';

class OTPVerification extends StatefulWidget{
  String _country_code="+91";
  String _mobile_no = "";
  _OTPVerification createState() => _OTPVerification(_country_code,_mobile_no);
  OTPVerification(_country_code,_mobile_no)
  {
    this._country_code = _country_code;
    this._mobile_no = _mobile_no;
  }
}

class _OTPVerification extends State<OTPVerification>
{
  String _coutry_code,_mobile_no;


  _OTPVerification(this._coutry_code, this._mobile_no);

  String otp="1234";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_coutry_code+""+_mobile_no);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Color.fromRGBO(0,0,102,1),
        //
        // ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(0,0,102, 1),
        title: Text("Login/Signup", style: TextStyle(fontFamily: 'RobotoSlab', letterSpacing: 0.6),),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Text("Enter verification code ",
              style: TextStyle(
                  color: Color.fromRGBO(0,0,102, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15,),
            Text("we have sent you a 4 digit verification code on",
              style: TextStyle(
                  color: Color.fromRGBO(52, 73, 94, 1),
                  fontSize: 15
              ),
            ),

            SizedBox(height: 15,),
            Text(_coutry_code+_mobile_no,
              style: TextStyle(
                  color: Color.fromRGBO(0,0,102, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),


            SizedBox(height: 15,),

            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Form(
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  backgroundColor: Colors.transparent,
                  appContext: context, length: 4,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderWidth: 2,
                    borderRadius: BorderRadius.circular(5),
                    activeColor: Color.fromRGBO(0,0,102, 1),
                    inactiveColor: Colors.grey,
                    selectedColor: Colors.black,
                    fieldHeight: 50,
                    fieldWidth: 50,
                  ),mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  onCompleted: (value)
                  {
                    if(otp == value)
                    {
                      Fluttertoast.showToast(
                        msg: "OTP Verified",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      Timer(Duration(seconds: 2), () =>
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AddressPicker(_coutry_code,_mobile_no)),
                          )
                      );

                    }
                    else {
                      Fluttertoast.showToast(
                        msg: "Wrong OTP",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ),
            )

          ],
        ),



      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //
      //
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => CreateProfile()),
      //     );
      //   },
      // ),

      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.all(18.0),
      //   child: SizedBox(
      //     height: 60,
      //     child: RaisedButton(
      //       onPressed: (){
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) =>Profession()),
      //         );
      //       },
      //       color: Color.fromRGBO(0,0,102, 1),
      //       textColor: Colors.white,
      //       child: Text('Next',  style: TextStyle(fontFamily: 'RobotoSlab', letterSpacing: 0.6),),
      //     ),
      //   ),
      // ),
    );
  }
}