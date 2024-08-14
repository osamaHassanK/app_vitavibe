import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class SearchSupplement extends DashboardEvent {
  final String searchBarValue;
  SearchSupplement(this.searchBarValue);
}

class ShowNotificationOverlay extends DashboardEvent {
  final bool isOverlayOpen;
  ShowNotificationOverlay({required this.isOverlayOpen});
  @override
  List<Object?> get props => [isOverlayOpen];
}

class TabUpdated extends DashboardEvent {
  final int index;

  const TabUpdated(this.index);

  @override
  List<Object?> get props => [index];
}
