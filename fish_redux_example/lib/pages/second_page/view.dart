import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SecondState state, Dispatch dispatch, ViewService viewService) {
  return  Scaffold(
    appBar: AppBar(
      title: Text("New route"),
    ),
    body: Center(
      child: Text("This is new route"),
    ),
  );
}
