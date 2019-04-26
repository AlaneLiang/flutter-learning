import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'counter_component/component.dart';
class HomePage extends Page<HomeState, Map<String, dynamic>> {
  HomePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomeState>(
                adapter: null,
                slots: <String, Dependent<HomeState>>{
                  'counter': CounterConnector() + CounterComponent()
                }),
            middleware: <Middleware<HomeState>>[
              logMiddleware(tag: 'HomePage',
                monitor: (HomeState state) {
                  return state?.counterState?.counter?.toString();
                },)
            ],);

}
