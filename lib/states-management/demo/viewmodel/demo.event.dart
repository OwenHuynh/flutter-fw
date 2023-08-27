import 'package:equatable/equatable.dart';

abstract class DemoEvent extends Equatable {
  const DemoEvent();

  @override
  List<Object> get props => [];
}

class OnIncrement extends DemoEvent {
  const OnIncrement();

  @override
  String toString() => 'OnIncrement';
}

class OnDecrement extends DemoEvent {
  const OnDecrement();

  @override
  String toString() => 'OnDecrement';
}
