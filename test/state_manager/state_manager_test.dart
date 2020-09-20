import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_sample_bloc_manager/state_manager/state_manager.dart';
import 'package:flutter_sample_bloc_manager/state_manager/state_manager_contract.dart';

void main() {
  StateManagerContract stateManager;

  setUpAll(() => stateManager = StateManager.instance
    ..register<FirstCubit>(() => FirstCubit()));

  tearDown(() => stateManager.dispose<FirstCubit>());

  group('state manager test =>', () {
    test('should register and fetch cubit from state manager.', () {
      expect(stateManager.fetch<FirstCubit>(), isA<Cubit<bool>>());
    });

    blocTest<FirstCubit, bool>(
      'emits [loginState()] to cubit and register a listener for state manager.',
      build: () {
        stateManager.addListener<FirstCubit>(
          key: 'FirstCubitListener',
          handler: (dynamic state) => expect(state, true),
        );

        return stateManager.fetch<FirstCubit>();
      },
      act: (FirstCubit cubit) => <void>[cubit.loginState()],
      expect: <bool>[true],
    );
  });
}

class FirstCubit extends Cubit<bool> {
  FirstCubit() : super(false);

  void loginState() => emit(true);

  void logoutState() => emit(false);
}
