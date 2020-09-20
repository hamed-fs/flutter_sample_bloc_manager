import 'base_state_listener.dart';

/// Interface for states that need connection
abstract class ConnectivityStateListener implements BaseStateListener {
  /// Connect event handler
  void onConnect();

  /// Disconnect event handler
  void onDisconnect();
}
