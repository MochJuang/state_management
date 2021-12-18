import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_manage/domain/auth/model/login_request.dart';
import 'package:state_manage/domain/auth/model/login_response.dart';

class AuthRepository {
  Dio _dio = Dio();
  String baseUrl = 'https://reqres.in/api/';

  Future<Either<String, LoginResponse>> signIn({@required LoginRequest? loginRequest}) async{
    Response _response;
    try {
      _response = await _dio.post('https://reqres.in/api/login', data: loginRequest?.toJson()); 
      LoginResponse _loginResponse = LoginResponse.fromJson(_response.data);
      return right(_loginResponse);
      
    } on DioError catch (e) {
      String errorMessage = e.response.data.toString();
      switch (e.type) { 
        
        case DioErrorType.CONNECT_TIMEOUT:
          // TODO: Handle this case.
          break;
        case DioErrorType.SEND_TIMEOUT:
          // TODO: Handle this case.
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          // TODO: Handle this case.
          break;
        case DioErrorType.RESPONSE:
          errorMessage = e.response.data['error'];
          break;
        case DioErrorType.CANCEL:
          // TODO: Handle this case.
          break;
        case DioErrorType.DEFAULT:
          // TODO: Handle this case.
          break;
      }

      return left(errorMessage);
    }
  }
}