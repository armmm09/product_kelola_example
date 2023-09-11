import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void navigateTo(int index) {
    state = state.copyWith(page: index);
  }
}

class AppState {
  final int page;

  AppState({this.page = 0});

  AppState copyWith({int? page}) {
    return AppState(
      page: page ?? this.page,
    );
  }
}

final appStateProvider =
    StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
