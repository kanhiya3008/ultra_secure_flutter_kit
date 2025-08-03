import 'package:flutter_test/flutter_test.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit_platform_interface.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit_method_channel.dart';
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
  Future<bool> isScreenCaptureBlocked() => Future.value(false);

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
}

void main() {
  final UltraSecureFlutterKitPlatform initialPlatform =
      UltraSecureFlutterKitPlatform.instance;

  test('$MethodChannelUltraSecureFlutterKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUltraSecureFlutterKit>());
  });

  test('getPlatformVersion', () async {
    UltraSecureFlutterKit ultraSecureFlutterKitPlugin = UltraSecureFlutterKit();
    MockUltraSecureFlutterKitPlatform fakePlatform =
        MockUltraSecureFlutterKitPlatform();
    UltraSecureFlutterKitPlatform.instance = fakePlatform;

    expect(await ultraSecureFlutterKitPlugin.getPlatformVersion(), '42');
  });
}
