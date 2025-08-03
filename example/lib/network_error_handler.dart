import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Network error types that can occur in the app
enum NetworkErrorType {
  noNetworkConnection,
  dnsResolutionFailed,
  timeout,
  serverError,
  sslError,
  unknown,
}

/// Network error information
class NetworkErrorInfo {
  final NetworkErrorType type;
  final String message;
  final String? originalError;
  final int? errorCode;
  final bool isRetryable;

  NetworkErrorInfo({
    required this.type,
    required this.message,
    this.originalError,
    this.errorCode,
    this.isRetryable = true,
  });

  /// Parse error from exception
  factory NetworkErrorInfo.fromException(dynamic exception) {
    if (exception.toString().contains('PaisaNetworkException')) {
      return _parsePaisaNetworkException(exception);
    } else if (exception.toString().contains('SocketException')) {
      return _parseSocketException(exception);
    } else if (exception.toString().contains('TimeoutException')) {
      return _parseTimeoutException(exception);
    } else {
      return NetworkErrorInfo(
        type: NetworkErrorType.unknown,
        message: 'An unexpected network error occurred',
        originalError: exception.toString(),
        isRetryable: true,
      );
    }
  }

  /// Parse PaisaNetworkException specifically
  static NetworkErrorInfo _parsePaisaNetworkException(dynamic exception) {
    final errorString = exception.toString();

    if (errorString.contains('net::ERR_NAME_NOT_RESOLVED')) {
      return NetworkErrorInfo(
        type: NetworkErrorType.dnsResolutionFailed,
        message:
            'Unable to connect to the server. Please check your internet connection and try again.',
        originalError: errorString,
        errorCode: 14,
        isRetryable: true,
      );
    } else if (errorString.contains('net::ERR_CONNECTION_TIMED_OUT')) {
      return NetworkErrorInfo(
        type: NetworkErrorType.timeout,
        message: 'Connection timed out. Please try again.',
        originalError: errorString,
        isRetryable: true,
      );
    } else if (errorString.contains('NetworkErrorType.noNetworkConnection')) {
      return NetworkErrorInfo(
        type: NetworkErrorType.noNetworkConnection,
        message:
            'No internet connection available. Please check your network settings.',
        originalError: errorString,
        isRetryable: true,
      );
    } else {
      return NetworkErrorInfo(
        type: NetworkErrorType.unknown,
        message: 'A network error occurred. Please try again later.',
        originalError: errorString,
        isRetryable: true,
      );
    }
  }

  /// Parse SocketException
  static NetworkErrorInfo _parseSocketException(dynamic exception) {
    return NetworkErrorInfo(
      type: NetworkErrorType.noNetworkConnection,
      message:
          'No internet connection available. Please check your network settings.',
      originalError: exception.toString(),
      isRetryable: true,
    );
  }

  /// Parse TimeoutException
  static NetworkErrorInfo _parseTimeoutException(dynamic exception) {
    return NetworkErrorInfo(
      type: NetworkErrorType.timeout,
      message: 'Request timed out. Please try again.',
      originalError: exception.toString(),
      isRetryable: true,
    );
  }
}

