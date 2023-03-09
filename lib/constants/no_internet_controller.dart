
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';




class StudentLocationController extends GetxController{

  var connectionStatus=0.obs;
  final Connectivity _connectivity=Connectivity();
 
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void onInit() {
    // TODO: implement onInit
   
    initConnectivity();
    _connectivitySubscription=_connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }
 Future<void> initConnectivity() async{
   late ConnectivityResult result;
    try {
      result=await _connectivity.checkConnectivity();
    }on PlatformException catch (e) {
      print(e.toString());
      
    }
   return _updateConnectionStatus(result); 
  }
  
  _updateConnectionStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.wifi:
      connectionStatus.value=1;
      break;
      case ConnectivityResult.mobile:
      connectionStatus.value=2;
      break;
      case ConnectivityResult.none:
      connectionStatus.value=0;
      break;
      default:
      Get.snackbar("Network Error", "Failed to get network connection");
      break;
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    
  }

}
