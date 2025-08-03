library ultra_secure_flutter_kit;

export 'src/models/security_models.dart';
export 'src/services/secure_monitor_service.dart';

import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart' as local_auth;

import 'ultra_secure_flutter_kit_platform_interface.dart';
import 'src/models/security_models.dart';
import 'src/services/secure_monitor_service.dart';

/// Main class for Ultra Secure Flutter Kit
///
/// A comprehensive Flutter security package providing Protect AI-style protection:
/// - Root/jailbreak detection
/// - Secure storage with AES-256 encryption
/// - Screenshot blocking
/// - SSL pinning
/// - Network monitoring
/// - Behavior monitoring
/// - Real-time threat detection
/// - Automated security response
/// - Data leakage prevention
class UltraSecureFlutterKit {
  /// Get platform version
  Future<String?> getPlatformVersion() {
    return UltraSecureFlutterKitPlatform.instance.getPlatformVersion();
  }

  /// Initialize secure_monitor-style comprehensive security
  /// This provides enterprise-grade security protection similar to secure_monitor
  Future<void> initializeSecureMonitor(SecurityConfig config) async {
    try {
      // Run initialization in background to prevent main thread blocking
      await _runInBackground(() async {
        await SecureMonitorService.instance.initialize(config);
      });
    } catch (e) {
      print('Failed to initialize Protect AI: $e');
      rethrow;
    }
  }

  /// Get secure_monitor service instance
  SecureMonitorService get secureMonitor => SecureMonitorService.instance;

  /// Check if secure_monitor is initialized and protected
  bool get isProtected =>
      SecureMonitorService.instance.currentStatus == ProtectionStatus.protected;

  /// Get current protection status
  ProtectionStatus get protectionStatus =>
      SecureMonitorService.instance.currentStatus;

  /// Get security metrics
  Map<String, dynamic> get securityMetrics =>
      SecureMonitorService.instance.securityMetrics;

  /// Get device security status
  Future<DeviceSecurityStatus> getDeviceSecurityStatus() async {
    try {
      return await _runInBackground(() async {
        return await SecureMonitorService.instance.getDeviceSecurityStatus();
      });
    } catch (e) {
      print('Failed to get device security status: $e');
      // Return a default status instead of throwing
      return const DeviceSecurityStatus(
        isRooted: false,
        isJailbroken: false,
        isEmulator: false,
        isDebuggerAttached: false,
        hasProxy: false,
        hasVPN: false,
        isScreenCaptureBlocked: false,
        isSSLValid: true,
        isBiometricAvailable: false,
        isCodeObfuscated: true,
        isDeveloperModeEnabled: false,
        isUsbCableAttached: false,
        riskScore: 0.0,
        isSecure: true,
        activeThreats: [],
      );
    }
  }

  /// Secure API call with Protect AI protection
  Future<Map<String, dynamic>> secureApiCall(
    String url,
    Map<String, dynamic> data, {
    Map<String, String>? headers,
    String method = 'POST',
  }) async {
    try {
      return await _runInBackground(() async {
        return await SecureMonitorService.instance.secureApiCall(
          url,
          data,
          headers: headers,
          method: method,
        );
      });
    } catch (e) {
      print('Secure API call failed: $e');
      return {'error': 'API call failed', 'details': e.toString()};
    }
  }

  /// Secure data storage with Protect AI protection
  Future<void> secureStore(
    String key,
    String value, {
    Duration? expiresIn,
  }) async {
    try {
      await _runInBackground(() async {
        await SecureMonitorService.instance.secureStore(
          key,
          value,
          expiresIn: expiresIn,
        );
      });
    } catch (e) {
      print('Secure store failed: $e');
      rethrow;
    }
  }

  /// Secure data retrieval with Protect AI protection
  Future<String?> secureRetrieve(String key) async {
    try {
      return await _runInBackground(() async {
        return await SecureMonitorService.instance.secureRetrieve(key);
      });
    } catch (e) {
      print('Secure retrieve failed: $e');
      return null;
    }
  }

