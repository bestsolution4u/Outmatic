import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';

class AppBloc {
  static final applicationBloc = ApplicationBloc();
  static final authBloc = AuthBloc();
  static final loginBloc = LoginBloc();
  static final projectBloc = ProjectBloc();
  static final itemBloc = ItemBloc();
  static final projectItemBloc = ProjectItemBloc();
  static final itemDetailBloc = ItemDetailBloc();
  static final newItemBloc = NewItemBloc();
  static final vcaBloc = VCABloc();
  static final returnBloc = ReturnItemBloc();
  static final batchBloc = BatchBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(create: (context) => applicationBloc),
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<LoginBloc>(create: (context) => loginBloc),
    BlocProvider<ProjectBloc>(create: (context) => projectBloc),
    BlocProvider<ItemBloc>(create: (context) => itemBloc),
    BlocProvider<ProjectItemBloc>(create: (context) => projectItemBloc),
    BlocProvider<ItemDetailBloc>(create: (context) => itemDetailBloc),
    BlocProvider<NewItemBloc>(create: (context) => newItemBloc),
    BlocProvider<VCABloc>(create: (context) => vcaBloc),
    BlocProvider<ReturnItemBloc>(create: (context) => returnBloc),
    BlocProvider<BatchBloc>(create: (context) => batchBloc),
  ];

  static void dispose() {
    applicationBloc.close();
    authBloc.close();
    loginBloc.close();
    projectBloc.close();
    itemBloc.close();
    projectItemBloc.close();
    itemDetailBloc.close();
    newItemBloc.close();
    vcaBloc.close();
    returnBloc.close();
    batchBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
