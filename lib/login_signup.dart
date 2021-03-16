
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krash_company/home/home_screen.dart';
import 'package:krash_company/otp_verification.dart';
import 'package:krash_company/DatabaseConnection/check_mobileno.dart';

class LoginSignup extends StatefulWidget{
  _LoginSignup createState() => _LoginSignup();
}

class _LoginSignup extends State<LoginSignup>
{


  TextEditingController _editingController;
  ScrollController _scrollController;
  String _country_code="+91";
  String _mobile_no = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
           children: [
             Container(
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                   image: DecorationImage(
                       image: AssetImage(
                         "images/login_background.png",
                       ),
                       fit: BoxFit.fill
                   )
               ),
             ),
             Container(
               alignment: Alignment.center,
               padding: EdgeInsets.all(10),
               height: MediaQuery.of(context).size.height,
               width: MediaQuery.of(context).size.width,
               child: Form(
                 key: _formKey,
                 child: SingleChildScrollView(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [

                       getLogo(),
                       SizedBox(height: 50,),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Container(
                             child: CountryCodePicker(
                               onChanged: (val){
                                 print(val);
                                 _country_code = val.toString();
                               },
                               // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                               initialSelection: 'IN',
                               favorite: ['+91','IN'],
                               // optional. Shows only country name and flag
                               showCountryOnly: false,
                               // optional. Shows only country name and flag when popup is closed.
                               showOnlyCountryWhenClosed: false,
                               // optional. aligns the flag and the Text left
                               alignLeft: false,
                             ),
                             decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey),borderRadius: BorderRadius.circular(5)),
                             padding: EdgeInsets.fromLTRB(2,2, 2, 2),
                           ),

                           SizedBox(width: 5,),

                           Expanded(
                             child: TextFormField(
                               controller: _editingController,
                               validator: (value) {
                                 if (value.isEmpty) {
                                   return 'Please enter some text';
                                 }
                                 else if(value.length < 10)
                                 {
                                   return 'please enter 10 digit number';
                                 }
                                 return null;
                               },

                               keyboardType: TextInputType.number,
                               maxLength: 10,
                               decoration: InputDecoration(
                                 border: OutlineInputBorder(
                                   borderSide: BorderSide(width: 1)
                                 ),
                                 hintText: "enter mobile no.",
                                 focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(width: 1,color: Color.fromRGBO(52, 73, 94, 1))
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),

                       MaterialButton(onPressed: (){
                         if(_formKey.currentState.validate())
                         {

                           _mobile_no = _editingController.text;

                           CheckMobileno cm = new CheckMobileno();
                           cm.checkMobile(_country_code+_mobile_no).then((value){
                             if(value == null)
                             {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => OTPVerification(_country_code,_mobile_no)),
                               );
                             }
                             else {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => HomeScreen(value)),
                               );
                               Fluttertoast.showToast(
                                 msg: "welcome",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM,
                                 timeInSecForIosWeb: 1,
                                 backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                                 textColor: Colors.white,
                                 fontSize: 16.0,
                               );
                             }
                           });




                          // print(_editingController.text);

                           //pushData();
                         }
                       },
                           padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                         child: Container(
                           height: 50,
                           width: MediaQuery.of(context).size.width,
                           child: Text("SUBMIT",style: TextStyle(color: Colors.white,fontSize: 18),),
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                             color: Color.fromRGBO(0,0,102, 1),
                             borderRadius: BorderRadius.circular(5)
                           ),
                         )
                       )
                     ],
                   ),
                 ),
               ),
             ),
           ],
          ),
      )
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    _scrollController = new ScrollController();
    _editingController = new TextEditingController();

    super.initState();
  }


  Widget getLogo()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 90,
          width: 220,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/logo.png"),fit: BoxFit.fill),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

        ),

      ],
    );
  }


}

