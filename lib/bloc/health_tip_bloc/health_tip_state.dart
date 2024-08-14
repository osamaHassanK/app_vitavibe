part of 'health_tip_bloc.dart';


class HealthTipState extends Equatable {
  final int index;
  HealthTipState({this.index = 0});

  HealthTipState copyWith({
   required int? index
}){
  return  HealthTipState(index: index ?? this.index);
  }

  @override

  List<Object?> get props => [index];
}


