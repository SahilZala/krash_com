import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:krash_company/carselection/package_selection.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:krash_company/home/new_address_picker.dart';
import 'package:krash_company/home/profile.dart';

class HomeScreen extends StatefulWidget
{
  Map data;
  _HomeScreen createState() => _HomeScreen(data);

  HomeScreen(this.data);
}
class _HomeScreen extends State<StatefulWidget>
{
  final List<String> imgList = [
    'https://addressautoworkshop.com/wp-content/uploads/2020/05/Car-Wash-Image.jpg',
    'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/soap-suds-and-water-on-car-royalty-free-image-1588968576.jpg',
    'https://cimg1.ibsrv.net/cimg/www.audiworld.com/1600x900_85-1/529/Best-Car-Wash-Best-of-Western-Washington-2016-Vote-NorthWest-Auto-Salon-17-362529.jpg',
    'https://yourdoorstep.co/gallery/car-wash-near-me.jpg',
    'https://junkmailimages.blob.core.windows.net/large/65240ddaa07d44a68c4d6e111351c623.jpg',
    'https://www.columbiatireauto.com/Portals/7/soft-touch-car-wash-pros-cons.PNG'
  ];

  Map data;


  _HomeScreen(this.data);

  final List<String> _appTitle = ["Home","Bookings","Profile"];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions;

  @override
  void initState() {

    print("home");
    print(data);
  }

