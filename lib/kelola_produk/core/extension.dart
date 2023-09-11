import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ListExtension<E> on List<E>? {
  E find(bool Function(E e) test, E Function() orElse) {
    return (this ?? []).firstWhere(test, orElse: orElse);
  }
}

extension CustomExtension<NotifierT extends StateNotifier<StateT>, StateT> on StateNotifierProvider<NotifierT, StateT> {
  /// ```dart
  /// myStateProvider.watch((value) {
  ///   return Text('Generated: ${value.randomName}');
  /// })
  /// ```
  Widget watch(
    Widget Function(StateT value) builder,
  ) {
    return Consumer(
      builder: (context, ref, _) {
        final value = ref.watch(this);
        return builder(value);
      },
    );
  }
}

extension AsyncConsumerExtension<T> on AutoDisposeStateNotifierProvider<StateNotifier<AsyncValue<T>>, AsyncValue<T>> {
  /// ```dart
  /// autoDisposeProvider.watch<bool>((value) {
  ///   return IconButton(
  ///     icon: const Icon(Ti.checks),
  ///     onPressed: !value ? null : () {
  ///       // do something...
  ///     }
  ///   ).opacity(value ? 1 : .3);
  /// })
  /// ```

  Widget watch<E>(
    Widget Function(E value) builder,
  ) {
    return Consumer(
      builder: (context, ref, _) {
        final asyncData = ref.watch(this);

        if (E == bool) {
          return asyncData.maybeWhen(
            data: (_) => builder(true as E),
            orElse: () => builder(false as E),
          );
        }

        return asyncData.maybeWhen(
          data: (_) => builder(_ as E),
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}