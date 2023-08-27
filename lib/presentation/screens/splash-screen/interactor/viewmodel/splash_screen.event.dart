import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object?> get props => [];
}

class OnInitialEvent extends SplashScreenEvent {
  const OnInitialEvent();

  @override
  String toString() => 'OnInitialEvent';
}

class ClearSplashScreenPageCommand extends SplashScreenEvent {
  const ClearSplashScreenPageCommand();

  @override
  String toString() => 'ClearSplashScreenPageCommand';
}
