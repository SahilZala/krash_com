import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

class OrderConnection
{
  void placeOrder(String orderid,userid,mobileno,address,lat,log,servicename,cartype,price,ontime,ondate,status,takenbyid,time,date)
  async{
    String graphQLDocument =
    '''mutation MyMutation {
        createOrders(input: {activation: "true", address: "$address", date: "$date", lat: "$lat", log: "$log", mobileno: "$mobileno", ondate: "$ondate", ontime: "$ontime", orderid: "$orderid", price: "$price", servicename: "$servicename",cartype: "$cartype", status: "$status", takenbyid: "$takenbyid", time: "time", userid: "$userid"}) {
          activation
          address
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
          cartype
          status
          takenbyid
          time
          updatedAt
          userid
        }
      }
    ''';

    var operation = Amplify.API.mutate(
        request: GraphQLRequest<String>(document: graphQLDocument));

    var response = await operation.response;
    var data = response.data;

    Map val = json.decode(response.data);

    print(val);

    if(response.data == null)
    {
      return null;
    }
    else{
      return val['createOrders'];
    }

  }
}