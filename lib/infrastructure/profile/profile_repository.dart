import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_manage/domain/core/user/model/user_response.dart';

class ProfileRepository {
  Dio _dio = Dio();
  String baseUrl = 'https://reqres.in/api/';

  Future<Either<String, UserResponse>> getAllUser() async{
    Response _response;
    try {
      _response = await _dio.get('https://reqres.in/api/users?page=2'); 
      UserResponse _userResponse = UserResponse.fromJson(_response.data);
      return right(_userResponse);
      
    } on DioError catch (e) {
      String? errorMessage;
      if(e.type == DioErrorType.response){
        if(e.response != null){
          errorMessage = e.response.toString();
        }
      }
      return errorMessage != null ? left(errorMessage) : left("other Error");
    }
  }
}