import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'health_tip_event.dart';
part 'health_tip_state.dart';

class HealthTipBloc extends Bloc<HealthTipEvent, HealthTipState> {
  HealthTipBloc() : super(HealthTipState()){
    on<ListenListViewIndex>(_listenListViewState);
  }

  void _listenListViewState(ListenListViewIndex event,Emitter<HealthTipState> emit){
    emit(state.copyWith(index: event.index));
  }
}
