import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_article/Constant.dart';
import 'package:http_parser/http_parser.dart';

class AuthenticationController extends GetxController{

  void signUp({
    required String password ,
    required String email ,
    String? name , required List<int> pictureInts , required String mediaType , String? fileName})async{

    var request = http.MultipartRequest("POST",Uri.parse("${CONSTANTS.baseUrl}/api/auth/signup"),);
    request.files.add(
            http.MultipartFile.fromBytes("image",
                pictureInts,filename:fileName,contentType:MediaType("image",mediaType))
    );
    request.fields['password'] = password;
    request.fields['name'] = name!;
    request.fields['email']=email;
    var res = await request.send();
    var responseBytes = await res.stream.toBytes();
    var jsonString = String.fromCharCodes(responseBytes);
    var decodeResult = jsonDecode(jsonString);
    int status  = res.statusCode;
    if(status == 200){
      //Sign Up is successful
    }else{
      //Sign Up is Unsuccessful
    }
    
  }

  void logIn({String? email ,  String? password})async{
        http.Client client = http.Client();
        http.Response response = await client.post(Uri.parse("${CONSTANTS.baseUrl}/api/auth/login"),body:
         {
             "email":email,
              "password":password
        });
        var decodeResult = jsonDecode(response.body);
       if(response.statusCode == 200){
          //Save the user in the database
       }else{
         //Error Occurred
       }
  }

}