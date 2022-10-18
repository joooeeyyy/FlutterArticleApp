import "package:get/get.dart";

class NavigatorController extends GetxController{
  var indexValue = 0.obs;

  int get indexValueGet => indexValue.value;

  putIndex({int? inputValue}){
     indexValue.value = inputValue!;
  }

}
