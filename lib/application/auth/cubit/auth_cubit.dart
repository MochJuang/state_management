import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:state_manage/domain/auth/model/login_request.dart';
import 'package:state_manage/domain/auth/model/login_response.dart';
import 'package:state_manage/infrastructure/auth/auth_repository.dart';
import '../../../utils/constants.dart' as constants;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _authRepository = AuthRepository();

  Future signInUser(LoginRequest loginRequest) async{
    emit(AuthLoading());
    
    try {
      final _data = await this._authRepository.signIn(loginRequest: loginRequest);
      _data.fold(
        (l) => emit(AuthError(l)),
        (r) => emit(AuthLoginSuccess(r))
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void saveStorage(LoginResponse loginRequest) async {
    emit(AuthLoading());

    try{
      final _data = await GetStorage().write(constants.USER_LOCAL_KEY, jsonEncode(loginRequest.toJson()));
      emit(AuthSuccess());
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }

  void loadData() async{
    try{
      final _data = await GetStorage().read(constants.USER_LOCAL_KEY);
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(_data));
      emit(AuthLoginSuccess(loginResponse));
    }catch(e){
      emit(AuthError(e.toString()));
    
    }
  }
}