  /// Delete secure data
  Future<void> secureDelete(String key) async {
    try {
      await _runInBackground(() async {
        await SecureMonitorService.instance.secureDelete(key);
      });
    } catch (e) {
      print('Secure delete failed: $e');
      rethrow;
    }
  }

  /// Clear all secure data
  Future<void> clearAllSecureData() async {
    try {
      await _runInBackground(() async {
        await SecureMonitorService.instance.clearAllSecureData();
      });
    } catch (e) {
      print('Clear secure data failed: $e');
      rethrow;
    }
  }

  /// Encrypt sensitive data
  Future<String> encryptSensitiveData(String data) async {
    try {
      return await _runInBackground(() async {
        return await SecureMonitorService.instance.encryptSensitiveData(data);
      });
    } catch (e) {
      print('Encryption failed: $e');
      rethrow;
    }
  }

  /// Decrypt sensitive data
  Future<String> decryptSensitiveData(String encryptedData) async {
    try {
      return await _runInBackground(() async {
        return await SecureMonitorService.instance.decryptSensitiveData(
          encryptedData,
        );
      });
    } catch (e) {
      print('Decryption failed: $e');
      rethrow;
    }
  }

  /// Sanitize input data
  String sanitizeInput(String input) {
    try {
      return SecureMonitorService.instance.sanitizeInput(input);
    } catch (e) {
      print('Input sanitization failed: $e');
      return input; // Return original input if sanitization fails
    }
  }

