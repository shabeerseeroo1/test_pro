import 'package:dio/dio.dart' hide Headers;

class ErrorHandler implements Exception {
  int? _errorCode = 0;
  // List<String?> _errorMessage = [];
  String _errorMessage = "";

  ErrorHandler(this._errorCode, this._errorMessage);

  ErrorHandler.withErrorAndCode({required DioError error}) {
    _handleErrorAndCode(error);
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    // return _errorMessage.join("");
    return _errorMessage;
  }

  _handleErrorAndCode(DioError error) {
    ErrorHandler serverError;
    switch (error.type) {
      case DioErrorType.cancel:
        _errorCode = error.response!.statusCode;
        _errorMessage = "Request was cancelled";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.connectTimeout:
        try {
          _errorCode = error.response!.statusCode;
        } catch (e) {
          _errorCode = 101;
        }
        // _errorMessage.add("Connection timeout");
        _errorMessage = "Time out exception";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.receiveTimeout:
        _errorCode = error.response!.statusCode;
        // _errorMessage.add("Receive timeout in connection");
        _errorMessage = "connection time out";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.response:
        print('Reached here........');
        _errorCode = error.response!.statusCode;
        if (error.response != null && error.response!.statusMessage!.isNotEmpty) {
          try {
            _errorMessage = error.response!.data['message'].toString();
          } catch (e) {
            _errorMessage = "Something went wrong";
          }
        } else {
          _errorMessage =
          "${"500"}: ${error.response!.statusCode}";
        }
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.sendTimeout:
        _errorCode = error.response!.statusCode;
        _errorMessage = "500";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      case DioErrorType.other:
        _errorCode = 100;
        _errorMessage ="no connection";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
      default:
        _errorCode = error.response!.statusCode;
        _errorMessage = error.response!.statusMessage ?? "";
        serverError = ErrorHandler(_errorCode, _errorMessage);
        break;
    }
    return serverError;
  }
}
