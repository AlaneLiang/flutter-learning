import 'package:fish_redux/fish_redux.dart';
import 'counter_component/component.dart';
//TODO replace with your own action

enum HomeAction { initCounter,openSecond }

class HomeActionCreator {
  static Action initCounterAction(CounterState counterState) {
    println('Homeaction:update');
    return  Action(HomeAction.initCounter, payload: counterState);
  }

  static Action openSecond() {
    return const Action(HomeAction.openSecond);
  }
}
