// ignore_for_file: void_checks

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_manage/domain/core/user/model/user_response.dart';
import 'package:state_manage/infrastructure/profile/profile_repository.dart';
part 'profileb_event.dart';
part 'profileb_state.dart';
part 'profileb_bloc.freezed.dart';

class ProfilebBloc extends Bloc<ProfilebEvent, ProfilebState> {
  ProfileRepository profileRepository = ProfileRepository();

  ProfilebBloc() : super(_Initial()) {
    on<ProfilebEvent>((event, emit) async*{
      yield* event.map(
        started: (value) async*{}, 
        getAllUser: (value) async*{
          yield ProfilebState.isLoading();

          final _result = await profileRepository.getAllUser();

          yield _result.fold(
            (l) => ProfilebState.isError(l),
            (r) => ProfilebState.isSucess(r)
          );
      });
      // TODO: implement event handler  
    });
  }

}