  GlobalKey _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    _widgetOptions = <Widget>[
      getOfferBanner(),
      Text('Bookings', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
      getProfile(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        appBar: AppBar(
          title: Text(
              _appTitle[_selectedIndex],
          style: TextStyle(
            color: Colors.white
          ),),
          backgroundColor: Color.fromRGBO(0,0,102, 1),

          elevation: 0,
        ),

      bottomNavigationBar:BottomNavigationBar(
        fixedColor: Color.fromRGBO(0,0,102, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) {
          // Respond to item press.
          setState(() => _selectedIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            title: Text('HOME'),
            icon: Icon(Icons.book_online_outlined),
          ),
          BottomNavigationBarItem(
            title: Text('BOOKINGS'),
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            title: Text('PROFILE'),
            icon: Icon(Icons.map),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            getAddress(),
            Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOfferBanner()
  {
    return Container(
      height: MediaQuery.of(context).size.height-180,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [

            getScreenCrousel(),

            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(child: Container(
                    child: Icon(Icons.directions_car_sharp,size: 40,color: Colors.white,),
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
                            "Manage Garage",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.white,
                              fontSize: 25
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Text(
                            "Vehicle and damage reports",
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
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.navigate_next,
                        color: Color.fromRGBO(52, 73, 94, 1),
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromRGBO(0,0,102, 1),
              ),
            ),

            getCategoryBanner(),

            getCarService(),

            getBanner2()
          ],
        ),
      ),
    );
  }

  Widget getScreenCrousel()
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: 180,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16/9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,


          scrollDirection: Axis.horizontal,
        ),
        items: imgList.map((item) => Container(
          child: Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image:NetworkImage(item),
                    fit: BoxFit.fill
                  ),
                ),

              )
          ),
        )).toList(),),
    );
  }

  Widget getAddress()
  {
    return Container(

      width: MediaQuery.of(context).size.width,
      height: 30,

      decoration: BoxDecoration(
        color: Color.fromRGBO(0,0,102,1),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
            height: 18,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/location_icon.png")
                )
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewAddressPicker(data)));
            },
            child: Container(
              width:MediaQuery.of(context).size.width/1.11,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                        data["address"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCategoryBanner()
  {
    return Container(
      margin: EdgeInsets.all(5),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white
      ),
      child: Row(
        children: [
          Expanded(child: Container(
            margin: EdgeInsets.all(2),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PackageSelection()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "images/car_washing.png"
                            )
                        )
                    ),
                  ),

                  Text(
                    "car washing",
                    style: TextStyle(
                      color: Color.fromRGBO(52, 73, 94, 1),
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
          Expanded(child: Container(
            margin: EdgeInsets.all(2),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "images/car_service.png"
                          )
                      )
                  ),
                ),

                Text(
                  "car repairing",
                  style: TextStyle(
                    color: Color.fromRGBO(52, 73, 94, 1),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
          Expanded(child: Container(
            margin: EdgeInsets.all(2),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "images/tier_installing.png"
                          )
                      )
                  ),
                ),

                Text(
                  "equipment installing",
                  style: TextStyle(
                    color: Color.fromRGBO(52, 73, 94, 1),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
          Expanded(child: Container(
            margin: EdgeInsets.all(2),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "images/tier_repairing.png"
                      )
                    )
                  ),
                ),

                Text(
                  "tier repairing",
                  style: TextStyle(
                    color: Color.fromRGBO(52, 73, 94, 1),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget getCarService()
  {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      height: 390,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            width: MediaQuery.of(context).size.width,

            child: Text(
              "Car Services",
              style: TextStyle(
                color: Color.fromRGBO(102,0,0,102),
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: MediaQuery.of(context).size.width,

            child: Text(
              "servicing, repairing, installation & uninstallation",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 150,
                  color: Color.fromRGBO(245, 242, 255, 1),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/car-transport.png"
                                )
                            )
                        ),
                      ),

                      Text(
                        "CAR SERVICING",
                        style: TextStyle(
                          color: Color.fromRGBO(52, 73, 94, 1),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 150,
                  color: Color.fromRGBO(245, 242, 255, 1),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/tyre_repairing.png"
                                )
                            )
                        ),
                      ),

                      Text(
                        "CAR REPAIRING",
                        style: TextStyle(
                          color: Color.fromRGBO(52, 73, 94, 1),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 150,
                  color: Color.fromRGBO(245, 242, 255, 1),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/parts_installing.png"
                                )
                            )
                        ),
                      ),

                      Text(
                        "PARTS INSTALLING",
                        style: TextStyle(
                          color: Color.fromRGBO(52, 73, 94, 1),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  height: 150,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getBanner2()
  {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 110,
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
                    "CAR EQUIPMENTS",
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
                    "all car equipments are here in resonable price",
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
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.navigate_next,
                color: Color.fromRGBO(52, 73, 94, 1),
                size: 40,
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

  Widget getProfile()
  {
    return Container(
      height: MediaQuery.of(context).size.height-180,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 3),
                          child: Text("User Name",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(52, 73, 94, 1)
                          ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
                          child: Text("main id",style: TextStyle(
                              fontSize: 18,
                            color: Colors.grey
                          ),),
                        ),


                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 0, 0),
                          child: Text("mobile number",style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                          ),),
                        )

                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      height: 80,
                      width: 50,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Profile()),
                            );
                          },
                          child: Icon(Icons.edit,color: Color.fromRGBO(52, 73, 94, 1))),
                      alignment: Alignment.topRight,
                    ),
                  ),
                ],
              ),
            ),


            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(child: Text("Help Center",style: TextStyle(color: Color.fromRGBO(145, 145, 145, 1),fontSize: 20),),onTap: (){
                    getHelp();
                  },),
                  Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,margin: EdgeInsets.fromLTRB(0, 15, 0, 15),),

                  Text("About Krash Company",style: TextStyle(color: Color.fromRGBO(145, 145, 145, 1),fontSize: 20),),
                  Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,margin: EdgeInsets.fromLTRB(0, 15, 0, 15),),

                  Text("History",style: TextStyle(color: Color.fromRGBO(145, 145, 145, 1),fontSize: 20),),
                  Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,margin: EdgeInsets.fromLTRB(0, 15, 0, 15),),

                  Text("Address",style: TextStyle(color: Color.fromRGBO(145, 145, 145, 1),fontSize: 20),),
                  Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,margin: EdgeInsets.fromLTRB(0, 15, 0, 15),),

                  GestureDetector(child: Text("Logout",style: TextStyle(color: Color.fromRGBO(145, 145, 145, 1),fontSize: 20),),onTap: (){
                    getLogout();
                  },),
                  Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,margin: EdgeInsets.fromLTRB(0, 15, 0, 15),),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  void getLogout()
  {
    showCupertinoDialog(
      context: context,
      builder: (a){
        return CupertinoAlertDialog(title: Text("logout?"),
          content: Text("Are you sure?"),
          actions: [
            CupertinoDialogAction(onPressed: (){
              Navigator.of(context).pop();
            },child: Text("NO"),),
            CupertinoDialogAction(onPressed: (){},child: Text("YES"),),
          ],);
      }
    );
  }

  void getHelp()
  {
   _modalBottomSheetMenu();
  }

  TextEditingController _textEditingController = new TextEditingController();

  String help = "";

  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(

            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(padding: EdgeInsets.fromLTRB(5, 10, 0, 10),child: Text("Ask Us?",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

                    Form(
                      child: TextFormField(
                        onChanged: (value){
                          help = value;
                        },
                        controller: _textEditingController,
                        validator: (value) {
                          if (value.isEmpty) {
                            help = value;
                            return 'Please enter some text';
                          }
                          return null;
                        },

                        maxLines: 5,
                        textAlignVertical: TextAlignVertical.top,

                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)
                          ),
                          labelText: "Enter Name",
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(52, 73, 94, 1),
                              fontSize: 15
                          ),

                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Color.fromRGBO(52, 73, 94, 1))
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),

                      child: RaisedButton(
                        onPressed: (){
                          print(help);
                          Navigator.pop(context);
                        },
                        color: Color.fromRGBO(70, 89, 108, 1),
                        child: Text("UPDATE",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),

                  ],
                ),
              )
            )
          );
        }
    );
  }
}
