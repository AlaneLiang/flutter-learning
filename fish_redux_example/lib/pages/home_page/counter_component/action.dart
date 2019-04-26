import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CounterAction { update }

class CounterActionCreator {
  static Action updateCounterAction(int value) {
    return Action(CounterAction.update, payload: value);
  }
}
