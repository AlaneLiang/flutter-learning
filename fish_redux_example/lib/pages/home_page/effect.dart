import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'action.dart';
import 'state.dart';
import 'counter_component/component.dart';
Effect<HomeState> buildEffect() {
  println('Effect: _update');
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _init,
    HomeAction.openSecond: _openSecond,
  });
}

void _init(Action action, Context<HomeState> ctx) {
  final CounterState counterState = new CounterState();

  ctx.dispatch(HomeActionCreator.initCounterAction(counterState));
}

void _openSecond(Action action, Context<HomeState> ctx) {
  println("_openSecond");
  Navigator.of(ctx.context)
      .pushNamed('second', arguments: null)
      .then((dynamic toDo) {

  });
}