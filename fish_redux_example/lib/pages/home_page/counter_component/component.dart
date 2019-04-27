import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart'; //将自己组件内的状态对外暴露接口

class CounterComponent extends Component<CounterState> {
  CounterComponent()
      :super(
    view: buildView,
    reducer: buildReducer(),
  );

}
