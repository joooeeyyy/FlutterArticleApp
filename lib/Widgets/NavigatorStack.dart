import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../GetXControllers/UploadImageController.dart';
import '../GetXControllers/PostController.dart';
import '../Models/ApiResponse/AllPostSuccess.dart';
import '../Models/MediaUpload.dart';

class NavigatorStack extends StatefulWidget{

  const NavigatorStack({
      Key? key,
      this.indexValue,
  }) : super(key: key);

  final int? indexValue;

  @override
  State<NavigatorStack> createState() => _NavigatorStackState();

}

class _NavigatorStackState extends State<NavigatorStack> {

  PostController postController = Get.put(PostController());
  UploadImageController uploadImageController = Get.put(UploadImageController());
  List<MediaUpload> mediaUploadList = <MediaUpload>[];
  bool isVisible = false;
  TextEditingController? editingControllerTitle,editingControllerDescription,editingControllerCategory;


  @override
  void initState() {
    editingControllerTitle = TextEditingController();
    editingControllerDescription = TextEditingController();
    editingControllerCategory = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
       children:[

         Visibility(
            visible:widget.indexValue == 0 ? true :false,
             child:Container(
               height:Get.height,
               width:Get.width,
               padding:const EdgeInsets.only(left:10,right:10,),
                color:Colors.white,
                child:Center(
                  child:Obx(
                      ()=> ListView.builder(
                          itemCount:postController.allPostGet.post!.length,
                          itemBuilder:(BuildContext context, int index) {
                            Post post  = postController.allPostGet.post![index];
                            print("Post Title ${post.title}");
                            String pictureUrl = "";
                            if(post.img!.length != 0){
                              print("File Name Show ${post.img![0].filename}");
                              String fileName = post.img![0].filename!;
                              pictureUrl = "https://articlecourse-api.herokuapp.com/api/auth/api/files/$fileName";
                            }else{
                              print("This post image is Null");
                            }
                            return PostItem(
                                imageUrl:pictureUrl,
                                title:post.title,
                                description:post.description,
                            );
                         },
                      )

                    //     (
                    //   children:const [
                    //        PostItem(imageUrl:"https://articlecourse-api.herokuapp.com/api/auth/api/files/80cd43d5503c754a3125b631bf89e475.jpg"),
                    //        PostItem(imageUrl: "https://articlecourse-api.herokuapp.com/api/auth/api/files/bce21e2a063fd32723c454307da5c15d.jpg",),
                    //        PostItem(imageUrl:"https://articlecourse-api.herokuapp.com/api/auth/api/files/80cd43d5503c754a3125b631bf89e475.jpg"),
                    //   ]
                    // ),
                  )
                ),
            )
         ),

         Visibility(
             visible:widget.indexValue == 1 ? true :false,
             child:Container(
               color:Colors.blue,
               child:const Center(
                   child:Text(
                     "Display Single Articles",
                     style:TextStyle(
                         fontSize:22,
                         color:Colors.white,
                         fontWeight:FontWeight.bold,
                     ),
                   )
               ),
             )
         ),

         Visibility(
             visible:widget.indexValue == 2 ? true :false,
             child:Container(
               padding:const EdgeInsets.symmetric(horizontal:20),
               child:SingleChildScrollView(
                 child:Column(
                   children:[

                     const SizedBox(height:20),

                    const Align(
                       alignment:Alignment.centerLeft,
                       child: Text(
                         "Article Title",
                         style:TextStyle(
                           color:Colors.black
                         )
                       ),
                     ),

                     const SizedBox(height:8),

                     //Title Container
                     Container(
                       width:Get.width,
                       height:45,
                       padding:const EdgeInsets.only(left:8),
                       decoration:BoxDecoration(
                           border:Border.all(color:Colors.grey ,width:1),
                           borderRadius:BorderRadius.circular(10)
                       ),
                       child:TextField(
                          controller:editingControllerTitle,
                          style:const TextStyle(
                            color:Colors.black,
                            fontSize:17
                          ),
                          decoration:const InputDecoration(
                            border:InputBorder.none,
                            hintText:"Title Of Article"
                          )
                       )
                     ),
                     //Title Container

                     const SizedBox(height:16),

                     //Category Container
                     const Align(
                       alignment:Alignment.centerLeft,
                       child: Text(
                           "Category of article",
                           style:TextStyle(
                               color:Colors.black
                           )
                       ),
                     ),

                     const SizedBox(height:8),

                     Container(
                         width:Get.width,
                         height:45,
                         padding:const EdgeInsets.only(left:8),
                         decoration:BoxDecoration(
                             border:Border.all(color:Colors.grey ,width:1),
                             borderRadius:BorderRadius.circular(10)
                         ),
                         child:TextField(
                            controller:editingControllerCategory,
                             style:const TextStyle(
                                 color:Colors.black,
                                 fontSize:17
                             ),
                             decoration:const InputDecoration(
                                 border:InputBorder.none,
                                 hintText:"Category Of Article"
                             )
                         )
                     ),
                     //Category Container

                     const SizedBox(height:16),

                     //Description Container
                     Container(
                       width:Get.width,
                       height:196,
                       padding:const EdgeInsets.only(top:5,left:6,bottom:6),
                       decoration:BoxDecoration(
                         borderRadius:BorderRadius.circular(7),
                         border:Border.all(color:Colors.grey , width:1),
                       ),
                       child:Row(
                         children:[
                            Expanded(
                              child:Container(
                                   height:196,
                                   child:TextField(
                                      controller:editingControllerDescription!,
                                       keyboardType:TextInputType.multiline,
                                      textAlign:TextAlign.start,
                                      maxLines:null,
                                      decoration:const InputDecoration(
                                        isDense:true,
                                        hintText:"Description Of your Article",
                                        border:InputBorder.none,
                                      )
                                   )
                              )
                            )
                         ]
                       )
                     ),
                     //Description Container

                     const SizedBox(height:20),

                     //Widget Open Gallery
                     Row(
                       children: [
                         Align(
                           alignment:Alignment.centerLeft,
                           child: Material(
                             color:Colors.transparent,
                             child:InkWell(
                               onTap:() async {
                                 await uploadImageController.startUploading();
                                 List<MediaUpload> mediaUploadList =  uploadImageController.listOfSelectedGet;
                                 takeInMediaList(uploadList:mediaUploadList);
                               },
                               child: Container(
                                 width:160,
                                 height:50,
                                 decoration:BoxDecoration(
                                   border:Border.all(width:1.0 , color:Colors.blue),
                                   borderRadius:BorderRadius.circular(8)
                                 ),
                                 child:const Center(
                                   child:Text(
                                     "Choose File",
                                     style:TextStyle(
                                          color:Colors.blue,
                                          fontWeight:FontWeight.bold,
                                     )
                                   )
                                 )
                               ),
                             ),
                           ),
                         ),
                         Visibility(
                           visible:isVisible,
                           child:Container(
                             width:70,
                             height:70,
                             child:Stack(
                                 children:const [
                                   SizedBox(
                                      width:60,
                                       height:60,
                                       child:Icon(Icons.picture_in_picture_rounded,size:50,color:Colors.green)
                                   ),

                                 ]
                             )
                           ),
                         )
                       ],
                     ),
                     //Widget Open Gallery

                     Align(
                       alignment:Alignment.centerLeft,
                       child:ElevatedButton(
                           onPressed:(){
                             postController.createPost(
                                 title:editingControllerTitle!.text,
                                 description:editingControllerDescription!.text,
                                 categoryOfPost:editingControllerCategory!.text,
                                 imageInts:mediaUploadList[0].pictureBytes,
                                 fileName:mediaUploadList[0].fileName,
                                 mediaType:mediaUploadList[0].mediaType
                             );
                               //Upload To The Database
                              //Title
                             //Description
                             //MediaUpload
                             //Category
                            },
                           child:const Text(
                             "Upload Article",
                              style:TextStyle(
                                color:Colors.white,
                                fontWeight:FontWeight.bold,
                                fontSize:18
                             )
                           )
                       ),
                     )

                   ]
                 ),
               )
           )
         ),

       ]
    );
  }

  takeInMediaList({List<MediaUpload>? uploadList}){
    //Display on Ui From GetxController
    mediaUploadList = uploadList!;
    if(mediaUploadList.isNotEmpty){
      print("The media upload List is not Empty");
      setState((){
        isVisible = true;
      });
    }else{
      print("The Media Upload List is Empty");
      setState((){
        isVisible=false;
      });
    }
  }

}

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    this.imageUrl,
    this.title,
    this.description,
  }) : super(key: key);

  final String? imageUrl;
  final String?  title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:7,
      shadowColor:Colors.grey,
      shape:RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(20)
      ),
      child:Container(
        margin:const EdgeInsets.only(top:10),
        padding:const EdgeInsets.all(8),
        width:Get.width,
        height:Get.height * 0.5,
        child:Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.start,
          children:[
             Text(
               "$title",
               style:const TextStyle(
                 color:Colors.black,
                 fontWeight:FontWeight.bold,
                 fontSize:19,
               )
             ),
            Text(
              "$description"
            ),
            Expanded(
              child: SizedBox(
                width:Get.width,
                  child:Image.network(imageUrl!)
              ),
            )

          ]
        )

      ),
    );
  }
}

//https://articlecourse-api.herokuapp.com/api/auth/api/files/bce21e2a063fd32723c454307da5c15d.jpg
//https://articlecourse-api.herokuapp.com/api/auth/api/files/80cd43d5503c754a3125b631bf89e475.jpg