import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

class ObfuscationTestExample extends StatefulWidget {
  const ObfuscationTestExample({super.key});

  @override
  State<ObfuscationTestExample> createState() => _ObfuscationTestExampleState();
}

class _ObfuscationTestExampleState extends State<ObfuscationTestExample> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  String _testResults = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeSecurityKit();
  }

  Future<void> _initializeSecurityKit() async {
    try {
      // Configure security with obfuscation settings
      final obfuscationConfig = ObfuscationConfig(
        enableDartObfuscation: true,
        enableStringObfuscation: true,
        enableClassObfuscation: true,
        enableMethodObfuscation: true,
        enableDebugPrintStripping: true,
        enableStackTraceObfuscation: true,
        customObfuscationRules: {
          'apiKey': 'obfuscated_api_key_12345',
          'secretToken': 'obfuscated_secret_token_67890',
          'databaseUrl': 'obfuscated_db_url_abcdef',
        },
      );

      final securityConfig = SecurityConfig(
        enableCodeObfuscation: true,
        obfuscationConfig: obfuscationConfig,
      );

      await _securityKit.initializeSecureMonitor(securityConfig);
      _addResult('✅ Security kit configured with obfuscation settings');
    } catch (e) {
      _addResult('❌ Failed to configure security kit: $e');
    }
  }

  void _addResult(String result) {
    setState(() {
      _testResults += '$result\n';
    });
  }

  Future<void> _testObfuscationConfig() async {
    setState(() {
      _isLoading = true;
      _testResults = '';
    });

    try {
      _addResult('🧪 Testing Obfuscation Configuration...\n');

      // Test 1: Create ObfuscationConfig
      final obfuscationConfig = ObfuscationConfig(
        enableDartObfuscation: true,
        enableStringObfuscation: true,
        enableClassObfuscation: true,
        enableMethodObfuscation: true,
        enableDebugPrintStripping: true,
        enableStackTraceObfuscation: true,
        customObfuscationRules: {
          'apiKey': 'obfuscated_api_key_12345',
          'secretToken': 'obfuscated_secret_token_67890',
        },
      );

      _addResult('✅ ObfuscationConfig created successfully');
      _addResult(
        '   - Dart Obfuscation: ${obfuscationConfig.enableDartObfuscation}',
      );
      _addResult(
        '   - String Obfuscation: ${obfuscationConfig.enableStringObfuscation}',
      );
      _addResult(
        '   - Class Obfuscation: ${obfuscationConfig.enableClassObfuscation}',
      );
      _addResult(
        '   - Method Obfuscation: ${obfuscationConfig.enableMethodObfuscation}',
      );
      _addResult(
        '   - Debug Print Stripping: ${obfuscationConfig.enableDebugPrintStripping}',
      );
      _addResult(
        '   - Stack Trace Obfuscation: ${obfuscationConfig.enableStackTraceObfuscation}',
      );
      _addResult(
        '   - Custom Rules Count: ${obfuscationConfig.customObfuscationRules.length}',
      );

      // Test 2: Serialization/Deserialization
      final json = obfuscationConfig.toJson();
      final restoredConfig = ObfuscationConfig.fromJson(json);

      if (obfuscationConfig.enableDartObfuscation ==
          restoredConfig.enableDartObfuscation) {
        _addResult('✅ Serialization/Deserialization test passed');
      } else {
        _addResult('❌ Serialization/Deserialization test failed');
      }

      // Test 3: SecurityConfig with Obfuscation
      final securityConfig = SecurityConfig(
        enableCodeObfuscation: true,
        obfuscationConfig: obfuscationConfig,
      );

      _addResult('✅ SecurityConfig with obfuscation created');
      _addResult(
        '   - Code Obfuscation Enabled: ${securityConfig.enableCodeObfuscation}',
      );
    } catch (e) {
      _addResult('❌ Obfuscation config test failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testAntiReverseEngineering() async {
    setState(() {
      _isLoading = true;
      _testResults = '';
    });

    try {
      _addResult('🛡️ Testing Anti-Reverse Engineering Detection...\n');

      // Test 1: Basic anti-reverse engineering
      await _securityKit.preventReverseEngineering();
      _addResult('✅ Anti-reverse engineering check completed');

      // Test 2: Anti-tampering
      await _securityKit.applyAntiTampering();
      _addResult('✅ Anti-tampering check completed');

      // Test 3: App integrity verification
      final isIntegrityVerified = await _securityKit.verifyAppIntegrity();
      _addResult('✅ App integrity verification: $isIntegrityVerified');

      // Test 4: Debugger detection
      final isDebuggerAttached = await _securityKit.isDebuggerAttached();
      _addResult('✅ Debugger detection: $isDebuggerAttached');

      // Test 5: Root/Jailbreak detection
      final isRooted = await _securityKit.isRooted();
      final isJailbroken = await _securityKit.isJailbroken();
      _addResult('✅ Root detection: $isRooted');
      _addResult('✅ Jailbreak detection: $isJailbroken');

      // Test 6: Emulator detection
      final isEmulator = await _securityKit.isEmulator();
      _addResult('✅ Emulator detection: $isEmulator');
    } catch (e) {
      _addResult('❌ Anti-reverse engineering test failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testStringObfuscation() async {
    setState(() {
      _isLoading = true;
      _testResults = '';
    });

    try {
      _addResult('🔐 Testing String Obfuscation...\n');

      // These strings should be obfuscated in release builds
      final sensitiveStrings = [
        'api_key_123456789',
        'secret_token_abcdef',
        'database_password_xyz',
        'encryption_key_789',
      ];

      _addResult('📝 Sensitive strings in code:');
      for (final string in sensitiveStrings) {
        _addResult('   - $string');
      }

      _addResult('\n⚠️  Note: In release builds with obfuscation,');
      _addResult('   these strings should be obfuscated in the binary.');
      _addResult('   Check the APK/IPA file to verify obfuscation.');

      // Test custom obfuscation rules
      final obfuscationConfig = ObfuscationConfig(
        customObfuscationRules: {
          'api_key_123456789': 'OBFUSCATED_API_KEY',
          'secret_token_abcdef': 'OBFUSCATED_SECRET_TOKEN',
        },
      );

      _addResult('\n✅ Custom obfuscation rules configured');
      _addResult(
        '   - Rules count: ${obfuscationConfig.customObfuscationRules.length}',
      );
    } catch (e) {
      _addResult('❌ String obfuscation test failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testBuildVerification() async {
    setState(() {
      _isLoading = true;
      _testResults = '';
    });

    try {
      _addResult('🔍 Testing Build Verification...\n');

      // Test 1: App signature
      final appSignature = await _securityKit.getAppSignature();
      _addResult(
        '✅ App signature retrieved: ${appSignature.isNotEmpty ? "Valid" : "Empty"}',
      );

      // Test 2: Device fingerprint
      final deviceFingerprint = await _securityKit.getDeviceFingerprint();
      _addResult(
        '✅ Device fingerprint: ${deviceFingerprint.isNotEmpty ? "Generated" : "Empty"}',
      );

      // Test 3: Platform version
      final platformVersion = await _securityKit.getPlatformVersion();
      _addResult('✅ Platform version: $platformVersion');

      _addResult('\n📋 Build Verification Checklist:');
      _addResult('   □ Build with --obfuscate flag');
      _addResult('   □ Use --release mode');
      _addResult('   □ Check debug info files');
      _addResult('   □ Verify APK/IPA obfuscation');
      _addResult('   □ Test on real devices');
    } catch (e) {
      _addResult('❌ Build verification test failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Obfuscation Testing'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Test Buttons
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🧪 Test Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: _isLoading ? null : _testObfuscationConfig,
                          child: const Text('Config Test'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : _testAntiReverseEngineering,
                          child: const Text('Anti-RE Test'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _testStringObfuscation,
                          child: const Text('String Obfuscation'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _testBuildVerification,
                          child: const Text('Build Verification'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Results Display
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '📊 Test Results',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (_isLoading)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              _testResults.isEmpty
                                  ? 'Run a test to see results...'
                                  : _testResults,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Information Panel
            const SizedBox(height: 16),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ℹ️  Important Notes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• This plugin provides configuration support for obfuscation\n'
                      '• Actual obfuscation requires Flutter build flags\n'
                      '• Test on release builds with --obfuscate flag\n'
                      '• Check APK/IPA files to verify obfuscation\n'
                      '• Anti-reverse engineering detection is working',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
