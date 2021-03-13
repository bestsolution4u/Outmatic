import 'package:flutter/material.dart';

@immutable
abstract class ApplicationState {}

class ApplicationInitialState extends ApplicationState {}

class ApplicationLoadingState extends ApplicationState {}

class ApplicationSetupCompletedState extends ApplicationState {}