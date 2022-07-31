import 'package:bloc_rx_dart/business_logic/blocs/login_bloc.dart';
import 'package:bloc_rx_dart/business_logic/data/model/login_response.dart';
import 'package:bloc_rx_dart/extension/widgets/extension_widget.dart';
import 'package:bloc_rx_dart/utils/custom_snackbar.dart';
import 'package:bloc_rx_dart/web_service/generic/base_model.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  final LoginBloc loginBloc = LoginBloc();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen"),
        ),
        body: CustomWidget(bodyView()).padding(horizontal: 25, vertical: 20));
  }

  bodyView() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<String>(
            stream: loginBloc.mobStream,
            builder: (context, snapShot) => buildTextField(
                hintText: "Enter Your Mobile Number",
                label: "Mobile Number",
                onChanged: (val) => loginBloc.mobChanged.add(val),
                errorText: snapShot.error?.toString()),
          ),
          buildSizedBox(),
          StreamBuilder<String>(
              stream: loginBloc.passwordStream,
              builder: (context, snapshot) {
                return buildTextField(
                    isObscure: true,
                    hintText: "Enter Your Password",
                    label: "Password",
                    onChanged: (val) => loginBloc.passwordChanged.add(val),
                    errorText: snapshot.error?.toString());
              }),
          buildSizedBox(),
          StreamBuilder<bool>(
              stream: loginBloc.submitCheck(),
              builder: (context, snapshot) {
                return MaterialButton(
                  color: Colors.green,
                  onPressed: snapshot.hasData
                      ? () {
                          loginBloc.submit(context);
                        }
                      : null,
                  child: StreamBuilder<BaseModel<LoginResponse>>(
                      stream: loginBloc.loginResponseStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (!snapshot.hasError) {
                            if (snapshot.data?.getException != null) {
                              showErrorCustomToast(
                                  message: snapshot.data?.getException
                                          .getErrorMessage() ??
                                      "");
                            } else if (snapshot.data?.genericData?.status ??
                                false) {
                              Navigator.pushNamed(context, AppRoutes.dashboard);
                            } else {
                              showErrorCustomToast(
                                  message:
                                      snapshot.data?.genericData?.result?.msg ??
                                          "");
                            }
                            return const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2.0,
                                ));
                          } else {
                            showErrorCustomToast(
                                message:
                                    snapshot.data?.genericData?.result?.msg ??
                                        "");
                            return const Text("Submit");
                          }
                        }

                        return const Text("Submit");
                      }),
                );
              })
        ],
      ),
    );
  }

  SizedBox buildSizedBox() {
    return const SizedBox(
      height: 8,
    );
  }

  TextField buildTextField(
      {required hintText,
      required label,
      String? errorText,
      bool isObscure = false,
      required Function onChanged}) {
    return TextField(
      obscureText: isObscure,
      onChanged: (value) {
        onChanged(value);
      },
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        errorText: errorText,
      ),
    );
  }
}
