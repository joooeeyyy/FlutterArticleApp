import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_article/Models/MediaUpload.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as p;

class UploadImageController extends GetxController{

  var listOfSelectedImage = <MediaUpload>[].obs;

  List<MediaUpload> get listOfSelectedGet => listOfSelectedImage.value;

  Future startUploading() async {
     print("Image Upload Started");
     List<String> imgUrls = [];
     List<MediaUpload> mediaUploadList = <MediaUpload>[];
     FilePickerResult? result = await selectFilesToUpload();
     if(result!=null){
      List<String?> allPathsResult = result.paths;
      List<File> resultFiles = allPathsResult.map((e) => File(e!)).toList();
      List<File>? fileCompress = await compressTakeListOfFile(files:resultFiles);
      File each_file;
      for(each_file in fileCompress!){
        List<int> pictureBytes =  each_file.readAsBytesSync();
        String fileName = each_file.path.split("/")[6];
        var extension = p.extension(each_file.path);
        List<String> result = extension.split(".");
        String mediaType = result[1];
        print("FileName : $fileName");
        print("MediaType :$mediaType");
        print("PictureInt : $pictureBytes");
        MediaUpload mediaUpload = MediaUpload(pictureBytes, fileName, mediaType,each_file);
        mediaUploadList.add(mediaUpload);
      }
      print("Size of Image ${mediaUploadList.length}");
      listOfSelectedImage.value =  mediaUploadList;
     }
  }

  Future<List<File>?> compressTakeListOfFile({List<File>? files})async{
        var dir  =  await path_provider.getTemporaryDirectory();
        File file_each;
        List<File> fileCompressed = <File>[];
        for(file_each in files!){
            String name = file_each.path.split("/")[7];
            String targetDirectory = "${dir.absolute.path}/$name.jpg";
            File? file  =  await executeCompression(file:file_each , directoryPath:targetDirectory);
            fileCompressed.add(file!);
        }
        return fileCompressed;
  }

  Future<File?> executeCompression({File? file , String? directoryPath})async{
       var result = FlutterImageCompress.compressAndGetFile(
               file!.absolute.path,
               directoryPath!,
               quality:55,
               rotate:0
           );
       return result;
  }

  Future<FilePickerResult?> selectFilesToUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
           allowMultiple:true,
           allowedExtensions:['jpg','png','PNG','JPEG','JPG',],
           type:FileType.custom
       );
    return result;
  }

}