/// Network error handler widget
class NetworkErrorHandler {
  /// Show a user-friendly error dialog for network errors
  static Future<void> showNetworkErrorDialog(
    BuildContext context,
    NetworkErrorInfo errorInfo, {
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                _getErrorIcon(errorInfo.type),
                color: _getErrorColor(errorInfo.type),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(_getErrorTitle(errorInfo.type)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(errorInfo.message),
              if (errorInfo.originalError != null) ...[
                const SizedBox(height: 12),
                const Text(
                  'Technical Details:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    errorInfo.originalError!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            if (onDismiss != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onDismiss();
                },
                child: const Text('Dismiss'),
              ),
            if (errorInfo.isRetryable && onRetry != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRetry();
                },
                child: const Text('Retry'),
              ),
            if (!errorInfo.isRetryable)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
          ],
        );
      },
    );
  }

  /// Show a snackbar for network errors
  static void showNetworkErrorSnackBar(
    BuildContext context,
    NetworkErrorInfo errorInfo, {
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getErrorIcon(errorInfo.type), color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(errorInfo.message)),
          ],
        ),
        backgroundColor: _getErrorColor(errorInfo.type),
        duration: const Duration(seconds: 4),
        action: errorInfo.isRetryable && onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }

  /// Get appropriate icon for error type
  static IconData _getErrorIcon(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noNetworkConnection:
        return Icons.wifi_off;
      case NetworkErrorType.dnsResolutionFailed:
        return Icons.dns;
      case NetworkErrorType.timeout:
        return Icons.timer_off;
      case NetworkErrorType.serverError:
        return Icons.error_outline;
      case NetworkErrorType.sslError:
        return Icons.security;
      case NetworkErrorType.unknown:
        return Icons.help_outline;
    }
  }

  /// Get appropriate color for error type
  static Color _getErrorColor(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noNetworkConnection:
        return Colors.orange;
      case NetworkErrorType.dnsResolutionFailed:
        return Colors.red;
      case NetworkErrorType.timeout:
        return Colors.amber;
      case NetworkErrorType.serverError:
        return Colors.red;
      case NetworkErrorType.sslError:
        return Colors.red;
      case NetworkErrorType.unknown:
        return Colors.grey;
    }
  }

  /// Get appropriate title for error type
  static String _getErrorTitle(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noNetworkConnection:
        return 'No Internet Connection';
      case NetworkErrorType.dnsResolutionFailed:
        return 'Connection Error';
      case NetworkErrorType.timeout:
        return 'Request Timeout';
      case NetworkErrorType.serverError:
        return 'Server Error';
      case NetworkErrorType.sslError:
        return 'Security Error';
      case NetworkErrorType.unknown:
        return 'Network Error';
    }
  }

  /// Handle network errors with automatic retry logic
  static Future<T?> handleNetworkOperation<T>({
    required BuildContext context,
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
    bool showErrorDialog = true,
    bool showErrorSnackBar = true,
  }) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        return await operation();
      } catch (e) {
        retryCount++;
        final errorInfo = NetworkErrorInfo.fromException(e);

        // Log the error
        print(
          'Network error (attempt $retryCount/$maxRetries): ${errorInfo.message}',
        );
        print('Original error: ${errorInfo.originalError}');

        // If this is the last attempt or error is not retryable, show error
        if (retryCount >= maxRetries || !errorInfo.isRetryable) {
          if (showErrorDialog) {
            await showNetworkErrorDialog(
              context,
              errorInfo,
              onRetry: retryCount < maxRetries
                  ? () => handleNetworkOperation(
                      context: context,
                      operation: operation,
                      maxRetries: maxRetries - retryCount,
                      retryDelay: retryDelay,
                      showErrorDialog: showErrorDialog,
                      showErrorSnackBar: showErrorSnackBar,
                    )
                  : null,
            );
          } else if (showErrorSnackBar) {
            showNetworkErrorSnackBar(
              context,
              errorInfo,
              onRetry: retryCount < maxRetries
                  ? () => handleNetworkOperation(
                      context: context,
                      operation: operation,
                      maxRetries: maxRetries - retryCount,
                      retryDelay: retryDelay,
                      showErrorDialog: showErrorDialog,
                      showErrorSnackBar: showErrorSnackBar,
                    )
                  : null,
            );
          }
          return null;
        }

        // Wait before retrying
        await Future.delayed(retryDelay);
      }
    }

    return null;
  }

  /// Check if device has internet connectivity
  static Future<bool> hasInternetConnection() async {
    try {
      // Try to connect to a reliable host
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Get network connectivity status
  static Future<Map<String, dynamic>> getNetworkStatus() async {
    final hasConnection = await hasInternetConnection();

    return {
      'hasInternetConnection': hasConnection,
      'timestamp': DateTime.now().toIso8601String(),
      'errorType': hasConnection
          ? null
          : NetworkErrorType.noNetworkConnection.name,
    };
  }
}

/// Extension to add network error handling to BuildContext
extension NetworkErrorHandlerExtension on BuildContext {
  /// Handle network operations with automatic error handling
  Future<T?> handleNetworkOperation<T>({
    required Future<T> Function() operation,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
    bool showErrorDialog = true,
    bool showErrorSnackBar = true,
  }) {
    return NetworkErrorHandler.handleNetworkOperation(
      context: this,
      operation: operation,
      maxRetries: maxRetries,
      retryDelay: retryDelay,
      showErrorDialog: showErrorDialog,
      showErrorSnackBar: showErrorSnackBar,
    );
  }

  /// Show network error dialog
  Future<void> showNetworkErrorDialog(
    NetworkErrorInfo errorInfo, {
    VoidCallback? onRetry,
    VoidCallback? onDismiss,
  }) {
    return NetworkErrorHandler.showNetworkErrorDialog(
      this,
      errorInfo,
      onRetry: onRetry,
      onDismiss: onDismiss,
    );
  }

  /// Show network error snackbar
  void showNetworkErrorSnackBar(
    NetworkErrorInfo errorInfo, {
    VoidCallback? onRetry,
  }) {
    NetworkErrorHandler.showNetworkErrorSnackBar(
      this,
      errorInfo,
      onRetry: onRetry,
    );
  }
}
