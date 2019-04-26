import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import 'counter_component/component.dart';
Reducer<HomeState> buildReducer() {
  println('Reducer:buildReducer');
  return asReducer(
      <Object, Reducer<HomeState>>{
    //这里添加要监听的Action
        HomeAction.initCounter: _init,  //HomeAction.update
  });
}

HomeState _init(HomeState state, Action action) {
  println('HomeReducer:  _init');
  final CounterState counterState = action.payload ?? new CounterState();
  final HomeState newState = state.clone();
  newState.counterState = counterState;
  return newState;
}
