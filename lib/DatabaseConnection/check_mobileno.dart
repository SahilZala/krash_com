import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';

class CheckMobileno
{

  Future<Map> checkMobile(String mobileno)
  async {
    try {
      Map userData = null;
      String graphQLDocument = '''query ListUserDatas {
      listClientDatas {
        items {
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
        nextToken
      }
    }''';

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
            document: graphQLDocument,
          ));

      var response = await operation.response;
      var data = response.data;

      if(response.data != null)
      {
        Map val = json.decode(response.data);
        List data_list = val['listClientDatas']['items'];

        for(int i=0;i<data_list.length;i++){
          if(data_list[i]['mobileno'] == mobileno){
            userData = data_list[i];
            break;
          }
        }

        print(userData);
        if(userData == null) {
          return userData;
        }
        else{
          return userData;
        }
      }

      print('Query result: ' + data);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

}