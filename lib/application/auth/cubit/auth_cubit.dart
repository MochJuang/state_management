import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:state_manage/domain/auth/model/login_request.dart';
import 'package:state_manage/domain/auth/model/login_response.dart';
import 'package:state_manage/infrastructure/auth/auth_repository.dart';
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
        (r) => emit(AuthSuccess(r))
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
