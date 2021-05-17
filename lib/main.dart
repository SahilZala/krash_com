//created by sahil zala

import 'dart:async';
import 'dart:convert';

import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/types/exception/AmplifyAlreadyConfiguredException.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krash_company/amplifyconfiguration.dart';
import 'login_signup.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Color.fromRGBO(0,0,102, 1), // status bar color
  ));
  await runApp(

      MaterialApp(
          home: SplashScreen()));
}

class SplashScreen extends StatefulWidget
{
  _SplashScreen createState() => _SplashScreen();
}
class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _configureAmplify();

    //pushTodo();

    // Timer(Duration(seconds: 3),
    //         () =>
    //         Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder:
    //                 (context) =>
    //                 LoginSignup()
    //             )
    //         )
    // );

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 90,
                width: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/logo.png"),fit: BoxFit.fill),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _configureAmplify() async {

    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    AmplifyStorageS3 as = AmplifyStorageS3();
    Amplify.addPlugins([authPlugin, analyticsPlugin,as]);

    Amplify.addPlugin(AmplifyAPI());


    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.

    try {
      await Amplify.configure(amplifyconfig).whenComplete(() async {
        print("configure succesfully");

        Fluttertoast.showToast(
          msg: "Configured succesfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(0, 0, 102, 1),
          textColor: Colors.white,
          fontSize: 16.0,
        );



        //getData();

        Timer(Duration(seconds: 3),
                () =>
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        LoginSignup()
                    )
                )
        );
      });
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }


  Future<void> pushTodo() async {
    try {
      String graphQLDocument =
      '''mutation CreateTodo(\$name: String!, \$description: String) {
              createTodo(input: {name: \$name, description: \$description}) {
                id
                name
                description
              }
        }''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(document: graphQLDocument, variables: {
            'name': 'my first sahil todo',
            'description': 'todo description',
          }));

      var response = await operation.response;
      var data = response.data;

      print('Mutation result: $data');
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  // Future<List> getData()
  // async {
  //   try {
  //     Map userData = null;
  //     String graphQLDocument = '''query ListUserDatas {
  //     listUserDatas {
  //       items {
  //         id
  //         userid
  //         name
  //         mail
  //         city
  //         address
  //         lat
  //         log
  //         mobileno
  //         time
  //         date
  //         profile
  //         activation
  //       }
  //       nextToken
  //     }
  //   }''';
  //
  //     var operation = Amplify.API.query(
  //         request: GraphQLRequest<String>(
  //           document: graphQLDocument,
  //         ));
  //
  //     var response = await operation.response;
  //     var data = response.data;
  //
  //     print('Query result: ' + data);
  //
  //   } on ApiException catch (e) {
  //     print('Query failed: $e');
  //   }
  // }

}