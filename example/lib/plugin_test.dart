import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';
import 'package:ultra_secure_flutter_kit_example/platform_examples/platform_examples_main.dart';

class PluginTest extends StatefulWidget {
  const PluginTest({super.key});

  @override
  State<PluginTest> createState() => _PluginTestState();
}

class _PluginTestState extends State<PluginTest> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  String _testResults = '';

  @override
  void initState() {
    super.initState();
    _testPluginMethods();
  }

  Future<void> _testPluginMethods() async {
    final results = <String>[];

    try {
      // Test 1: Platform version
      final version = await _securityKit.getPlatformVersion();
      results.add('✅ Platform version: $version');
    } catch (e) {
      results.add('❌ Platform version failed: $e');
    }

    try {
      // Test 2: Root detection
      final isRooted = await _securityKit.isRooted();
      results.add('✅ Root detection: $isRooted');
    } catch (e) {
      results.add('❌ Root detection failed: $e');
    }

    try {
      // Test 3: Emulator detection
      final isEmulator = await _securityKit.isEmulator();
      results.add('✅ Emulator detection: $isEmulator');
    } catch (e) {
      results.add('❌ Emulator detection failed: $e');
    }

    try {
      // Test 4: Debugger detection
      final isDebuggerAttached = await _securityKit.isDebuggerAttached();
      results.add('✅ Debugger detection: $isDebuggerAttached');
    } catch (e) {
      results.add('❌ Debugger detection failed: $e');
    }

    try {
      // Test 5: Screenshot blocking
      await _securityKit.enableScreenCaptureProtection();
      final isBlocked = await _securityKit.isScreenCaptureBlocked();
      results.add('✅ Screenshot blocking: $isBlocked');
    } catch (e) {
      results.add('❌ Screenshot blocking failed: $e');
    }

    try {
      // Test 6: App signature
      final signature = await _securityKit.getAppSignature();
      results.add(
        '✅ App signature: ${signature.isNotEmpty ? "Retrieved" : "Empty"}',
      );
    } catch (e) {
      results.add('❌ App signature failed: $e');
    }

    try {
      // Test 7: Device fingerprint
      final fingerprint = await _securityKit.getDeviceFingerprint();
      results.add(
        '✅ Device fingerprint: ${fingerprint.isNotEmpty ? "Retrieved" : "Empty"}',
      );
    } catch (e) {
      results.add('❌ Device fingerprint failed: $e');
    }

    try {
      // Test 8: USB cable detection
      final isUsbAttached = await _securityKit.isUsbCableAttached();
      results.add('✅ USB cable detection: $isUsbAttached');
    } catch (e) {
      results.add('❌ USB cable detection failed: $e');
    }

    try {
      // Test 9: USB connection status
      final usbStatus = await _securityKit.getUsbConnectionStatus();
      results.add('✅ USB connection status: ${usbStatus['connectionType'] ?? 'unknown'}');
      results.add('   📊 Details:');
      results.add('   • Is Attached: ${usbStatus['isAttached'] ?? false}');
      results.add('   • Is Charging: ${usbStatus['isCharging'] ?? false}');
      results.add('   • USB Charging: ${usbStatus['isUsbCharging'] ?? false}');
      results.add('   • Data Transfer: ${usbStatus['isDataTransfer'] ?? false}');
      results.add('   • Connected to Computer: ${usbStatus['isConnectedToComputer'] ?? false}');
      results.add('   • Connected via USB: ${usbStatus['isConnectedViaUsb'] ?? false}');
      results.add('   • Power Source: ${usbStatus['powerSource'] ?? 'unknown'}');
      results.add('   • Device Count: ${usbStatus['deviceCount'] ?? 0}');
      if (usbStatus['timestamp'] != null) {
        results.add('   • Timestamp: ${DateTime.fromMillisecondsSinceEpoch(usbStatus['timestamp'] as int)}');
      }
      if (usbStatus['error'] != null) {
        results.add('   • Error: ${usbStatus['error']}');
      }
    } catch (e) {
      results.add('❌ USB connection status failed: $e');
    }

    setState(() {
      _testResults = results.join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Test Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.security),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlatformExamplesMain(),
                ),
              );
            },
            tooltip: 'Platform Security Examples',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plugin Method Test Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _testResults.isEmpty ? 'Running tests...' : _testResults,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _testPluginMethods,
              child: const Text('Run Tests Again'),
            ),
          ],
        ),
      ),
    );
  }
}
