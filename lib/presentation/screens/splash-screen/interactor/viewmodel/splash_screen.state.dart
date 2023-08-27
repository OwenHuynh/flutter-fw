import 'package:equatable/equatable.dart';
import 'package:flutter_fm/shared/command/page_command.dart';
import 'package:flutter_fm/shared/utils/page_state.dart';

class SplashScreenState extends Equatable {
  const SplashScreenState({this.pageCommand, required this.pageState});

  factory SplashScreenState.initial() {
    return const SplashScreenState(pageState: PageState.initial);
  }

  final PageCommand? pageCommand;
  final PageState pageState;

  @override
  List<Object?> get props => [pageCommand, pageState];

  SplashScreenState copyWith({PageCommand? pageCommand, PageState? pageState}) {
    return SplashScreenState(
      pageCommand: pageCommand,
      pageState: pageState ?? this.pageState,
    );
  }
}
