import 'package:bloc/bloc.dart';
import 'package:bloc_cubit/domain/core/user/model/user_response.dart';
import 'package:bloc_cubit/infrastructure/profile/profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profileb_event.dart';
part 'profileb_state.dart';
part 'profileb_bloc.freezed.dart';

class ProfilebBloc extends Bloc<ProfilebEvent, ProfilebState> {
  ProfileRepository _profileRepository = ProfileRepository();
  ProfilebBloc() : super(_Initial()) {
    on<ProfilebEvent>((event, emit) async* {
      yield* event.map(
        started: (value) async* {},
        getAllUserData: (value) async* {
          yield ProfilebState.isLoading();
          // get data from api
          final _result = await _profileRepository.getAllUserData();
          // if error yield from state
          // if success yield success state with data
          yield _result.fold(
            (l) => ProfilebState.isError(l),
            (r) => ProfilebState.isSuccess(r),
          );
        },
      );
    });
  }
}
