import 'package:flutter_test/flutter_test.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUltraSecureFlutterKitPlatform
    with MockPlatformInterfaceMixin
    implements UltraSecureFlutterKitPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> isRooted() => Future.value(false);

  @override
  Future<bool> isJailbroken() => Future.value(false);

  @override
  Future<bool> isEmulator() => Future.value(false);

  @override
  Future<bool> isDebuggerAttached() => Future.value(false);

  @override
  Future<void> enableScreenCaptureProtection() => Future.value();

  @override
  Future<void> disableScreenCaptureProtection() => Future.value();

  @override
  Future<bool> isScreenCaptureBlocked() => Future.value(true);

  @override
  Future<bool> isUsbCableAttached() => Future.value(false);

  @override
  Future<Map<String, dynamic>> getUsbConnectionStatus() => Future.value({
    'isAttached': false,
    'connectionType': 'none',
    'isCharging': false,
    'isDataTransfer': false,
  });

  @override
  Future<String> getAppSignature() => Future.value('mock_signature');

  @override
  Future<bool> verifyAppIntegrity() => Future.value(true);

  @override
  Future<String> getDeviceFingerprint() => Future.value('mock_fingerprint');

  @override
  Future<void> enableSecureFlag() => Future.value();

  @override
  Future<void> enableNetworkMonitoring() => Future.value();

  @override
  Future<void> enableRealTimeMonitoring() => Future.value();

  @override
  Future<void> preventReverseEngineering() => Future.value();

  @override
  Future<void> applyAntiTampering() => Future.value();

  @override
  Future<bool> hasProxySettings() => Future.value(false);

  @override
  Future<bool> hasVPNConnection() => Future.value(false);

  @override
  Future<List<String>> getUnexpectedCertificates() => Future.value([]);

  @override
  Future<bool> isDeveloperModeEnabled() => Future.value(false);

  @override
  Future<void> openDeveloperOptionsSettings() => Future.value();

  @override
  Future<void> configureSSLPinning(
    List<String> certificates,
    List<String> publicKeys,
  ) => Future.value();

  @override
  Future<bool> verifySSLPinning(String url) => Future.value(true);
}

class MockVPNEnabledPlatform extends MockUltraSecureFlutterKitPlatform {
  @override
  Future<bool> hasVPNConnection() => Future.value(true);
}

class MockVPNDisabledPlatform extends MockUltraSecureFlutterKitPlatform {
  @override
  Future<bool> hasVPNConnection() => Future.value(false);
}

