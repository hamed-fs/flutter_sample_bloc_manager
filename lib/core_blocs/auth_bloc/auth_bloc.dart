import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthorizeState> {
  AuthBloc() : super(LogoutState());

  @override
  Stream<AuthorizeState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield event is Login ? LoginState() : LogoutState();
  }
}
