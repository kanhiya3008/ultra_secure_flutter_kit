import 'package:flutter/material.dart';
import 'dart:async';
import 'network_error_handler.dart';

/// Widget that monitors network connectivity and displays status
class NetworkConnectivityWidget extends StatefulWidget {
  final Widget child;
  final bool showStatusBar;
  final bool showOfflineBanner;
  final Duration checkInterval;
  final VoidCallback? onConnectionRestored;
  final VoidCallback? onConnectionLost;

  const NetworkConnectivityWidget({
    super.key,
    required this.child,
    this.showStatusBar = true,
    this.showOfflineBanner = true,
    this.checkInterval = const Duration(seconds: 5),
    this.onConnectionRestored,
    this.onConnectionLost,
  });

  @override
  State<NetworkConnectivityWidget> createState() =>
      _NetworkConnectivityWidgetState();
}

class _NetworkConnectivityWidgetState extends State<NetworkConnectivityWidget> {
  bool _hasConnection = true;
  bool _isChecking = false;
  Timer? _timer;
  StreamSubscription<bool>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _startPeriodicCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void _startPeriodicCheck() {
    _timer = Timer.periodic(widget.checkInterval, (_) {
      _checkConnectivity();
    });
  }

  Future<void> _checkConnectivity() async {
    if (_isChecking) return;

    setState(() {
      _isChecking = true;
    });

    try {
      final hasConnection = await NetworkErrorHandler.hasInternetConnection();

      if (mounted) {
        final previousConnection = _hasConnection;
        setState(() {
          _hasConnection = hasConnection;
          _isChecking = false;
        });

        // Notify callbacks about connection changes
        if (previousConnection != hasConnection) {
          if (hasConnection) {
            widget.onConnectionRestored?.call();
          } else {
            widget.onConnectionLost?.call();
          }
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasConnection = false;
          _isChecking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showStatusBar && !_hasConnection)
          Positioned(top: 0, left: 0, right: 0, child: _buildStatusBar()),
        if (widget.showOfflineBanner && !_hasConnection)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildOfflineBanner(),
          ),
      ],
    );
  }

  Widget _buildStatusBar() {
    return Container(
      height: 4,
      color: Colors.red,
      child: const LinearProgressIndicator(
        backgroundColor: Colors.red,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildOfflineBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.red,
      child: Row(
        children: [
          const Icon(Icons.wifi_off, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'No internet connection',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (_isChecking)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

/// Network status indicator widget
class NetworkStatusIndicator extends StatelessWidget {
  final bool hasConnection;
  final bool isChecking;
  final VoidCallback? onRetry;
  final double size;

  const NetworkStatusIndicator({
    super.key,
    required this.hasConnection,
    this.isChecking = false,
    this.onRetry,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _getStatusColor().withOpacity(0.1),
        ),
        child: Center(
          child: isChecking
              ? SizedBox(
                  width: size * 0.6,
                  height: size * 0.6,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getStatusColor(),
                    ),
                  ),
                )
              : Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                  size: size * 0.6,
                ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (isChecking) return Colors.blue;
    return hasConnection ? Colors.green : Colors.red;
  }

  IconData _getStatusIcon() {
    if (hasConnection) {
      return Icons.wifi;
    } else {
      return Icons.wifi_off;
    }
  }
}

/// Network connectivity monitor service
class NetworkConnectivityMonitor {
  static final NetworkConnectivityMonitor _instance =
      NetworkConnectivityMonitor._internal();
  factory NetworkConnectivityMonitor() => _instance;
  NetworkConnectivityMonitor._internal();

  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();
  Stream<bool> get connectivityStream => _connectivityController.stream;

  Timer? _timer;
  bool _hasConnection = true;

  /// Start monitoring network connectivity
  void startMonitoring({Duration interval = const Duration(seconds: 5)}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) => _checkConnectivity());
    _checkConnectivity(); // Initial check
  }

  /// Stop monitoring network connectivity
  void stopMonitoring() {
    _timer?.cancel();
    _timer = null;
  }

  /// Get current connection status
  bool get hasConnection => _hasConnection;

  /// Check connectivity and update stream
  Future<void> _checkConnectivity() async {
    try {
      final hasConnection = await NetworkErrorHandler.hasInternetConnection();

      if (_hasConnection != hasConnection) {
        _hasConnection = hasConnection;
        _connectivityController.add(hasConnection);
      }
    } catch (e) {
      if (_hasConnection) {
        _hasConnection = false;
        _connectivityController.add(false);
      }
    }
  }

  /// Dispose the monitor
  void dispose() {
    stopMonitoring();
    _connectivityController.close();
  }
}

/// Network connectivity builder widget
class NetworkConnectivityBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    bool hasConnection,
    bool isChecking,
  )
  builder;
  final Duration checkInterval;
  final Widget? loadingWidget;

  const NetworkConnectivityBuilder({
    super.key,
    required this.builder,
    this.checkInterval = const Duration(seconds: 5),
    this.loadingWidget,
  });

  @override
  State<NetworkConnectivityBuilder> createState() =>
      _NetworkConnectivityBuilderState();
}

class _NetworkConnectivityBuilderState
    extends State<NetworkConnectivityBuilder> {
  bool _hasConnection = true;
  bool _isChecking = true;
  StreamSubscription<bool>? _subscription;

  @override
  void initState() {
    super.initState();
    _initializeConnectivity();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _initializeConnectivity() async {
    // Initial check
    await _checkConnectivity();

    // Listen to connectivity changes
    _subscription = NetworkConnectivityMonitor().connectivityStream.listen((
      hasConnection,
    ) {
      if (mounted) {
        setState(() {
          _hasConnection = hasConnection;
          _isChecking = false;
        });
      }
    });
  }

  Future<void> _checkConnectivity() async {
    try {
      final hasConnection = await NetworkErrorHandler.hasInternetConnection();
      if (mounted) {
        setState(() {
          _hasConnection = hasConnection;
          _isChecking = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasConnection = false;
          _isChecking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking && widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }

    return widget.builder(context, _hasConnection, _isChecking);
  }
}
