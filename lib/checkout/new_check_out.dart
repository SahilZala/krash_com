import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krash_company/DatabaseConnection/order_connection.dart';

class CheckOut extends StatefulWidget{
  dynamic data;
  dynamic service_provider;
  dynamic user_data;
  _CheckOut createState() => _CheckOut(data,service_provider,user_data);

  CheckOut(this.data,this.service_provider,this.user_data);
}
class _CheckOut extends State<CheckOut>{

  dynamic data;
  dynamic service_provider;
  dynamic user_data;
  double total = 0;
  double cgst = 0;
  double sgst = 0;
  double discount = 0;

  _CheckOut(this.data,this.service_provider,this.user_data){
    total = double.parse(data['price']) + cgst + sgst;

    total = total - discount;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 20,width: 0,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "service you selected",
                      style: TextStyle(
                        color: Color.fromRGBO(112,112,112, 1),
                        fontSize: 20,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      data['title'],
                      style: TextStyle(
                        color: Color.fromRGBO(52,73,94, 1),
                        fontSize: 35,
                        fontFamily: "sairasemi",
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),


                  SizedBox(height: 10),

                  Container(color: Color.fromRGBO(112, 112, 112, 1) ,height: 1 ,width: MediaQuery.of(context).size.width),

                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      service_provider['name'],
                      style: TextStyle(
                          color: Color.fromRGBO(188,30,50, 1),
                          fontSize: 25,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      service_provider['address'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Color.fromRGBO(112,112,112, 1),
                          fontSize: 20,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),


                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      data['mobileno'],
                      style: TextStyle(
                          color: Color.fromRGBO(112,112,112, 1),
                          fontSize: 20,
                          fontFamily: "sairasemi",

                      ),
                    ),
                  ),

                  SizedBox(height: 10),


                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      data['servicename'],
                      style: TextStyle(
                          color: Color.fromRGBO(52,73,94, 1),
                          fontSize: 35,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),


                  SizedBox(height: 10),

                  Container(color: Color.fromRGBO(112, 112, 112, 1) ,height: 1 ,width: MediaQuery.of(context).size.width),

                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      data['description'],
                      style: TextStyle(
                          color: Color.fromRGBO(112,112,112, 1),
                          fontSize: 20,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Prizing",
                      style: TextStyle(
                          color: Color.fromRGBO(112,112,112, 1),
                          fontSize: 35,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),


                  Container(
                    padding: EdgeInsets.fromLTRB(5, 15, 5, 7.5),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            child: Text(
                              "Price of service",
                              style: TextStyle(
                                  color: Color.fromRGBO(52, 73, 94, 1),
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rs. "+data['price']+" /-",
                              style: TextStyle(
                                  color: Color.fromRGBO(52, 73, 94, 1),
                                  fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "sairasemi"
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(5, 7.5, 5, 7.5),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            child: Text(
                              "Discount",
                              style: TextStyle(
                                  color: Color.fromRGBO(52, 73, 94, 1),
                                  fontSize: 20,
                                fontFamily: "sairasemi",

                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              " - Rs. $discount"+" /-",
                              style: TextStyle(
                                  color: Color.fromRGBO(252, 72, 97, 1),
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),




                  Container(
                    padding: EdgeInsets.fromLTRB(5, 7.5, 5, 7.5),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            child: Text(
                              "CGST",
                              style: TextStyle(
                                  color: Color.fromRGBO(52 , 73, 94, 1),
                                  fontSize: 20,
                                fontFamily: "sairasemi",

                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rs. $cgst /-",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                fontFamily: "sairasemi",

                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),



                  Container(
                    padding: EdgeInsets.fromLTRB(5, 7.5, 5, 7.5),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            child: Text(
                              "SGST",
                              style: TextStyle(
                                  color: Color.fromRGBO(52, 73, 94, 1),
                                  fontSize: 20,
                                fontFamily: "sairasemi"

                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rs. $sgst /-",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                fontFamily: "sairasemi"
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: Colors.grey
                  ),


                  Container(
                    padding: EdgeInsets.fromLTRB(5, 7.5, 5, 7.5),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            child: Text(
                              "Total Price",
                              style: TextStyle(
                                  color: Color.fromRGBO(52, 73, 94, 1),
                                  fontSize: 20,
                                fontFamily: "sairasemi"
                              ),
                            ),
                          ),
                        ),


                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rs. $total"+"  /-",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                fontFamily: "sairasemi"
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),


                  SizedBox(height: 20),

                  getServiceOnTime(),
                  SizedBox(height: 100),




                ],
              ),
            ),


            getContainerForPrice(),
          ],
        ),
        appBar: AppBar(
          title: Text(
            "Check Out",
            style: TextStyle(
              color: Color.fromRGBO(52, 73, 94, 1),
              fontFamily: "sairasemi",
              fontWeight: FontWeight.w600,
              fontSize: 25,

            ),
          ),
          iconTheme: IconThemeData(
              color: Color.fromRGBO(0,0,102, 1)
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }

  Widget getServiceOnTime()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(

            width: MediaQuery.of(context).size.width,
            child: Text("Shedule Appointment",style: TextStyle(color: Color.fromRGBO(102,102,102, 1),fontSize: 35,fontWeight: FontWeight.bold,fontFamily: "sairasemi"),textAlign: TextAlign.start,)
        ),

        SizedBox(height: 20,),

        Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(200,200,200, 1),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                children: [
                  Expanded(child: Container(child: Text("$formattedDate",style: TextStyle(color: Color.fromRGBO(52, 73, 94, 1),fontSize: 20,fontWeight: FontWeight.bold,),),padding: EdgeInsets.fromLTRB(20, 5, 10, 5),)),
                  Expanded(child: GestureDetector(onTap: (){
                    _selectDate(context);
                  },child: Container(alignment: Alignment.centerRight,child: Icon(Icons.date_range,size: 25,color: Color.fromRGBO(52, 73, 94, 1),),padding: EdgeInsets.fromLTRB(20, 5, 20, 5),)))
                ],
              ),
            ),

            SizedBox(height: 20,),

            Container(
                padding: EdgeInsets.fromLTRB(2.5,10,10,10),

                width: MediaQuery.of(context).size.width,
                child: Text("Select Time",style: TextStyle(color: Color.fromRGBO(102,102,102, 1),fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "sairasemi"),textAlign: TextAlign.start,)
            ),

            SizedBox(height: 10,),


            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  GestureDetector(onTap:(){
                    setState(() {
                      timezone = 0;
                    });
                  },child: Container(child: getTime("5:00 PM - 5:30 PM"),decoration: BoxDecoration(color: timezone == 0 ? Colors.red : Colors.transparent),)),
                  GestureDetector(onTap:(){
                    setState(() {
                      timezone = 1;
                    });
                  },child: Container(child: getTime("5:30 PM - 6:00 PM"),decoration: BoxDecoration(color: timezone == 1 ? Colors.red : Colors.transparent),)),
                  GestureDetector(onTap:(){
                    setState(() {
                      timezone = 2;
                    });
                  },child: Container(child: getTime("6:00 PM - 6:30 PM"),decoration: BoxDecoration(color: timezone == 2 ? Colors.red : Colors.transparent),)),
                  GestureDetector(onTap:(){
                    setState(() {
                      timezone = 3;
                    });
                  },child: Container(child: getTime("6:30 PM - 7:00 PM"),decoration: BoxDecoration(color: timezone == 3 ? Colors.red : Colors.transparent),)),
                  GestureDetector(onTap:(){
                    setState(() {
                      timezone = 4;
                    });
                  },child: Container(child: getTime("7:00 PM - 7:30 PM"),decoration: BoxDecoration(color: timezone == 4 ? Colors.red : Colors.transparent),)),
                  GestureDetector(onTap:(){
                    setState(() {
                      timezone = 5;
                    });
                  },child: Container(child: getTime("7:30 PM - 8:00 PM"),decoration: BoxDecoration(color: timezone == 5 ? Colors.red : Colors.transparent),)),

                ],
              ),
            ),



          ],
        ),
      ],
    );
  }

  int timezone = -1;

  Widget getTime(var time)
  {
    return Container(

      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[800])
      ),
      margin: EdgeInsets.all(2.5),

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          time,
          style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18
          ),
        ),
      ),
    );

  }

  DateTime selectedDate = DateTime.now();
  var formattedDate = "date";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var dateParse = DateTime.parse(picked.toString());
        if(dateParse.month > 9) {
          if(dateParse.day > 9) {
            formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";
          }
          else {
            formattedDate = "${dateParse.year}-${dateParse.month}-0${dateParse.day}";
          }
        }
        else {
          if(dateParse.day > 9) {
            formattedDate = "${dateParse.year}-0${dateParse.month}-${dateParse.day}";
          }
          else {
            formattedDate = "${dateParse.year}-0${dateParse.month}-0${dateParse.day}";
          }
        }
      });
  }


  Widget getContainerForPrice()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(52,73,94,1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rs. $total /-",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      fontFamily: "sairasemi",
                      fontWeight: FontWeight.bold
                    ),
                  ),


                  SizedBox(height: 2,),
                  Row(
                    children: [
                      Text("$formattedDate",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "sairasemi",),),
                      SizedBox(
                        width: 5,
                      ),
                      Text("-",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "sairasemi",),),
                      SizedBox(
                        width: 5,
                      ),
                      Text(timezone == 0 ? "5:00 PM - 5:30 PM" : timezone == 1 ? "5:30 PM - 6:00 PM" : timezone == 2 ? "6:00 PM - 6:30 PM" : timezone == 3 ? "6:30 PM - 7:00 PM" : timezone == 4 ? "7:00 PM - 7:30 PM" : timezone == 5 ? "7:30 PM - 8:00 PM" : "time",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "sairasemi",),),
                    ],
                  )
                ],
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      height: 50,
                      width: 20,
                      alignment: Alignment.centerRight,

                      child: MaterialButton(
                        onPressed: (){
                          // Navigator.push(context,
                          //   MaterialPageRoute(builder: (context) => CheckOut()),
                          // );

                          placeOrder();
                        },
                        child: Text(
                          "PAY",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        color: Colors.grey,
                        elevation: 5,
                      )
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }

  OrderConnection oc = new OrderConnection();

  void placeOrder()
  {
    String orderid = UUID.getUUID();
    String userid = user_data['id'];
    String mobileno = user_data['mobileno'];
    String address = user_data['address'];
    String lat = user_data['lat'];
    String log = user_data['log'];
    String servicename = data['servicename'];
    String cartype = data['cartype'];
    String price = total.toString();
    String ontime = timezone == 0 ? "5:00 PM - 5:30 PM" : timezone == 1 ? "5:30 PM - 6:00 PM" : timezone == 2 ? "6:00 PM - 6:30 PM" : timezone == 3 ? "6:30 PM - 7:00 PM" : timezone == 4 ? "7:00 PM - 7:30 PM" : timezone == 5 ? "7:30 PM - 8:00 PM" : "time";
    String ondate = formattedDate;
    String status = "waiting";
    String takenbyid = "no one";
    String time = "time";
    String date = "date";
    oc.placeOrder(orderid, userid, mobileno, address, lat, log, servicename,cartype, price, ontime, ondate, status, takenbyid, time, date);

    Fluttertoast.showToast(
      msg: "welcome",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromRGBO(0, 0, 102, 1),
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Navigator.pop(context);
  }
}