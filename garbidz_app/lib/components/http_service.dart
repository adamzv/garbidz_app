import 'dart:convert';

import 'package:garbidz_app/components/address_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class HttpService{
  final String postsUrl = "http://10.0.2.2:8080/api/addresses?size=2000";
  Future <List<Address>> getPosts()async{
    final res = await http.get(
        Uri.parse(postsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdXIudmFua29AZ21haWwuY29tIiwiZXhwIjoxNjE5MTI0Mzc0fQ.fENISxEMs6m9eNF3Bvkv9_2JG-3Aa9kRl1borZwM2MA',
        });

    if(res.statusCode == 200){
      try{
        final decoded = jsonDecode(res.body);
        print(decoded['content']);
        List<dynamic> body = decoded['content'];

        List<Address> addresses = body.map((dynamic item) => Address.fromJson(item)).toList();
        print(addresses.length.toString());
        return addresses;
      }catch(e){
        print(e);
      }
    }
    else{
      throw "Can't get posts.";
    }
  }
}