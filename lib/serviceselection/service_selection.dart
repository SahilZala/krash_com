import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krash_company/checkout/check_out.dart';
import 'package:krash_company/DatabaseConnection/get_services.dart';

class ServiceSelection extends StatefulWidget{
  Map data;
  String service_name;
  String car_type;
  _ServiceSelection createState() => _ServiceSelection(data,service_name,car_type);

  ServiceSelection(this.data, this.service_name, this.car_type);
}

class _ServiceSelection extends State<ServiceSelection> {
  Map data;
  String service_name;
  String car_type;


  var _service_data = null;
  _ServiceSelection(this.data, this.service_name, this.car_type);

  @override
  void initState() {
    super.initState();

    GetService gs = new GetService(data,service_name,car_type);

    setState(() {
      _progress_indicator = 1;
    });
    gs.getServiceList().then((value){

      if(value.isEmpty){
        Fluttertoast.showToast(
        msg: "Service not available",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
        fontSize: 16.0
        );

        setState(() {

          _progress_indicator = 0;
        });
      }
      else{

        setState(() {
  //        print(rectifyData(value));
          _service_data = value;


          getServiceList();
        });

      }
    });
  }

  int _progress_indicator = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getBannerTitle(),
                  getCarWashingList(),
                  SizedBox(height: 100,),
                ],
              ),
            ),
          //  getContainerForPrice(),



            _progress_indicator == 1 ? Center(
              child: CircularProgressIndicator( backgroundColor: Color.fromRGBO(0, 0, 102, 1),
                valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent[100]),
                strokeWidth: 6, ),
            ) : SizedBox(),


            //getContainerForPrice()
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Color.fromRGBO(0,0,102, 1)
        ),
        backgroundColor: Colors.white,

        title: Text(
          "car service at home",
          style: TextStyle(
              color: Color.fromRGBO(0,0,102, 1),
              fontSize: 20
          ),
        ),
      ),
    );
  }

  Widget getBannerTitle() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car_type,
            style: TextStyle(
                color: Color.fromRGBO(102,0,0, 102),
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 130,
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
                            fontSize: 20
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
                            fontSize: 15
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),

          )
        ],
      ),

    );
  }

  Widget getCarWashingList() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: _service_list_pointer == 1 ? _service_list : _service_list_pointer == 3 ? [Center(child: Text("Service not available in this area",style: TextStyle(fontSize: 20,color: Colors.red[200]),)),] : [],
      ),
    );
  }


  int _service_list_pointer = 0;

  List<Widget> _service_list = new List();

  void getServiceList()
  {
    setState(() {

      if(_service_data != null){

        _service_list.clear();
        for(int i=0;i<_service_data.length;i++){

          fetch_vendor_data(_service_data[i]["mobileno"], _service_data[i]["aid"]).then((value){
            double distanceInMeters = Geolocator.distanceBetween(
                double.parse(value["lat"]), double.parse(value["log"]),
                double.parse(this.data["lat"]), double.parse(this.data["log"]));

            if(distanceInMeters < 2000){

              String id = _service_data[i]['serviceid'];

              //print(_service_data[i]);

              _service_list.add(getCarWashingWidget(_service_data[i],_service_list.length));
              //_service_list.add(getCarWashingWidget(_service_data[i],_service_list.length));
//
           //   _service_list.add(ServiceComponent(_service_data[i],_service_list.length));
            }


            setState(() {
              _progress_indicator = 0;
              _service_list_pointer = 1;
              if(distanceInMeters > 2000 && _service_list_pointer == 0){
                _service_list_pointer = 3;
              }
            });
          });
        }
      }
      else{
        _service_list.clear();
        _service_list.add(Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,

          child: Center(
            child: Text("!Opps Service not available",style: TextStyle(color: Colors.black,fontSize: 30),),
          ),

        ));
      }
    });
  }




  Widget getCarWashingWidget(data,int index)
  {
    String id = data['serviceid'];
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
            ),
            child: Center(
              child: Text("Best Seller",
                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getImages("https://thumbs.dreamstime.com/b/foaming-red-auto-car-wash-cleaning-service-foaming-red-auto-car-wash-130560890.jpg"),
                  getImages("https://img.indianauto.com/2020/05/29/l2AZQYjw/car-washing-876a.jpg"),
                  getImages("https://images.theconversation.com/files/76578/original/image-20150331-1231-1ttwii6.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip"),
                  getImages("https://thumbs.dreamstime.com/b/foaming-red-auto-car-wash-cleaning-service-foaming-red-auto-car-wash-130560890.jpg"),
                  getImages("https://img.indianauto.com/2020/05/29/l2AZQYjw/car-washing-876a.jpg"),
                  getImages("https://images.theconversation.com/files/76578/original/image-20150331-1231-1ttwii6.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=926&fit=clip"),
                ],
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: Text(data["servicename"],style: TextStyle(
                          color: Color.fromRGBO(0,0,102, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        alignment: Alignment.centerLeft,

                        color: Colors.white,
                        child: Text("4.7 ratting",style: TextStyle(
                            color: Color.fromRGBO(122,150,240, 1),
                            fontSize: 18,
                        ),),
                      ),
                    ],
                  )
              ),
              Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    height: 50,
                    width: 20,
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CheckOut(data)),
                        );
                      },
                      child: Text(
                        "CHECK+",
                        style: TextStyle(
                          color: Color.fromRGBO(122, 150, 240, 1)
                        ),
                      ),
                      color: Colors.white,
                      elevation: 5,
                    )
                  )
              ),
            ],
          ),

          Container(
            height: 20,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),

            alignment: Alignment.centerRight,
            child: Text(
              data['price'],
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            height: 78,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),

                    child: Text(
                      "Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      data["description"],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
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

  Widget getImages(var imageurl)
  {
    return Container(
      margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
      height: 60,
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageurl
          ),
          fit: BoxFit.cover,
        )
      ),
    );
  }


  Widget getContainerForPrice()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0,0,102, 1),
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
              Container(
                alignment: Alignment.center,
                height: 45,
                width: 45,
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,width: 2.0)
                ),
                child: Text(
                  "0",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),

              Text(
                "Rs. 198/-",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      height: 50,
                      width: 20,
                      alignment: Alignment.centerRight,

                      child: MaterialButton(
                        onPressed: (){
                       //  print(isSelected);
                       //    Navigator.push(context,
                       //      MaterialPageRoute(builder: (context) => CheckOut()),
                       //    );
                        },
                        child: Text(
                          "CHECK",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                        color: Color.fromRGBO(0,0,102, 1),
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


  // int i = 0;
  // List<Map> new_service = new List();
  //
  //
  // List rectifyData(List services)
  // {
  //   if(i==services.length){
  //     print("end");
  //     return services;
  //   }
  //   else{
  //     fetch_vendor_data(services[i]["mobileno"], services[i]["aid"]).then((value){
  //       double distanceInMeters = Geolocator.distanceBetween(
  //           double.parse(value["lat"]), double.parse(value["log"]),
  //           double.parse(this.data["lat"]), double.parse(this.data["log"]));
  //
  //
  //       print(distanceInMeters);
  //
  //       if (distanceInMeters < 2000) {
  //         new_service.add(services[i]);
  //       }
  //       i++;
  //
  //       print(new_service.length);
  //       return rectifyData(new_service);
  //     });
  //   }
  // }


  Future<Map> fetch_vendor_data(String mob,String aid)
  async {
    var graphQLDocument = '''
      query MyQuery {
      listUserDatas(filter: {mobileno: {eq: "$mob"}, id: {eq: "$aid"}, activation: {eq: "true"}}) {
        items {
          id
          lat
          log
          address
          city
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

    return val["listUserDatas"]["items"][0];
  }




}

