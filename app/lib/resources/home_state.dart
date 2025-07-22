import 'package:app/widgets/item.dart';

class HomeState {
  final bool isDarkMode;
  final String sortBy;
  final bool isDescending;

  HomeState(
      {this.isDarkMode = false,
      this.sortBy = "successState",
      this.isDescending = true});

  HomeState copyWith({bool? isDarkMode, String? sortBy, bool? isDescending}) {
    return HomeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      sortBy: sortBy ?? this.sortBy,
      isDescending: isDescending ?? this.isDescending,
    );
  }
}
