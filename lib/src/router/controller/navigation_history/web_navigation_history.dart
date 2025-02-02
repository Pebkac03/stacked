import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:stacked/src/router/controller/routing_controller.dart';
import 'package:web/web.dart' as web;

import 'navigation_history_base.dart';

class NavigationHistoryImpl extends NavigationHistory {
  NavigationHistoryImpl(this.router);

  @override
  final StackRouter router;

  final _history = web.window.history;

  @override
  void back() {
    _history.back();
  }

  int get _currentIndex {
    final state = _history.state;
    if (state.isA<JSObject>()) {
      state as JSObject;
      try {
        return state.getProperty<JSNumber>('serialCount'.toJS).toDartInt;
      } catch (error, _) {
        return 0;
      }
    }
    return 0;
  }

  @override
  bool get canNavigateBack => _currentIndex > 0;

  @override
  void forward() => _history.forward();

  @override
  int get length => _history.length;
}
