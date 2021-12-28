part of 'profileb_bloc.dart';

@freezed
class ProfilebState with _$ProfilebState {
  const factory ProfilebState.initial() = _Initial;
  const factory ProfilebState.isLoading() = _isLoading;
  const factory ProfilebState.isError(String errorMessage) = _isError;
  const factory ProfilebState.isSucess(UserResponse userResponse) = _isSucess;
}
