/// Interface for network connectivity status checks.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Baseline NetworkInfo implementation.
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    // In a production setup, can ping a reliable DNS or check connectivity_plus
    return true;
  }
}
