import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home_screen.dart';

class Profile extends StatefulWidget
{
  Map data;
  _Profile createState() => _Profile(data);

  Profile(this.data);
}
class _Profile extends State<Profile>
{

  final _formKey = GlobalKey<FormState>();
  Map data;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();




  _Profile(this.data);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(data),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.white
            ),),
          backgroundColor: Color.fromRGBO(52, 73, 94, 1),

          elevation: 0,

          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0,0,102, 1)),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(data),
                ),
              )
          ),

        ),
        backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },

                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1)
                            ),
                            labelText: "Enter Name",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(52, 73, 94, 1),
                              fontSize: 20
                            ),

                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1,color: Color.fromRGBO(52, 73, 94, 1))
                            ),
                          ),
                        ),

                        SizedBox(height: 15,),

                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },

                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1)
                            ),
                            labelText: "Enter main id",
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(52, 73, 94, 1),
                                fontSize: 20
                            ),

                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1,color: Color.fromRGBO(52, 73, 94, 1))
                            ),
                          ),
                        ),


                      ],),
                    ),
                  )

                ],
              ),

              getContainerForPrice()
            ],
          ),
        ),
      ),
    );
  }

  Widget getContainerForPrice()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          height: 65,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
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
              if(_formKey.currentState.validate())
              {
                updateProfile(name.text,email.text,data['id'],data['userid'],data['mobileno']).then((value) {
                  if(value != null)
                  {
                    data = value;
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen(data)),
                    );
                  }
                  else {

                  }
                });
              }
            },
            color: Color.fromRGBO(70, 89, 108, 1),
            child: Text("UPDATE",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          ),
        ),
      ],
    );
  }

  Future<Map> updateProfile(String name,String mail,String id,String userid,String mobileno)
  async {
    String graphQLDocument = '''mutation MyMutation {
      updateClientData(input: {name: "$name", mail: "$mail", id: "$id"}, condition: {mobileno: {eq: "$mobileno"}, userid: {eq: "$userid"}}) {
        activation
        address
        createdAt
        date
        id
        lat
        log
        mail
        mobileno
        name
        profile
        time
        updatedAt
        userid
      }
    }
    ''';

    var operation = Amplify.API.mutate(
        request: GraphQLRequest<String>(
          document: graphQLDocument,
        ));

    var response = await operation.response;
    //var data = response.data;

    Map val = json.decode(response.data);


    return val['updateClientData'];
  }
}