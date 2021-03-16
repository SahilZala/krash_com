import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

class CreateClientData
{
  String userid,name,mail,address,lat,log,mobileno,time,date,profile,activation;

  CreateClientData(
      this.userid,
      this.name,
      this.mail,
      this.address,
      this.lat,
      this.log,
      this.mobileno,
      this.time,
      this.date,
      this.profile,
      this.activation);

  Future<Map> create()
  async {
    try {

      String graphQLDocument =
      '''mutation CreateClientData(\$userid: String, \$name: String, \$mail: String, \$address: String, \$lat: String, \$log: String, \$mobileno: String, \$time: String, \$date: String, \$profile: String, \$activation: String) {
              createClientData(input: {userid: \$userid, name: \$name, mail: \$mail, address: \$address, lat: \$lat, log: \$log, mobileno: \$mobileno, time: \$time, date: \$date, profile: \$profile, activation: \$activation}) {
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
        }''';

      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(document: graphQLDocument, variables: {
            'userid': userid,
            'name': name,
            'mail': mail,
            'address': address,
            'lat': lat,
            'log': log,
            'mobileno': mobileno,
            'time': time,
            'date': date,
            'profile': profile,
            'activation': activation,
          }));

      var response = await operation.response;
      var data = response.data;

      Map val = json.decode(response.data);

      print(val);

      if(response.data == null)
      {
        return null;
      }
      else{
        return val['createClientData'];
      }
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }catch(e)
    {
      print(e);
    }
  }

}

