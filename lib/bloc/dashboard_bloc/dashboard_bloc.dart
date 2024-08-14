// dashboard_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<TabUpdated>(_tabUpdatedToggle);
    on<SearchSupplement>(_changeInSearchBar);
    on<ShowNotificationOverlay>(_openAndCloseNotificationOverlay);
  }

  void _openAndCloseNotificationOverlay(ShowNotificationOverlay event, Emitter<DashboardState> emit) {
    emit(state.copyWith(isOverlayOpenValue: !state.isOverlayOpenValue));
    print('Overlay open: ${!state.isOverlayOpenValue}');
  }
  void _changeInSearchBar(SearchSupplement event,Emitter<DashboardState> emit){
    emit(state.copyWith(searchBarValue: event.searchBarValue));
  }
  void _tabUpdatedToggle(TabUpdated event,Emitter<DashboardState> emit){
    emit(state.copyWith(selectedIndex:event.index));
  }


}
