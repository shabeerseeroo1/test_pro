import 'package:bloc_rx_dart/business_logic/data/model/login_response.dart';
import 'package:bloc_rx_dart/business_logic/data/repository/login_repository.dart';
import 'package:bloc_rx_dart/presentation/routes/app_routes.dart';
import 'package:bloc_rx_dart/utils/validator.dart';
import 'package:bloc_rx_dart/web_service/error_handler/error_handler.dart';
import 'package:bloc_rx_dart/web_service/generic/base_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/custom_snackbar.dart';

class LoginBloc extends Object with Validators implements BaseBloc {
  final _mobileController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _loginResponseController = BehaviorSubject<BaseModel<LoginResponse>>();
  final loginRepository = LoginRepository();

  @override
  void dispose() {
    _mobileController.close();
    _passwordController.close();
    _loginResponseController.close();
  }

  Stream<String> get mobStream =>
      _mobileController.stream.transform(mobValidator);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);

  Stream<BaseModel<LoginResponse>> get loginResponseStream =>
      _loginResponseController.stream;

  Sink<String> get mobChanged => _mobileController.sink;

  Sink<String> get passwordChanged => _passwordController.sink;

  Stream<bool> submitCheck() {
    return Rx.combineLatest2(mobStream, passwordStream, (a, b) => true);
  }

  submit(BuildContext context) async {

    var response = await loginRepository.login(
        mob: _mobileController.value, pass: _passwordController.value);
    _loginResponseController.sink.add(response);
  }
}

abstract class BaseBloc {
  void dispose();
}
