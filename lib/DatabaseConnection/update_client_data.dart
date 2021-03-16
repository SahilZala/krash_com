import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

class UpdateClientData
{
  String mobileno,userid,address,lat,log,date,time,id;


  UpdateClientData(this.mobileno, this.userid, this.address, this.lat, this.log,
      this.date, this.time, this.id);

  Future<Map> updateData()
  async {
    String graphQLDocument = '''
      mutation MyMutation {
        updateClientData(input: {address: "$address", date: "$date", lat: "$lat", log: "$log", time: "$time",id: "$id"},
         condition: {mobileno: {eq: "$mobileno"}}){
          id
          userid
          name
          mail
          address
          lat
          log
          mobileno
          time
          date
          profile
          activation        
        }
      }
    ''';



    var operation = Amplify.API.mutate(
        request: GraphQLRequest<String>(document: graphQLDocument));

    var response = await operation.response;

    print(response.data);

    return json.decode(response.data)["updateClientData"];
  }
}