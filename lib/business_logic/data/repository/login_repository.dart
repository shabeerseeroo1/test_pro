
import 'package:bloc_rx_dart/business_logic/data/model/login_response.dart';
import 'package:bloc_rx_dart/business_logic/data/providers/login_provider.dart';
import 'package:bloc_rx_dart/web_service/generic/base_model.dart';

class LoginRepository{
  final loginProvider =LoginProvider();
  Future<BaseModel<LoginResponse>> login({required mob, required pass}){
    return loginProvider.login(mob: mob, pass: pass);
  }
}