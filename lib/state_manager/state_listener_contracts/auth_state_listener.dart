import 'base_state_listener.dart';

/// Interface for states that need authentication
abstract class AuthStateListener implements BaseStateListener {
  /// login event handler
  void onLogin();

  /// logout event handler
  void onLogout();
}
