import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final String searchBarValue;
  final bool isOverlayOpenValue;

  const DashboardState({this.selectedIndex = 0, this.searchBarValue='',this.isOverlayOpenValue =false});

  DashboardState copyWith({
    String? searchBarValue,
    int? selectedIndex,
    bool? isOverlayOpenValue,
}){
   return DashboardState(selectedIndex: selectedIndex ?? this.selectedIndex,
     searchBarValue:searchBarValue ?? this.searchBarValue,isOverlayOpenValue: isOverlayOpenValue??this.isOverlayOpenValue );
}

  @override
  List<Object?> get props => [selectedIndex,searchBarValue,isOverlayOpenValue];
}