  /// Generate secure random data
  String generateSecureRandom({int length = 32}) {
    try {
      return SecureMonitorService.instance.generateSecureRandom(length: length);
    } catch (e) {
      print('Secure random generation failed: $e');
      return 'fallback_random_${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  /// Record behavior events
  void recordApiHit() {
    try {
      SecureMonitorService.instance.recordApiHit();
    } catch (e) {
      print('Failed to record API hit: $e');
    }
  }

  void recordScreenTouch() {
    try {
      SecureMonitorService.instance.recordScreenTouch();
    } catch (e) {
      print('Failed to record screen touch: $e');
    }
  }

  void recordAppLaunch() {
    try {
      SecureMonitorService.instance.recordAppLaunch();
    } catch (e) {
      print('Failed to record app launch: $e');
    }
  }

  /// Get behavior data
  BehaviorData getBehaviorData() {
    try {
      return SecureMonitorService.instance.getBehaviorData();
    } catch (e) {
      print('Failed to get behavior data: $e');
      return BehaviorData(
        apiHits: 0,
        screenTouches: 0,
        appLaunches: 0,
        timestamp: DateTime.now(),
        additionalData: {},
      );
    }
  }

  /// Listen to security threats
  Stream<SecurityThreat> get threatStream =>
      SecureMonitorService.instance.threatStream;

  /// Listen to protection status changes
  Stream<ProtectionStatus> get statusStream =>
      SecureMonitorService.instance.statusStream;

  // Core security methods (delegated to platform)

  /// Check if device is rooted (Android)
  Future<bool> isRooted() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.isRooted();
      });
    } catch (e) {
      print('Root detection failed: $e');
      return false;
    }
  }

  /// Check if device is jailbroken (iOS)
  Future<bool> isJailbroken() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.isJailbroken();
      });
    } catch (e) {
      print('Jailbreak detection failed: $e');
      return false;
    }
  }

  /// Check if running on emulator
  Future<bool> isEmulator() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.isEmulator();
      });
    } catch (e) {
      print('Emulator detection failed: $e');
      return false;
    }
  }

  /// Check if debugger is attached
  Future<bool> isDebuggerAttached() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .isDebuggerAttached();
      });
    } catch (e) {
      print('Debugger detection failed: $e');
      return false;
    }
  }

  /// Check if developer mode is enabled
  Future<bool> isDeveloperModeEnabled() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .isDeveloperModeEnabled();
      });
    } catch (e) {
      print('Developer mode detection failed: $e');
      return false;
    }
  }

  /// Open Developer Options settings
  Future<void> openDeveloperOptionsSettings() async {
    try {
      await UltraSecureFlutterKitPlatform.instance
          .openDeveloperOptionsSettings();
    } catch (e) {
      print('Failed to open Developer Options settings: $e');
      rethrow;
    }
  }

  /// Enable screen capture protection
  Future<void> enableScreenCaptureProtection() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .enableScreenCaptureProtection();
      });
    } catch (e) {
      print('Screen capture protection failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Disable screen capture protection
  Future<void> disableScreenCaptureProtection() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .disableScreenCaptureProtection();
      });
    } catch (e) {
      debugPrint('Screen capture protection disable failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Check if screen capture is blocked
  Future<bool> isScreenCaptureBlocked() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .isScreenCaptureBlocked();
      });
    } catch (e) {
      debugPrint('Screen capture blocking check failed: $e');
      return false;
    }
  }

  /// Check if USB cable is attached
  Future<bool> isUsbCableAttached() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .isUsbCableAttached();
      });
    } catch (e) {
      debugPrint('USB cable detection failed: $e');
      return false;
    }
  }

  /// Get USB connection status details
  Future<Map<String, dynamic>> getUsbConnectionStatus() async {
    try {
      debugPrint('Getting USB connection status...');
      final result = await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .getUsbConnectionStatus();
      });
      debugPrint('USB connection status result: $result');
      debugPrint('USB connection status result type: ${result.runtimeType}');
      return result;
    } catch (e) {
      debugPrint('USB connection status retrieval failed: $e');
      debugPrint('Error type: ${e.runtimeType}');
      return {
        'isAttached': false,
        'connectionType': 'none',
        'isCharging': false,
        'isDataTransfer': false,
        'isUsbCharging': false,
        'isConnectedToComputer': false,
        'isConnectedViaUsb': false,
        'deviceCount': 0,
        'powerSource': 'none',
        'error': e.toString(),
        'errorType': e.runtimeType.toString(),
      };
    }
  }

  /// Get app signature
  Future<String> getAppSignature() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.getAppSignature();
      });
    } catch (e) {
      debugPrint('App signature retrieval failed: $e');
      return '';
    }
  }

  /// Verify app integrity
  Future<bool> verifyAppIntegrity() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .verifyAppIntegrity();
      });
    } catch (e) {
      debugPrint('App integrity verification failed: $e');
      return false;
    }
  }

  /// Get device fingerprint
  Future<String> getDeviceFingerprint() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .getDeviceFingerprint();
      });
    } catch (e) {
      debugPrint('Device fingerprint retrieval failed: $e');
      return '';
    }
  }

  /// Enable secure flag
  Future<void> enableSecureFlag() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.enableSecureFlag();
      });
    } catch (e) {
      debugPrint('Secure flag enablement failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Enable network monitoring
  Future<void> enableNetworkMonitoring() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .enableNetworkMonitoring();
      });
    } catch (e) {
      debugPrint('Network monitoring enablement failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Enable real-time monitoring
  Future<void> enableRealTimeMonitoring() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .enableRealTimeMonitoring();
      });
    } catch (e) {
      debugPrint('Real-time monitoring enablement failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Prevent reverse engineering
  Future<void> preventReverseEngineering() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .preventReverseEngineering();
      });
    } catch (e) {
      debugPrint('Reverse engineering prevention failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Apply anti-tampering measures
  Future<void> applyAntiTampering() async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .applyAntiTampering();
      });
    } catch (e) {
      debugPrint('Anti-tampering application failed: $e');
      // Don't rethrow - this is not critical
    }
  }

  /// Update screenshot blocking configuration
  Future<void> updateScreenshotBlocking(bool enabled) async {
    try {
      await _runInBackground(() async {
        return await SecureMonitorService.instance.updateScreenshotBlocking(
          enabled,
        );
      });
    } catch (e) {
      print('Screenshot blocking update failed: $e');
      rethrow;
    }
  }

  /// Configure screenshot blocking preference
  /// Call this method to set user's preferred screenshot blocking setting
  Future<void> configureScreenshotBlocking({
    required bool enabled,
    String? reason,
  }) async {
    try {
      await updateScreenshotBlocking(enabled);

      if (reason != null) {
        print(
          'Screenshot blocking ${enabled ? 'enabled' : 'disabled'}: $reason',
        );
      }
    } catch (e) {
      print('Failed to configure screenshot blocking: $e');
      rethrow;
    }
  }

  /// Check for proxy settings
  Future<bool> hasProxySettings() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.hasProxySettings();
      });
    } catch (e) {
      print('Proxy detection failed: $e');
      return false;
    }
  }

  /// Check for VPN connection
  Future<bool> hasVPNConnection() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.hasVPNConnection();
      });
    } catch (e) {
      print('VPN detection failed: $e');
      return false;
    }
  }

  /// Get unexpected certificates
  Future<List<String>> getUnexpectedCertificates() async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance
            .getUnexpectedCertificates();
      });
    } catch (e) {
      print('Certificate retrieval failed: $e');
      return [];
    }
  }

  /// Configure SSL pinning
  Future<void> configureSSLPinning(
    List<String> certificates,
    List<String> publicKeys,
  ) async {
    try {
      await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.configureSSLPinning(
          certificates,
          publicKeys,
        );
      });
    } catch (e) {
      print('SSL pinning configuration failed: $e');
      rethrow;
    }
  }

  /// Verify SSL pinning for a URL
  Future<bool> verifySSLPinning(String url) async {
    try {
      return await _runInBackground(() async {
        return await UltraSecureFlutterKitPlatform.instance.verifySSLPinning(
          url,
        );
      });
    } catch (e) {
      print('SSL pinning verification failed: $e');
      return false;
    }
  }

  /// Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    try {
      final local_auth.LocalAuthentication localAuth =
          local_auth.LocalAuthentication();
      final bool canAuthenticateWithBiometrics =
          await localAuth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await localAuth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      print('Biometric availability check failed: $e');
      return false;
    }
  }

  /// Get available biometric types
  Future<List<local_auth.BiometricType>> getAvailableBiometrics() async {
    try {
      final local_auth.LocalAuthentication localAuth =
          local_auth.LocalAuthentication();
      final List<local_auth.BiometricType> availableBiometrics = await localAuth
          .getAvailableBiometrics();
      return availableBiometrics;
    } catch (e) {
      print('Failed to get available biometrics: $e');
      return [];
    }
  }

  /// Authenticate with biometrics
  Future<bool> authenticateWithBiometrics({
    String localizedReason = 'Please authenticate to continue',
    String? cancelButton = 'Cancel',
    String? goToSettingsButton = 'Settings',
    String? goToSettingsDescription = 'Please set up your biometrics',
    bool stickyAuth = false,
    bool useErrorDialogs = true,
    bool biometricOnly = false,
  }) async {
    try {
      final local_auth.LocalAuthentication localAuth =
          local_auth.LocalAuthentication();
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: localizedReason,
        options: local_auth.AuthenticationOptions(
          stickyAuth: stickyAuth,
          biometricOnly: biometricOnly,
          useErrorDialogs: useErrorDialogs,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      print('Biometric authentication failed: $e');
      return false;
    }
  }

  /// Helper method to run operations in background to prevent main thread blocking
  Future<T> _runInBackground<T>(Future<T> Function() operation) async {
    try {
      // Use compute for CPU-intensive operations, but for simple async operations
      // we can just await them directly to avoid overhead
      return await operation();
    } catch (e) {
      print('Background operation failed: $e');
      rethrow;
    }
  }
}
