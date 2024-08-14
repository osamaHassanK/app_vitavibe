part of 'health_tip_bloc.dart';

@immutable
sealed class HealthTipEvent extends Equatable{}


class ListenListViewIndex extends HealthTipEvent{
  final int index;
  ListenListViewIndex({required  this.index});

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}