import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../GetXControllers/NavigatorController.dart';
import '../Widgets/NavigatorStack.dart';

class GetAllPost extends StatefulWidget {

  const GetAllPost({Key? key}) : super(key: key);

  @override
  State<GetAllPost> createState() => _GetAllPostState();
}

class _GetAllPostState extends State<GetAllPost> {

  NavigatorController navigatorController = Get.put(NavigatorController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor:Colors.white,
        body:SafeArea(
          child:Column(
            children: [
              //Custom Toolbar
              Container(
                width:Get.width,
                height:44,
                decoration:const BoxDecoration(
                  border:Border(
                     bottom:BorderSide(
                       width:1.3,
                       color:Colors.grey
                     )
                  )
                ),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children:const [
                     Text(
                       "Share Article",
                       style:TextStyle(
                         color:Colors.black,
                         fontWeight:FontWeight.bold,
                         fontSize:25
                       )
                     )
                  ]
                )
              ),
              //Custom ToolBar

                 Obx(
                      ()=>Expanded(
                            child:NavigatorStack(
                              indexValue:navigatorController.indexValueGet,
                            )
                      )
                 ),

            ],
          ),
        ),
        bottomNavigationBar:Container(
          height:50,
          width:Get.width,
          decoration:const BoxDecoration(
            color:Colors.blue,
            borderRadius:BorderRadius.only(topRight:Radius.circular(25),topLeft:Radius.circular(25))
          ),
          child:Row(
            children:[
              Expanded(
                child:Material(
                  color:Colors.transparent,
                  child:InkWell(
                    onTap:(){
                      onTap(indexValue:0);
                    },
                    child:const Center(
                      child:Icon(Icons.home , size:20 ,color:Colors.white,),
                    ),
                  ),
                )
              ),
              Expanded(
                  child:Material(
                    color:Colors.transparent,
                    child: InkWell(
                      onTap:(){
                        onTap(indexValue:1);
                      },
                      child:const Center(
                        child:Icon(Icons.ad_units_sharp , size:20 ,color:Colors.white,),
                      ),
                    ),
                  )
              ),
              Expanded(
                  child:Material(
                    color:Colors.transparent,
                    child:InkWell(
                      onTap:(){
                        onTap(indexValue:2);
                      },
                      child:const Center(
                        child:Icon(Icons.add , size:20 ,color:Colors.white,),
                      ),
                    ),
                  )
              ),
            ]
          )
        ),
    );
  }

  onTap({int? indexValue}){
    navigatorController.putIndex(inputValue:indexValue);
  }

}
