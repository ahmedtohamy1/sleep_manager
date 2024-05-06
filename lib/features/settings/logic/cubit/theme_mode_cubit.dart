import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ThemeModeCubit extends Cubit<ShadColorScheme> {
  ThemeModeCubit() : super(const ShadRedColorScheme.dark());

  void toggleTheme() {
    emit(state == const ShadRedColorScheme.dark()
        ? const ShadGrayColorScheme.dark()
        : const ShadRedColorScheme.dark());
  }
}
