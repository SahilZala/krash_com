import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

class GetOrderData
{
  Future<void> getOrderData(String id)
  async {
    var graphQLDocument = '''
      query MyQuery {
      listOrderss(filter: {userid: {eq: "$id"}}) {
        items {
          activation
          address
          cartype
          createdAt
          date
          id
          lat
          log
          mobileno
          ondate
          ontime
          orderid
          price
          servicename
          status
          takenbyid
          time
          updatedAt
          userid
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

    return val["listOrderss"]["items"];
  }
}