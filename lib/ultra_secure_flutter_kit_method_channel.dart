import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ultra_secure_flutter_kit_platform_interface.dart';

/// An implementation of [UltraSecureFlutterKitPlatform] that uses method channels.
class MethodChannelUltraSecureFlutterKit extends UltraSecureFlutterKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ultra_secure_flutter_kit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<bool> isRooted() async {
    final result = await methodChannel.invokeMethod<bool>('isRooted');
    return result ?? false;
  }

  @override
  Future<bool> isJailbroken() async {
    final result = await methodChannel.invokeMethod<bool>('isJailbroken');
    return result ?? false;
  }

  @override
  Future<bool> isEmulator() async {
    final result = await methodChannel.invokeMethod<bool>('isEmulator');
    return result ?? false;
  }

  @override
  Future<bool> isDebuggerAttached() async {
    final result = await methodChannel.invokeMethod<bool>('isDebuggerAttached');
    return result ?? false;
  }

  @override
  Future<void> enableScreenCaptureProtection() async {
    await methodChannel.invokeMethod<void>('enableScreenCaptureProtection');
  }

  @override
  Future<void> disableScreenCaptureProtection() async {
    await methodChannel.invokeMethod<void>('disableScreenCaptureProtection');
  }

  @override
  Future<bool> isScreenCaptureBlocked() async {
    final result = await methodChannel.invokeMethod<bool>(
      'isScreenCaptureBlocked',
    );
    return result ?? false;
  }

  @override
  Future<bool> isUsbCableAttached() async {
    final result = await methodChannel.invokeMethod<bool>('isUsbCableAttached');
    return result ?? false;
  }

  @override
  Future<Map<String, dynamic>> getUsbConnectionStatus() async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'getUsbConnectionStatus',
      );
      
      print('USB Connection Status Result Type: ${result.runtimeType}');
      print('USB Connection Status Result: $result');
      
      // Handle type conversion from platform-specific implementations
      if (result is Map) {
        // Convert the map to the expected type with proper type safety
        final Map<String, dynamic> convertedMap = <String, dynamic>{};
        result.forEach((key, value) {
          final String stringKey = key is String ? key : key.toString();
          convertedMap[stringKey] = value;
        });
        print('Converted Map: $convertedMap');
        return convertedMap;
      }
      
      print('Result is not a Map, returning default values');
      return _getDefaultUsbStatus('Invalid response type: ${result.runtimeType}');
    } catch (e) {
      print('Error in getUsbConnectionStatus: $e');
      return _getDefaultUsbStatus('Exception: $e');
    }
  }

  /// Helper method to create default USB status
  Map<String, dynamic> _getDefaultUsbStatus(String error) {
    return <String, dynamic>{
      'isAttached': false,
      'connectionType': 'none',
      'isCharging': false,
      'isDataTransfer': false,
      'isUsbCharging': false,
      'isConnectedToComputer': false,
      'isConnectedViaUsb': false,
      'deviceCount': 0,
      'powerSource': 'none',
      'error': error,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }

  @override
  Future<String> getAppSignature() async {
    final result = await methodChannel.invokeMethod<String>('getAppSignature');
    return result ?? '';
  }

  @override
  Future<bool> verifyAppIntegrity() async {
    final result = await methodChannel.invokeMethod<bool>('verifyAppIntegrity');
    return result ?? false;
  }

  @override
  Future<String> getDeviceFingerprint() async {
    final result = await methodChannel.invokeMethod<String>(
      'getDeviceFingerprint',
    );
    return result ?? '';
  }

  @override
  Future<void> enableSecureFlag() async {
    await methodChannel.invokeMethod<void>('enableSecureFlag');
  }

  @override
  Future<void> enableNetworkMonitoring() async {
    await methodChannel.invokeMethod<void>('enableNetworkMonitoring');
  }

  @override
  Future<void> enableRealTimeMonitoring() async {
    await methodChannel.invokeMethod<void>('enableRealTimeMonitoring');
  }

  @override
  Future<void> preventReverseEngineering() async {
    await methodChannel.invokeMethod<void>('preventReverseEngineering');
  }

  @override
  Future<bool> isDeveloperModeEnabled() async {
    final result = await methodChannel.invokeMethod<bool>(
      'isDeveloperModeEnabled',
    );
    return result ?? false;
  }

  @override
  Future<void> openDeveloperOptionsSettings() async {
    await methodChannel.invokeMethod<void>('openDeveloperOptionsSettings');
  }

  @override
  Future<void> applyAntiTampering() async {
    await methodChannel.invokeMethod<void>('applyAntiTampering');
  }

  @override
  Future<bool> hasProxySettings() async {
    final result = await methodChannel.invokeMethod<bool>('hasProxySettings');
    return result ?? false;
  }

  @override
  Future<bool> hasVPNConnection() async {
    final result = await methodChannel.invokeMethod<bool>('hasVPNConnection');
    return result ?? false;
  }

  @override
  Future<List<String>> getUnexpectedCertificates() async {
    final result = await methodChannel.invokeMethod<List<dynamic>>(
      'getUnexpectedCertificates',
    );
    return result?.cast<String>() ?? [];
  }

  @override
  Future<void> configureSSLPinning(
    List<String> certificates,
    List<String> publicKeys,
  ) async {
    await methodChannel.invokeMethod<void>('configureSSLPinning', {
      'certificates': certificates,
      'publicKeys': publicKeys,
    });
  }

  @override
  Future<bool> verifySSLPinning(String url) async {
    final result = await methodChannel.invokeMethod<bool>('verifySSLPinning', {
      'url': url,
    });
    return result ?? false;
  }
}
