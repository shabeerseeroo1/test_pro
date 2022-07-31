
import 'package:bloc_rx_dart/web_service/error_handler/error_handler.dart';

class BaseModel<T>{
  ErrorHandler? _error;
  T?genericData;

  setException(ErrorHandler error){
    _error = error;
  }
  get getException{
    return _error;
  }
}