import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:geolocator/geolocator.dart';

class GetService{
  Map data;
  String service_name;
  String car_type;

  GetService(this.data, this.service_name, this.car_type);

  Future<List> getServiceList()
  async {
    {
      var graphQLDocument = '''
      query MyQuery {
      listServices(filter: {servicename: {eq: "$service_name"}, cartype: {eq: "$car_type"}}) {
        items {
          id
          approvelid
          aid
          uid
          mobileno
          cartype
          servicename
          description
          date
          time
          urls
          price
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
      Map val = json.decode(response.data);

      return val["listServices"]["items"];
    }
  }


}