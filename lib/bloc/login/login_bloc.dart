import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/app_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/application.dart';
import 'package:outmatic/config/preference_param.dart';
import 'package:outmatic/model/user_model.dart';
import 'package:outmatic/repository/user_repository.dart';
import 'package:outmatic/util/preference_helper.dart';

import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitialLoginState());

  final UserRepository userRepository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is OnLoginEvent) {
      yield* _mapOnLoginEventToState(event);
    } else if (event is OnLogoutEvent) {
      yield* _mapOnLogoutEventToState();
    }
  }

  Stream<LoginState> _mapOnLoginEventToState(OnLoginEvent event) async* {
    yield LoginLoading();
    final result = await userRepository.login(email: event.email, password: event.password);
    if (result['status'] == 'sucess') {
      yield LoginSuccess();
      final UserModel user = UserModel.fromJson(result);
      Application.user = user;
      userRepository.saveUser(user);
      PreferenceHelper.setString(PreferenceParam.email, event.email);
      PreferenceHelper.setString(PreferenceParam.password, event.password);
      PreferenceHelper.setBool(PreferenceParam.saveCredentials, event.save);
      AppBloc.authBloc.add(AuthenticationSuccessEvent());
    } else {
      yield LoginFailed();
    }
  }

  Stream<LoginState> _mapOnLogoutEventToState() async* {
    userRepository.clearUser();
    AppBloc.authBloc.add(AuthenticationStartEvent());
  }
}