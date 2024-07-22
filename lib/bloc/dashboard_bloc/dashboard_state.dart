import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final int selectedIndex;
  final String searchBarValue;

  const DashboardState({this.selectedIndex = 0, this.searchBarValue=''});

  DashboardState copyWith({
    String? searchBarValue,
    int? selectedIndex,
}){
   return DashboardState(selectedIndex: selectedIndex ?? this.selectedIndex,
     searchBarValue:searchBarValue ?? this.searchBarValue, );
}

  @override
  List<Object?> get props => [selectedIndex,searchBarValue];
}
