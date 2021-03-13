import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/app_bloc.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/config/routes.dart';
import 'package:outmatic/screen/screen.dart';

import 'util/app_theme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final routes = Routes();

  @override
  void initState() {
    AppBloc.applicationBloc.add(ApplicationStartEvent());
    super.initState();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppTheme.primaryDarkColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
        providers: AppBloc.blocProviders,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routes.generateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: AppTheme.textTheme,
            platform: TargetPlatform.iOS,
          ),
          home: BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationSuccess) {
                return HomeNavigationScreen();
              } else if (state is AuthenticationFailure) {
                return LoginScreen();
              } else {
                return SplashScreen();
              }
            },
        ),
        ));
  }
}
