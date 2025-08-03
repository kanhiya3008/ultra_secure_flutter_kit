import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ultra_secure_flutter_kit_method_channel.dart';

abstract class UltraSecureFlutterKitPlatform extends PlatformInterface {
  /// Constructs a UltraSecureFlutterKitPlatform.
  UltraSecureFlutterKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static UltraSecureFlutterKitPlatform _instance =
      MethodChannelUltraSecureFlutterKit();

  /// Default instance of [UltraSecureFlutterKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelUltraSecureFlutterKit].
  static UltraSecureFlutterKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UltraSecureFlutterKitPlatform] when
  /// they register themselves.
  static set instance(UltraSecureFlutterKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  // Core security methods
  Future<bool> isRooted() {
    throw UnimplementedError('isRooted() has not been implemented.');
  }

  Future<bool> isJailbroken() {
    throw UnimplementedError('isJailbroken() has not been implemented.');
  }

  Future<bool> isEmulator() {
    throw UnimplementedError('isEmulator() has not been implemented.');
  }

  Future<bool> isDebuggerAttached() {
    throw UnimplementedError('isDebuggerAttached() has not been implemented.');
  }

  Future<void> enableScreenCaptureProtection() {
    throw UnimplementedError(
      'enableScreenCaptureProtection() has not been implemented.',
    );
  }

  Future<void> disableScreenCaptureProtection() {
    throw UnimplementedError(
      'disableScreenCaptureProtection() has not been implemented.',
    );
  }

  Future<bool> isScreenCaptureBlocked() {
    throw UnimplementedError(
      'isScreenCaptureBlocked() has not been implemented.',
    );
  }

  Future<String> getAppSignature() {
    throw UnimplementedError('getAppSignature() has not been implemented.');
  }

  Future<bool> verifyAppIntegrity() {
    throw UnimplementedError('verifyAppIntegrity() has not been implemented.');
  }

  Future<String> getDeviceFingerprint() {
    throw UnimplementedError(
      'getDeviceFingerprint() has not been implemented.',
    );
  }

  Future<void> enableSecureFlag() {
    throw UnimplementedError('enableSecureFlag() has not been implemented.');
  }

  Future<void> enableNetworkMonitoring() {
    throw UnimplementedError(
      'enableNetworkMonitoring() has not been implemented.',
    );
  }

  Future<void> enableRealTimeMonitoring() {
    throw UnimplementedError(
      'enableRealTimeMonitoring() has not been implemented.',
    );
  }

  Future<void> preventReverseEngineering() {
    throw UnimplementedError(
      'preventReverseEngineering() has not been implemented.',
    );
  }

  Future<bool> isDeveloperModeEnabled() {
    throw UnimplementedError(
      'isDeveloperModeEnabled() has not been implemented.',
    );
  }

  Future<void> openDeveloperOptionsSettings() {
    throw UnimplementedError(
      'openDeveloperOptionsSettings() has not been implemented.',
    );
  }

  Future<void> applyAntiTampering() {
    throw UnimplementedError('applyAntiTampering() has not been implemented.');
  }

  Future<bool> hasProxySettings() {
    throw UnimplementedError('hasProxySettings() has not been implemented.');
  }

  Future<bool> hasVPNConnection() {
    throw UnimplementedError('hasVPNConnection() has not been implemented.');
  }

  Future<List<String>> getUnexpectedCertificates() {
    throw UnimplementedError(
      'getUnexpectedCertificates() has not been implemented.',
    );
  }
}
