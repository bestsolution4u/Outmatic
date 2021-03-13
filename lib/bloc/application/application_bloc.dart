import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/app_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitialState());

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async* {
    if (event is ApplicationStartEvent) {
      yield* _mapApplicationStartEventToState();
    }
  }

  Stream<ApplicationState> _mapApplicationStartEventToState() async* {
    yield ApplicationLoadingState();
    await Future.delayed(const Duration(seconds: 2));
    Application.preferences = await SharedPreferences.getInstance();
    AppBloc.authBloc.add(AuthenticationStartEvent());
    yield ApplicationSetupCompletedState();
  }
}