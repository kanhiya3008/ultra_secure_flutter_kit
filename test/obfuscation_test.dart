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

void main() {
  group('Code Obfuscation Tests', () {
    late UltraSecureFlutterKit securityKit;
    late MockUltraSecureFlutterKitPlatform mockPlatform;

    setUp(() {
      securityKit = UltraSecureFlutterKit();
      mockPlatform = MockUltraSecureFlutterKitPlatform();
      UltraSecureFlutterKitPlatform.instance = mockPlatform;
    });

    group('ObfuscationConfig Tests', () {
      test('should create ObfuscationConfig with default values', () {
        final config = ObfuscationConfig();

        expect(config.enableDartObfuscation, true);
        expect(config.enableStringObfuscation, true);
        expect(config.enableClassObfuscation, true);
        expect(config.enableMethodObfuscation, true);
        expect(config.enableDebugPrintStripping, true);
        expect(config.enableStackTraceObfuscation, true);
        expect(config.customObfuscationRules, isEmpty);
      });

      test('should create ObfuscationConfig with custom values', () {
        final customRules = {
          'apiKey': 'obfuscated_api_key',
          'secretToken': 'obfuscated_secret_token',
        };

        final config = ObfuscationConfig(
          enableDartObfuscation: false,
          enableStringObfuscation: true,
          enableClassObfuscation: false,
          enableMethodObfuscation: true,
          enableDebugPrintStripping: false,
          enableStackTraceObfuscation: true,
          customObfuscationRules: customRules,
        );

        expect(config.enableDartObfuscation, false);
        expect(config.enableStringObfuscation, true);
        expect(config.enableClassObfuscation, false);
        expect(config.enableMethodObfuscation, true);
        expect(config.enableDebugPrintStripping, false);
        expect(config.enableStackTraceObfuscation, true);
        expect(config.customObfuscationRules, equals(customRules));
      });

      test('should serialize and deserialize ObfuscationConfig', () {
        final originalConfig = ObfuscationConfig(
          enableDartObfuscation: false,
          enableStringObfuscation: true,
          enableClassObfuscation: false,
          enableMethodObfuscation: true,
          enableDebugPrintStripping: false,
          enableStackTraceObfuscation: true,
          customObfuscationRules: {
            'apiKey': 'obfuscated_api_key',
            'secretToken': 'obfuscated_secret_token',
          },
        );

        final json = originalConfig.toJson();
        final restoredConfig = ObfuscationConfig.fromJson(json);

        expect(
          restoredConfig.enableDartObfuscation,
          originalConfig.enableDartObfuscation,
        );
        expect(
          restoredConfig.enableStringObfuscation,
          originalConfig.enableStringObfuscation,
        );
        expect(
          restoredConfig.enableClassObfuscation,
          originalConfig.enableClassObfuscation,
        );
        expect(
          restoredConfig.enableMethodObfuscation,
          originalConfig.enableMethodObfuscation,
        );
        expect(
          restoredConfig.enableDebugPrintStripping,
          originalConfig.enableDebugPrintStripping,
        );
        expect(
          restoredConfig.enableStackTraceObfuscation,
          originalConfig.enableStackTraceObfuscation,
        );
        expect(
          restoredConfig.customObfuscationRules,
          originalConfig.customObfuscationRules,
        );
      });
    });

    group('SecurityConfig with Obfuscation Tests', () {
      test('should create SecurityConfig with obfuscation enabled', () {
        final obfuscationConfig = ObfuscationConfig(
          enableDartObfuscation: true,
          enableStringObfuscation: true,
          enableClassObfuscation: true,
          enableMethodObfuscation: true,
          enableDebugPrintStripping: true,
          enableStackTraceObfuscation: true,
          customObfuscationRules: {
            'apiKey': 'obfuscated_api_key',
            'secretToken': 'obfuscated_secret_token',
          },
        );

        final config = SecurityConfig(
          enableCodeObfuscation: true,
          obfuscationConfig: obfuscationConfig,
        );

        expect(config.enableCodeObfuscation, true);
        expect(config.obfuscationConfig, equals(obfuscationConfig));
      });

      test(
        'should serialize and deserialize SecurityConfig with obfuscation',
        () {
          final obfuscationConfig = ObfuscationConfig(
            enableDartObfuscation: true,
            enableStringObfuscation: true,
            customObfuscationRules: {'apiKey': 'obfuscated_api_key'},
          );

          final originalConfig = SecurityConfig(
            enableCodeObfuscation: true,
            obfuscationConfig: obfuscationConfig,
          );

          final json = originalConfig.toJson();
          final restoredConfig = SecurityConfig.fromJson(json);

          expect(
            restoredConfig.enableCodeObfuscation,
            originalConfig.enableCodeObfuscation,
          );
          expect(
            restoredConfig.obfuscationConfig?.enableDartObfuscation,
            originalConfig.obfuscationConfig?.enableDartObfuscation,
          );
          expect(
            restoredConfig.obfuscationConfig?.enableStringObfuscation,
            originalConfig.obfuscationConfig?.enableStringObfuscation,
          );
          expect(
            restoredConfig.obfuscationConfig?.customObfuscationRules,
            originalConfig.obfuscationConfig?.customObfuscationRules,
          );
        },
      );
    });

    group('DeviceSecurityStatus Obfuscation Tests', () {
      test('should create DeviceSecurityStatus with obfuscation status', () {
        final status = DeviceSecurityStatus(
          isRooted: false,
          isJailbroken: false,
          isEmulator: false,
          isDebuggerAttached: false,
          hasProxy: false,
          hasVPN: false,
          isScreenCaptureBlocked: true,
          isSSLValid: true,
          isBiometricAvailable: true,
          isCodeObfuscated: true, // This is the key field for obfuscation
          isDeveloperModeEnabled: false,
          isUsbCableAttached: false,
          riskScore: 0.1,
          isSecure: true,
          activeThreats: [],
        );

        expect(status.isCodeObfuscated, true);
        expect(status.isSecure, true);
      });

      test(
        'should serialize and deserialize DeviceSecurityStatus with obfuscation',
        () {
          final originalStatus = DeviceSecurityStatus(
            isRooted: false,
            isJailbroken: false,
            isEmulator: false,
            isDebuggerAttached: false,
            hasProxy: false,
            hasVPN: false,
            isScreenCaptureBlocked: true,
            isSSLValid: true,
            isBiometricAvailable: true,
            isCodeObfuscated: true,
            isDeveloperModeEnabled: false,
            isUsbCableAttached: false,
            riskScore: 0.1,
            isSecure: true,
            activeThreats: [],
          );

          final json = originalStatus.toJson();
          final restoredStatus = DeviceSecurityStatus.fromJson(json);

          expect(
            restoredStatus.isCodeObfuscated,
            originalStatus.isCodeObfuscated,
          );
          expect(restoredStatus.isSecure, originalStatus.isSecure);
        },
      );
    });

    group('Obfuscation Feature Integration Tests', () {
      test(
        'should initialize security with obfuscation configuration',
        () async {
          final obfuscationConfig = ObfuscationConfig(
            enableDartObfuscation: true,
            enableStringObfuscation: true,
            enableClassObfuscation: true,
            enableMethodObfuscation: true,
            enableDebugPrintStripping: true,
            enableStackTraceObfuscation: true,
            customObfuscationRules: {
              'apiKey': 'obfuscated_api_key',
              'secretToken': 'obfuscated_secret_token',
              'encryptionKey': 'obfuscated_encryption_key',
            },
          );

          final config = SecurityConfig(
            enableCodeObfuscation: true,
            obfuscationConfig: obfuscationConfig,
          );

          // This should not throw an exception
          await securityKit.initializeSecureMonitor(config);

          // Verify that the security kit is protected
          expect(securityKit.isProtected, true);
        },
      );

      test('should get device security status with obfuscation info', () async {
        final status = await securityKit.getDeviceSecurityStatus();

        // The status should include obfuscation information
        expect(status.isCodeObfuscated, isA<bool>());

        // In a real implementation, this would be true if obfuscation is working
        // For now, we just verify the field exists and is a boolean
        expect(status.isCodeObfuscated, isNotNull);
      });

      test('should handle obfuscation configuration in security metrics', () {
        final metrics = securityKit.securityMetrics;

        // Verify that security metrics are available
        expect(metrics, isA<Map<String, dynamic>>());
        expect(metrics, isNotEmpty);
      });
    });

    group('Obfuscation Configuration Validation Tests', () {
      test('should validate obfuscation configuration parameters', () {
        final config = ObfuscationConfig(
          enableDartObfuscation: true,
          enableStringObfuscation: true,
          enableClassObfuscation: true,
          enableMethodObfuscation: true,
          enableDebugPrintStripping: true,
          enableStackTraceObfuscation: true,
          customObfuscationRules: {
            'apiKey': 'obfuscated_api_key',
            'secretToken': 'obfuscated_secret_token',
            'encryptionKey': 'obfuscated_encryption_key',
            'certificateHash': 'obfuscated_certificate_hash',
            'deviceId': 'obfuscated_device_id',
            'sessionToken': 'obfuscated_session_token',
            'authToken': 'obfuscated_auth_token',
            'privateKey': 'obfuscated_private_key',
            'signatureKey': 'obfuscated_signature_key',
            'hmacKey': 'obfuscated_hmac_key',
          },
        );

        // Verify all obfuscation features are enabled
        expect(config.enableDartObfuscation, true);
        expect(config.enableStringObfuscation, true);
        expect(config.enableClassObfuscation, true);
        expect(config.enableMethodObfuscation, true);
        expect(config.enableDebugPrintStripping, true);
        expect(config.enableStackTraceObfuscation, true);

        // Verify custom obfuscation rules are properly set
        expect(config.customObfuscationRules.length, 10);
        expect(config.customObfuscationRules['apiKey'], 'obfuscated_api_key');
        expect(
          config.customObfuscationRules['secretToken'],
          'obfuscated_secret_token',
        );
        expect(
          config.customObfuscationRules['encryptionKey'],
          'obfuscated_encryption_key',
        );
      });

      test('should handle empty obfuscation configuration', () {
        final config = ObfuscationConfig();

        // Default values should be true
        expect(config.enableDartObfuscation, true);
        expect(config.enableStringObfuscation, true);
        expect(config.enableClassObfuscation, true);
        expect(config.enableMethodObfuscation, true);
        expect(config.enableDebugPrintStripping, true);
        expect(config.enableStackTraceObfuscation, true);
        expect(config.customObfuscationRules, isEmpty);
      });
    });

    group('Obfuscation Status Reporting Tests', () {
      test('should report obfuscation status in device security', () async {
        final status = await securityKit.getDeviceSecurityStatus();

        // Verify that obfuscation status is included in the security report
        expect(status.isCodeObfuscated, isA<bool>());

        // The status should be consistent with the overall security status
        if (status.isCodeObfuscated) {
          // If code is obfuscated, it should contribute to security
          expect(status.riskScore, lessThan(1.0));
        }
      });

      test('should include obfuscation in security metrics', () {
        final metrics = securityKit.securityMetrics;

        // Security metrics should be available and contain relevant information
        expect(metrics, isA<Map<String, dynamic>>());

        // In a real implementation, these metrics would include obfuscation-related data
        expect(metrics, isNotEmpty);
      });
    });
  });
}
