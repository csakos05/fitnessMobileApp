part of 'app_start_bloc.dart';

sealed class AppStartState {}

final class AppStartInitial extends AppStartState {}

final class AppStartLoading extends AppStartState {}

final class AppStartSuccess extends AppStartState {}

final class AppStartError extends AppStartState {}
