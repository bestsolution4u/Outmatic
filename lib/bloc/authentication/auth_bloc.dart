import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/config/application.dart';
import 'package:outmatic/model/user_model.dart';
import 'package:outmatic/repository/user_repository.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc() : super(AuthenticationInitial());

  final UserRepository userRepository = UserRepository();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStartEvent) {
      yield* _mapAuthenticationStartEventToState();
    } if (event is AuthenticationSuccessEvent) {
      yield* _mapAuthenticationSuccessEventToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartEventToState() async* {
    UserModel user = userRepository.getUser();
    if (user != null) {
      Application.user = user;
      yield AuthenticationSuccess();
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationSuccessEventToState() async* {
    yield AuthenticationSuccess();
  }
}