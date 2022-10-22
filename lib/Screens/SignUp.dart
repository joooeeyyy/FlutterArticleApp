
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../GetXControllers/AuthenticationController.dart';
import '../Models/UserModel.dart';
import '../Utils/SharedPreferenceHandler.dart';
import 'GetAllPost.dart';

class SignUpScreen extends StatefulWidget{

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController? editingControllerEmail, editingControllerPassword;
  AuthenticationController authenticationController = Get.put(AuthenticationController());

  @override
  void initState() {
    editingControllerEmail = TextEditingController();
    editingControllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
        padding:EdgeInsets.symmetric(horizontal:20),
        width:size.width,
        height:size.height,
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text(
              "Login Screen",
              style:TextStyle(
                color:Colors.black,
                fontSize:20
              )
            ),

            SizedBox(height:20),

            Container(
                width:size.width,
                height:45,
                padding:const EdgeInsets.only(left:8),
                decoration:BoxDecoration(
                    border:Border.all(color:Colors.grey ,width:1),
                    borderRadius:BorderRadius.circular(10)
                ),
                child:TextField(
                    controller:editingControllerEmail,
                    style:const TextStyle(
                        color:Colors.black,
                        fontSize:17
                    ),
                    decoration:const InputDecoration(
                        border:InputBorder.none,
                        hintText:"Write your Email"
                    )
                )
            ),

            const SizedBox(height:20),

            Container(
                width:size.width,
                height:45,
                padding:const EdgeInsets.only(left:8),
                decoration:BoxDecoration(
                    border:Border.all(color:Colors.grey ,width:1),
                    borderRadius:BorderRadius.circular(10)
                ),
                child:TextField(
                    controller:editingControllerPassword,
                    style:const TextStyle(
                        color:Colors.black,
                        fontSize:17
                    ),
                    decoration:const InputDecoration(
                        border:InputBorder.none,
                        hintText:"Write Your Password"
                    )
                )
            ),

            const SizedBox(height:20),

            Align(
              alignment:Alignment.center,
              child:ElevatedButton(
                  onPressed:(){
                    String email = editingControllerEmail!.text;
                    String password = editingControllerPassword!.text;
                    authenticationController.logIn(
                      email:email,
                      password:password,
                    ).then((value) {
                      if(value is UserNew){
                        print("Value Success Entered ${value.token!}");
                        String token = value.token!;
                        SharedPreferenceHandler.saveToken(tokenString:token);
                        //Save User Token
                        Get.to(()=>GetAllPost());
                      }else {
                        print("Suucesssss Navigate Home null");
                      }

                    });
                  },
                  child:const Text(
                      "Log In",
                      style:TextStyle(
                          color:Colors.white,
                          fontWeight:FontWeight.bold,
                          fontSize:18
                      )
                  )
              ),
            )

          ]
        )
      )
    );
  }

}


