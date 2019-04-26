import 'package:fish_redux/fish_redux.dart';

import 'counter_component/component.dart';

class HomeState implements Cloneable<HomeState> {

  CounterState counterState;


  @override
  HomeState clone() {
    return HomeState()..counterState = counterState;;
  }
}

HomeState initState(Map<String, dynamic> args) {
  println('HomeState:initState');
  return HomeState()..counterState = CounterState();
}

class CounterConnector extends ConnOp<HomeState, CounterState> {
  @override
  CounterState get(HomeState state) {
    return state.counterState;
  }

  @override
  void set(HomeState state, CounterState counterState) {
    state.counterState = counterState;
  }
}