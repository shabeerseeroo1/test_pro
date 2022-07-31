
import 'package:bloc_rx_dart/business_logic/data/model/login_response.dart';
import 'package:bloc_rx_dart/utils/app_constants.dart';
import 'package:bloc_rx_dart/web_service/api_client.dart';
import 'package:bloc_rx_dart/web_service/error_handler/error_handler.dart';
import 'package:dio/dio.dart';

import '../../../web_service/generic/base_model.dart';

class LoginProvider{

  Future<BaseModel<LoginResponse>> login({required mob, required pass})async{
    LoginResponse loginResponse;
    try{
      loginResponse = await ApiClient(Dio(),AppConstants().baseUrl).login(mob, pass, "", "");
    }catch(e){
      return BaseModel()..setException(ErrorHandler.withErrorAndCode(error: e as DioError));
      // return BaseModel().setException(ErrorHandler.withErrorAndCode(error: e as DioError));
    }
    return BaseModel()..genericData = loginResponse;
  }
}