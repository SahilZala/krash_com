
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krash_company/checkout/new_check_out.dart';

class ServiceSelection extends StatefulWidget
{
  Map data;
  String service_name;
  String car_type;

 _ServiceSelection createState() => _ServiceSelection(data,service_name,car_type);

  ServiceSelection(this.data, this.service_name, this.car_type);
}

class _ServiceSelection extends State<ServiceSelection>
{
  Map data;
  String service_name;
  String car_type;
  int _progress_indicator = 1;
  int _service_list_pointer = 1;

  _ServiceSelection(this.data, this.service_name, this.car_type);

  @override
  Widget build(BuildContext context) {
     return SafeArea(
         child: Scaffold(
           appBar: AppBar(
             title: Text(
                 "Services",
              style: TextStyle(
                color: Color.fromRGBO(0,0,102, 1),
                fontSize: 18,
                fontFamily: "sairasemi",
              ),
             ),
             iconTheme: IconThemeData(
                 color: Color.fromRGBO(0,0,102, 1)
             ),
             backgroundColor: Colors.white,
             elevation: 0,
           ),

           body: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Stack(
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 20,width: 0,),
                     getBannerTitle(),
                     SizedBox(height: 20,width: 0,),

                     getService(),

                     // _progress_indicator == 3 ?
                     //     Text("no data found") :
                     // _service_list_pointer == 1 ?
                     // Text("wait Loading data")
                     //     :
                     // Column(
                     //     children: getList())
                   ],
                 ),

                 // _progress_indicator == 1 ? Center(
                 //   child: CircularProgressIndicator( backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                 //     valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent[100]),
                 //     strokeWidth: 6, ),
                 // ) : SizedBox(),


               ],
             ),
           ),
         )
     );
  }

  Widget getBannerTitle() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car_type,
            style: TextStyle(
                color: Color.fromRGBO(70, 89, 108, 1),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              fontFamily: "sairasemi",
            ),
          ),
          SizedBox(height: 5,width: 0,),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: MediaQuery
                .of(context)
                .size
                .width,

            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

            decoration: BoxDecoration(
                color: Color.fromRGBO(70, 89, 108, 1)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Icon(
                    Icons.directions_car_sharp,
                    size: 40,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 0, 10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 90,
                      child: Text("At-home convenience with trusted experts",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 0, 10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 90,
                      child: Text(
                        "Make car look brand new with best car washing and servicing team",
                        style: TextStyle(
                            color: Colors.red[200],
                            fontSize: 15,
                          fontFamily: "sairasemi",
                        ),
                      ),
                    ),


                  ],
                )
              ],
            ),

          )
        ],
      ),

    );
  }


  List<Widget> service_widget_list;

  void getListofService()
  {
    _progress_indicator = 0;
    if(serviceList.isNotEmpty) {

      //print("sashhhhha");
      service_widget_list.clear();
      for (int i = 0; i < serviceList.length; i++) {
        setState(() {
          service_widget_list.add(getListWidget(serviceList[i],i));
        });
      }

      setState(() {
        if (service_widget_list.isNotEmpty) {
          _service_list_pointer = 2;
        }
      });
    }
  }

  Widget getListWidget(servicedata,vendordata)
  {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        padding: EdgeInsets.fromLTRB(10,10,10,10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      child: Text(servicedata['title'],
                        style: TextStyle(
                          color: Color.fromRGBO(52, 73, 94, 1),
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: "sairasemi",
                        ),
                      ),
                    )
                ),

                Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 22,
                          width: 1,
                          color: Colors.grey,
                        ),

                        SizedBox(width: 5,height: 0,),
                        Container(
                          width: 80,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color.fromRGBO(70, 89, 108, 1),
                          ),

                          alignment: Alignment.center,
                          child: Text(
                            servicedata['price'],
                            style: TextStyle(
                               color: Colors.white,
                              fontSize: 15,
                              fontFamily: "sairasemi",
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ],
                      verticalDirection: VerticalDirection.up,
                    )
                ),
              ],
            ),

            SizedBox(
              height: 10,
              width: 0,
            ),

            Row(
              children: [
                Container(
                  height: 20,
                  child: RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 22.0,
                    direction: Axis.horizontal,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),

                SizedBox(width: 10,height: 0,),

                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey,
                ),


                SizedBox(width: 10,height: 0,),


                Text(
                 vendordata['name'] ,
                  style: TextStyle(
                    color: Color.fromRGBO(70, 89, 108, 1),
                    fontSize: 14,
                    fontFamily: "sairasemi",
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
              width: 0,
            ),


            Text(
               vendordata['address'] ,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromRGBO(70, 89, 108, 1),
                fontSize: 16,
                fontFamily: "sairasemi",
              ),
            ),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    service_name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color.fromRGBO(70, 89, 108, 1),
                      fontSize: 16,
                      fontFamily: "sairasemi",
                    ),
                  ),
                ),
                Container(
                  height: 30,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.amber,
                  ),

                  alignment: Alignment.center,

                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CheckOut(servicedata,vendordata,data)),
                      );
                    },
                    child: Text(
                      "Book Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: "sairasemi",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ),
              ],
            ),
          ],
        ),
      );
  }


  @override
  void initState() {
    super.initState();

    service_widget_list = new List();
    serviceList = new List();
    service_provider_list = new List();
   // fetchNearByUser();
    //getListofService();

  }

  List<Map> serviceList;
  List<Map> service_provider_list;
  void fetchNearByUser()
  {
    setState(() {

      fetch_vendor_data().then((value){

        print(value);
        if(value != null) {
          print(value);
          print(value.length);


          // for (int i = 0; i < value.length; i++) {
          //   getServiceList(service_name, car_type, value[i]['id']).then((val) {
          //     if (val != null) {
          //       setState(() {
          //         print("jjjj");
          //         print(service_provider_list);
          //
          //         for (int j = 0; j < val.length; j++) {
          //           // print("service provider list");
          //           // print(service_provider_list);
          //           service_provider_list.add(value[i]);
          //
          //           serviceList.add(val[j]);
          //         }
          //       });
          //
          //       //  print(serviceList);
          //       getListofService();
          //     }
          //     else {
          //       setState(() {
          //         if (serviceList.isEmpty) {
          //           _progress_indicator = 3;
          //         }
          //       });
          //     }
          //   });
          // }
        }
        else {

          setState(() {
            _progress_indicator = 3;
          });
        }

      }).whenComplete(() {
        setState(() {
          _progress_indicator = 2;
        });
      });
    });
  }

  Widget getService()
  {
    return FutureBuilder(
        builder: (ctx,snapshot){

          if(snapshot.connectionState == ConnectionState.done)
          {
            if(snapshot.hasData)
            {
              return FutureBuilder(builder: (ctx,snapshot1){

                if(snapshot1.connectionState == ConnectionState.done)
                {
                  if(snapshot1.hasData)
                  {

                      service_widget_list.clear();

                      for (int i = 0; i < snapshot.data.length; i++) {
                        for (int j = 0; j < snapshot1.data.length; j++) {
                          if (snapshot.data[i]['id'] == snapshot1
                              .data[j]['aid'] && snapshot1
                              .data[j]['servicename'] == service_name &&
                              snapshot1.data[j]['cartype'] == car_type) {
                            service_widget_list.add(getListWidget(
                                snapshot1.data[j], snapshot.data[i]));
                          }
                        }
                      }
                      return SingleChildScrollView(
                          child: Column(children: service_widget_list));
                  }
                  else if(snapshot1.data == null)
                  {
                    return Text("no data");
                  }
                  else if(snapshot1.hasError)
                  {
                    return Text("no data");
                  }
                }


                return CircularProgressIndicator();
                },
                future: getServiceList(service_name, car_type),
              );
            }
            else if(snapshot.data == null)
            {
              return Text("no data");
            }
            else if(snapshot.hasError){
             return Text("no data");
            }
          }

          return CircularProgressIndicator();
        },
      future: fetch_vendor_data(),

    );
  }


  List<Widget> getList()
  {
    return service_widget_list;
  }

  Future<List> fetch_vendor_data()
  async {
    var graphQLDocument = '''
      query MyQuery {
      listUserDatas(filter: {activation: {eq: "true"}}) {
        items {
          id
          lat
          log
          address
          city
          name
        }
      }
    }
    ''';

    var operation = Amplify.API.query(
        request: GraphQLRequest<String>(
          document: graphQLDocument,
        ));

    var response = await operation.response;
    Map val = json.decode(response.data);

    List value = List();
    value = val["listUserDatas"]["items"];

    List shorted_value = List();

    if(value != null || value.isNotEmpty) {
      shorted_value.clear();

      for (int i = 0; i < value.length; i++) {
        double distanceInMeters = Geolocator.distanceBetween(
            double.parse(value[i]["lat"]), double.parse(value[i]["log"]),
            double.parse(this.data["lat"]), double.parse(this.data["log"]));

        if (distanceInMeters < 2000) {
          shorted_value.add(value[i]);
        }
      }

      if(shorted_value.isEmpty)
      {
        return null;
      }
      else {
        return shorted_value;
      }
    }
    else {

      return null;
    }

  }


  Future<List> getServiceList(String servicename,String cartype)
  async {
    {
      var graphQLDocument = '''
      query MyQuery {
      listServices(filter: {servicename: {eq: "$servicename"}, cartype: {eq: "$cartype"}}) {
        items {
          id
          approvelid
          aid
          uid
          title
          mobileno
          cartype
          servicename
          description
          date
          time
          price
          discount
          serviceid
          activation
        }
      }
    }
    ''';

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
            document: graphQLDocument,
          ));

      var response = await operation.response;
      //print("jjjkkk");
      //print(response);
      Map val = json.decode(response.data);



      List list = val["listServices"]["items"];
      if(list.isNotEmpty)
      {
        //print("sasas");
        //print(val["listServices"]["items"]);
        return val["listServices"]["items"];

      }
      else {
        return null;
      }
    }
  }



}