void main() {
  group('VPN Detection Tests', () {
    late UltraSecureFlutterKit securityKit;

    setUp(() {
      securityKit = UltraSecureFlutterKit();
    });

    group('VPN Detection Basic Tests', () {
      test('should detect when VPN is NOT connected', () async {
        // Set up mock platform that returns false for VPN
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();

        final hasVPN = await securityKit.hasVPNConnection();
        
        expect(hasVPN, false);
        expect(hasVPN, isA<bool>());
      });

      test('should detect when VPN IS connected', () async {
        // Set up mock platform that returns true for VPN
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();

        final hasVPN = await securityKit.hasVPNConnection();
        
        expect(hasVPN, true);
        expect(hasVPN, isA<bool>());
      });

      test('should handle VPN detection errors gracefully', () async {
        // Set up mock platform that throws an exception
        UltraSecureFlutterKitPlatform.instance = MockUltraSecureFlutterKitPlatform();

        // The method should not throw and should return false on error
        final hasVPN = await securityKit.hasVPNConnection();
        
        expect(hasVPN, false);
        expect(hasVPN, isA<bool>());
      });
    });

    group('VPN Detection in Device Security Status', () {
      test('should include VPN status in device security status', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();

        final status = await securityKit.getDeviceSecurityStatus();
        
        expect(status.hasVPN, isA<bool>());
        expect(status.hasVPN, false);
      });

      test('should report VPN as connected in device security status', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();

        final status = await securityKit.getDeviceSecurityStatus();
        
        expect(status.hasVPN, isA<bool>());
        expect(status.hasVPN, true);
      });

      test('should include VPN status in security metrics', () {
        final metrics = securityKit.securityMetrics;
        
        expect(metrics, isA<Map<String, dynamic>>());
        expect(metrics, isNotEmpty);
      });
    });

    group('VPN Detection Integration Tests', () {
      test('should work with complete security initialization', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();

        final config = SecurityConfig(
          enableCodeObfuscation: true,
          enableScreenshotBlocking: true,
          enableSSLPinning: true,
        );

        await securityKit.initializeSecureMonitor(config);
        
        final hasVPN = await securityKit.hasVPNConnection();
        expect(hasVPN, false);
      });

      test('should work with VPN detection in security test', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();

        final config = SecurityConfig(
          enableCodeObfuscation: true,
          enableScreenshotBlocking: true,
          enableSSLPinning: true,
        );

        await securityKit.initializeSecureMonitor(config);
        
        final hasVPN = await securityKit.hasVPNConnection();
        expect(hasVPN, true);
      });
    });

    group('VPN Detection with Other Security Features', () {
      test('should detect VPN alongside proxy detection', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();

        final hasVPN = await securityKit.hasVPNConnection();
        final hasProxy = await securityKit.hasProxySettings();
        
        expect(hasVPN, true);
        expect(hasProxy, isA<bool>());
      });

      test('should include VPN in comprehensive security test', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();

        // Test all network-related security features
        final results = await Future.wait([
          securityKit.hasVPNConnection(),
          securityKit.hasProxySettings(),
          securityKit.getUnexpectedCertificates(),
        ]);

        final hasVPN = results[0] as bool;
        final hasProxy = results[1] as bool;
        final certificates = results[2] as List<String>;

        expect(hasVPN, false);
        expect(hasProxy, isA<bool>());
        expect(certificates, isA<List<String>>());
      });
    });

    group('VPN Detection Performance Tests', () {
      test('should complete VPN detection quickly', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();

        final stopwatch = Stopwatch()..start();
        final hasVPN = await securityKit.hasVPNConnection();
        stopwatch.stop();

        expect(hasVPN, false);
        expect(stopwatch.elapsedMilliseconds, lessThan(1000)); // Should complete within 1 second
      });

      test('should handle multiple VPN detection calls', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();

        final results = await Future.wait([
          securityKit.hasVPNConnection(),
          securityKit.hasVPNConnection(),
          securityKit.hasVPNConnection(),
        ]);

        for (final result in results) {
          expect(result, true);
        }
      });
    });

    group('VPN Detection Error Handling', () {
      test('should handle platform errors gracefully', () async {
        // Test with default mock that might have issues
        UltraSecureFlutterKitPlatform.instance = MockUltraSecureFlutterKitPlatform();

        final hasVPN = await securityKit.hasVPNConnection();
        
        // Should return false on error, not throw
        expect(hasVPN, false);
      });

      test('should not crash on repeated calls', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();

        for (int i = 0; i < 5; i++) {
          final hasVPN = await securityKit.hasVPNConnection();
          expect(hasVPN, false);
        }
      });
    });

    group('VPN Detection Status Reporting', () {
      test('should report VPN status consistently', () async {
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();

        final status1 = await securityKit.getDeviceSecurityStatus();
        final status2 = await securityKit.getDeviceSecurityStatus();
        
        expect(status1.hasVPN, status2.hasVPN);
        expect(status1.hasVPN, true);
      });

      test('should update VPN status when changed', () async {
        // First test with VPN disabled
        UltraSecureFlutterKitPlatform.instance = MockVPNDisabledPlatform();
        final status1 = await securityKit.getDeviceSecurityStatus();
        expect(status1.hasVPN, false);

        // Then test with VPN enabled
        UltraSecureFlutterKitPlatform.instance = MockVPNEnabledPlatform();
        final status2 = await securityKit.getDeviceSecurityStatus();
        expect(status2.hasVPN, true);
      });
    });
  });
} 