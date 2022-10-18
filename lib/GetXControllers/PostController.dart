import 'dart:convert';
import 'package:get/get.dart';
import  'package:http/http.dart' as http;
import 'package:my_article/Constant.dart';
import 'package:http_parser/http_parser.dart';

import '../Models/ApiResponse/AllPostSuccess.dart';

class PostController extends GetxController{

  var allPostResponse = AllPost().obs;
  AllPost get allPostGet => allPostResponse.value;

  @override
  void onInit(){
    print("onInit Called and Triggered");
    getAllPost();
  }


  void createPost({String? title , String? description , String? categoryOfPost ,
    List<int>? imageInts , String? fileName ,
    String? mediaType
  })async{

    Map<String , String > headers = {
      "Authorization": "Bearer ${CONSTANTS.accessToken}",
      "Accept-Encoding":"gzip, deflate, br",
      "Accept":"*/*",
      "Content-Type":"multipart/form-data; boundary=<calculated when request is sent>"
    };

    var request  = http.MultipartRequest("Post",Uri.parse("${CONSTANTS.baseUrl}/api/post/uploadPost"));
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile.fromBytes("images",imageInts!,filename:fileName!,contentType:new MediaType('image',mediaType!))
    );
    request.fields['title'] = title!;
    request.fields['description'] = description!;
    request.fields['categories'] = categoryOfPost!;
    var res = await request.send();
    var responseBytes = await res.stream.toBytes();
    var jsonString = String.fromCharCodes(responseBytes);
//    var decodeResult = jsonDecode(res);
    int status  = res.statusCode;
    if(status == 200){
      print("Successfully Uploaded a Post");
      //Sign Up is successful
    }else{
      print("Error Uploading a post $status");
      //Sign Up is Unsuccessful
    }
    
  }

  void getAllPost() async {
    http.Client client = http.Client();
    http.Response response = await client.get(
        Uri.parse("${CONSTANTS.baseUrl}/api/post/"),
        headers:{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization":"Bearer ${CONSTANTS.accessToken}"
        }
    );
    var decodeResponse = jsonDecode(response.body);
    int status = response.statusCode;
    if(status == 200){
      //Show all post on the Ui for the user
      AllPost allPost = allPostFromJson(response.body);
      allPostResponse.value = allPost;
    }else{
      //Throw the error for the user 
    }
  }

  void getSinglePost({String? postId}) async {
      http.Client client = http.Client();
      http.Response response = await client.get(Uri.parse("${CONSTANTS.baseUrl}/api/post/find/$postId"));
      var decodedResponse = jsonDecode(response.body);
      int status = response.statusCode;
      if(status == 200){
        //Display the post on the Ui
      }else{
        //Throw the error for the user
      }
  }

}