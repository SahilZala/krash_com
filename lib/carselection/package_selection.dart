import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krash_company/serviceselection/_new_service_selection.dart';

class PackageSelection extends StatefulWidget
{
  Map data;
  String service_name;
  _PackageSelection createState() => _PackageSelection(data,service_name);

  PackageSelection(this.data, this.service_name);
}

class _PackageSelection extends State<PackageSelection>
{
  Map data;
  String service_name;


  _PackageSelection(this.data, this.service_name);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
          SliverAppBar(
              backgroundColor: Color.fromRGBO(0,0,102,1),
              // Allows the user to reveal the app bar if they begin scrolling back
              // up the list of items.
              floating: true,
              pinned: true,

              // Display a placeholder widget to visualize the shrinking size.
              flexibleSpace: FlexibleSpaceBar(
                title:Text(
                  "CAR WASHING SERVICE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21
                  ),
                ),
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("https://images.squarespace-cdn.com/content/v1/57bf69aa9f7456b465a1ef78/1552972248385-JLADWPA6BC7YCPRKRFM4/ke17ZwdGBToddI8pDm48kLkXF2pIyv_F2eUT9F60jBl7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z4YTzHvnKhyp6Da-NYroOW3ZGjoBKy3azqku80C789l0iyqMbMesKd95J-X4EagrgU9L3Sa3U8cogeb0tjXbfawd0urKshkc5MgdBeJmALQKw/service-page-mobile-car-wash-2500x1667.jpg?format=2500w"),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),



                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end:
                          Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
                          colors: [
                            Colors.black26,
                            Colors.black54,
                            Colors.black
                          ], // red to yellow
                           // repeats the gradient over the canvas
                        ),
                      ),
                    ),

                    getDesingPattern(),

                  ],
                ),
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
              ),
              // Make the initial height of the SliverAppBar larger than normal.
              expandedHeight: 400,
              stretch: true,

            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              getPackages(),
              getSafetContainer(),
              getBanner2(),
              getCustomerReviewList()
            ],
          ),
        ),
      ),
    );
  }

  Widget getPackages()
  {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Available Packages",
              style: TextStyle(
                color: Color.fromRGBO(102,0,0,102),
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 5),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceSelection(data,service_name,"HATCHBACK")),
                      );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                            "images/hatchback.jpg"
                          ),fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.black
                        ),
                      ),

                      Text(
                        "HATCHBACK",
                        style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )),


              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 5),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceSelection(data,service_name,"SEDAN")),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                "images/sedan.jpg"
                            ),fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.black
                        ),
                      ),

                      Text(
                        "SEDAN",
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )),

              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 5),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceSelection(data,service_name,"SUB-COMPACT SUV")),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                "images/ssuv.jpg"
                            ),fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.black
                        ),
                      ),

                      Text(
                        "SUB-COMPACT SUV",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontWeight: FontWeight.bold,

                        ),
                      )
                    ],
                  ),
                ),
              )),

            ],
          ),




          Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 5),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceSelection(data,service_name,"MUV-SUV")),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                "images/muvsuv.jpg"
                            ),fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.black
                        ),
                      ),

                      Text(
                        "MUV-SUV",
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )),


              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 5),
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ServiceSelection(data,service_name,"LUXURY")),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                "images/luxury.jpg"
                            ),fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            color: Colors.black
                        ),
                      ),

                      Text(
                        "LUXURY",
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1),
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              )),

              Expanded(child: Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 5),
                height: 150,


              )),

            ],
          )

        ],
      ),
    );
  }

  Widget getDesingPattern()
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      decoration: BoxDecoration(
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: MediaQuery.of(context).size.width/1.8,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight:Radius.circular(20))
            ),
            child: Text(
              "Professionals trained",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: MediaQuery.of(context).size.width/2.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight:Radius.circular(20))
            ),
            child: Text(
              "Many Problem One Solution",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12
              ),
            ),
          ),

        ],
      ),
    );
  }


  Widget getSafetContainer()
  {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 15),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Safety First",
              style: TextStyle(
                  color: Color.fromRGBO(102,0,0,102),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 0),
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 2, 10),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                              "images/mask.png"
                          ),fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                    ),

                    Text(
                      "use of mask & gloves",
                      style: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(2.5, 5, 2.5, 0),
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 2, 10),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                              "images/temprature_check.png"
                          ),fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                    ),

                    Text(
                      "temprature check done",
                      style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.fromLTRB(5, 5, 2.5, 0),
                height: 90,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(243, 243, 243, 1)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 2, 10),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(
                              "images/hand_wash.png"
                          ),fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                    ),

                    Text(
                      "hand sanitizer",
                      style: TextStyle(
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget getBanner2()
  {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      height: 110,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(child: Container(
            child: Icon(Icons.local_fire_department,size: 40,color: Color.fromRGBO(52, 73, 94, 1),),
          )),

          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "50% OFF",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(52, 73, 94, 1),
                        fontSize: 24
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Text(
                    "On Car Services",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/car_vector.png"
                  ),
                  fit: BoxFit.fill,
                )
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(245, 255, 126, 1),
      ),
    );
  }

  Widget getCustomerReviewList()
  {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        color: Colors.white
      ),


      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 30),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "What customers says",
              style: TextStyle(
                  color: Color.fromRGBO(102,0,0,102),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          getCustomerReview(),
          getCustomerReview()
        ],
      ),
    );
  }

  Widget getCustomerReview()
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(52, 73, 94, 1),
                ),
              ),
              Expanded(
                flex:1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("username",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 2),
                      ),

                      Container(
                        child: Text("time",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 15,

                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                      ),

                    ],
                  )
              ),

              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

                child: Text(
                    "4.8*",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(60, 5, 10, 10),

            child: Text(
              "rating about service in details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15
              ),
            ),
          ),


          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(60, 5, 10, 10),
            height: 2,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[500]
            ),
          ),
        ],
      ),
    );
  }
}