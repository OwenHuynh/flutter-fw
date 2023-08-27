import 'package:equatable/equatable.dart';

class DemoState extends Equatable {
  const DemoState({required this.count});

  factory DemoState.initial() {
    return const DemoState(count: 0);
  }

  final int count;

  @override
  List<Object?> get props => [count];

  DemoState copyWith({int? count}) {
    return DemoState(count: count ?? this.count);
  }
}
