import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../business_logic/data/model/location_response.dart';
import '../business_logic/data/model/login_response.dart';


part 'api_client.g.dart';


@RestApi(baseUrl: "")
abstract class ApiClient {
  factory ApiClient(Dio dio, String baseUrl) {
    dio.options = BaseOptions(
      receiveTimeout: 5000,
      connectTimeout: 5000,
    );

    dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 200));

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('locations')
  Future<LocationResponse> getLocations();


  @POST("sign_in")
  Future<LoginResponse> login(@Field("email_or_phone") String mobileNumber,
      @Field("password") String password,
      @Field("device_token") String deviceToken,
      @Field("device_type") String deviceType,);
}