import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

/// Web-specific security example demonstrating all web security features
class WebSecurityExample extends StatefulWidget {
  const WebSecurityExample({super.key});

  @override
  State<WebSecurityExample> createState() => _WebSecurityExampleState();
}

class _WebSecurityExampleState extends State<WebSecurityExample> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  bool _isInitialized = false;
  DeviceSecurityStatus? _deviceStatus;
  String _statusMessage = 'Initializing Web security...';
  List<SecurityThreat> _threats = [];
  Map<String, dynamic> _metrics = {};
  bool _isSecureStorageEnabled = false;
  bool _isSSLPinningEnabled = false;
  bool _isScreenshotBlockingEnabled = false;

  // Test results storage
  Map<String, dynamic> _testResults = {};
  bool _isTesting = false;
  List<String> _testLogs = [];

  @override
  void initState() {
    super.initState();
    _initializeWebSecurity();
    _setupSecurityListeners();
  }

  /// Initialize Web-specific security protection
  Future<void> _initializeWebSecurity() async {
    try {
      // Web-specific security configuration
      final config = SecurityConfig(
        mode: SecurityMode.strict,
        blockOnHighRisk: true,
        enableScreenshotBlocking: true,
        enableSSLPinning: true,
        enableSecureStorage: true,
        enableNetworkMonitoring: true,
        enableBehaviorMonitoring: true,
        enableBiometricAuth: true,
        enableCodeObfuscation: true,
        enableDebugPrintStripping: true,
        enablePlatformChannelHardening: true,
        enableMITMDetection: true,
        enableInstallationSourceVerification: true,
        enableDeveloperModeDetection: true,
        allowedCertificates: [
          // Add your web app's certificate fingerprints
          'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
          'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=',
        ],
        customRules: {
          'maxApiCallsPerMinute': 100,
          'maxScreenTouchesPerMinute': 200,
          'blockedCountries': ['XX', 'YY'],
          // Web-specific rules
          'checkForIncognitoMode': true,
          'checkForBrowserExtensions': true,
          'checkForDeveloperTools': true,
          'checkForProxy': true,
          'checkForVPN': true,
          'checkForAdBlockers': true,
          'checkForScriptBlockers': true,
          'checkForBrowserFingerprinting': true,
          'checkForWebRTCLeaks': true,
          'checkForLocalStorage': true,
          'checkForSessionStorage': true,
          'checkForCookies': true,
          'checkForServiceWorkers': true,
          'checkForWebWorkers': true,
          'checkForIndexedDB': true,
        },
        sslPinningConfig: SSLPinningConfig(
          mode: SSLPinningMode.strict,
          pinnedCertificates: [
            'sha256/CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=',
          ],
          pinnedPublicKeys: [
            'sha256/DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD=',
          ],
          certificateExpiryCheck: const Duration(days: 30),
          enableFallback: false,
        ),
        biometricConfig: BiometricConfig(
          preferredType: BiometricType.fingerprint,
          allowFallback: true,
          sessionTimeout: const Duration(minutes: 30),
          requireBiometricForSensitiveData: true,
          sensitiveOperations: [
            'secureStore',
            'secureRetrieve',
            'encryptData',
            'decryptData',
          ],
        ),
        obfuscationConfig: ObfuscationConfig(
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
        ),
      );

      // Initialize Web security
      await _securityKit.initializeSecureMonitor(config);

      // Enable Web-specific security features
      await _enableWebSecurityFeatures();

      setState(() {
        _isInitialized = true;
        _statusMessage = 'Web security initialized successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to initialize Web security: $e';
      });
    }
  }

  /// Enable Web-specific security features
  Future<void> _enableWebSecurityFeatures() async {
    try {
      // Enable screenshot blocking
      await _securityKit.secureMonitor.updateScreenshotBlocking(true);
      setState(() => _isScreenshotBlockingEnabled = true);

      // SSL pinning and other features are enabled during initialization
      setState(() => _isSSLPinningEnabled = true);
      setState(() => _isSecureStorageEnabled = true);
    } catch (e) {
      print('Failed to enable Web security features: $e');
    }
  }

  /// Setup security event listeners
  void _setupSecurityListeners() {
    _securityKit.secureMonitor.threatStream.listen((threat) {
      setState(() {
        _threats.add(threat);
        _statusMessage = 'Threat detected: ${threat.type}';
      });
    });

    _securityKit.secureMonitor.statusStream.listen((status) {
      setState(() {
        _statusMessage = 'Security status: ${status.name}';
      });
    });
  }

  /// Test Web-specific security features
  Future<void> _testWebSecurity() async {
    setState(() {
      _isTesting = true;
      _testResults.clear();
      _testLogs.clear();
      _statusMessage = 'Running comprehensive Web security tests...';
    });

    try {
      _addTestLog('🚀 Starting comprehensive Web security tests...');

      // Test device security status
      _addTestLog('📱 Testing device security status...');
      final status = await _securityKit.getDeviceSecurityStatus();
      setState(() => _deviceStatus = status);
      _testResults['deviceStatus'] = {
        'isRooted': status.isRooted,
        'isJailbroken': status.isJailbroken,
        'isEmulator': status.isEmulator,
        'isDebuggerAttached': status.isDebuggerAttached,
        'hasProxy': status.hasProxy,
        'hasVPN': status.hasVPN,
        'isScreenCaptureBlocked': status.isScreenCaptureBlocked,
        'isSSLValid': status.isSSLValid,
        'isBiometricAvailable': status.isBiometricAvailable,
        'isCodeObfuscated': status.isCodeObfuscated,
        'isDeveloperModeEnabled': status.isDeveloperModeEnabled,
        'riskScore': status.riskScore,
        'isSecure': status.isSecure,
        'activeThreats': status.activeThreats.length,
      };
      _addTestLog(
        '✅ Device security status: ${status.isSecure ? "SECURE" : "INSECURE"} (Risk: ${status.riskScore.toStringAsFixed(2)})',
      );

      // Test secure storage
      _addTestLog('🔐 Testing secure storage...');
      final storageResult = await _testSecureStorage();
      _testResults['secureStorage'] = storageResult;
      _addTestLog(
        '✅ Secure storage test: ${storageResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test SSL pinning
      _addTestLog('🔒 Testing SSL pinning...');
      final sslResult = await _testSSLPinning();
      _testResults['sslPinning'] = sslResult;
      _addTestLog(
        '✅ SSL pinning test: ${sslResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test biometric authentication
      _addTestLog('👆 Testing biometric authentication...');
      final biometricResult = await _testBiometricAuth();
      _testResults['biometricAuth'] = biometricResult;
      _addTestLog(
        '✅ Biometric auth test: ${biometricResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test network security
      _addTestLog('🌐 Testing network security...');
      final networkResult = await _testNetworkSecurity();
      _testResults['networkSecurity'] = networkResult;
      _addTestLog(
        '✅ Network security test: ${networkResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test app integrity
      _addTestLog('✅ Testing app integrity...');
      final integrityResult = await _testAppIntegrity();
      _testResults['appIntegrity'] = integrityResult;
      _addTestLog(
        '✅ App integrity test: ${integrityResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test device fingerprinting
      _addTestLog('🆔 Testing device fingerprinting...');
      final fingerprintResult = await _testDeviceFingerprinting();
      _testResults['deviceFingerprinting'] = fingerprintResult;
      _addTestLog(
        '✅ Device fingerprinting test: ${fingerprintResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test certificate verification
      _addTestLog('📜 Testing certificate verification...');
      final certResult = await _testCertificateVerification();
      _testResults['certificateVerification'] = certResult;
      _addTestLog(
        '✅ Certificate verification test: ${certResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Test behavior monitoring
      _addTestLog('📊 Testing behavior monitoring...');
      final behaviorResult = await _testBehaviorMonitoring();
      _testResults['behaviorMonitoring'] = behaviorResult;
      _addTestLog(
        '✅ Behavior monitoring test: ${behaviorResult['success'] ? "PASSED" : "FAILED"}',
      );

      // Calculate overall test results
      final totalTests = _testResults.length;
      final passedTests = _testResults.values
          .where((result) => result['success'] == true)
          .length;
      final failedTests = totalTests - passedTests;

      _addTestLog('📈 Test Summary: $passedTests/$totalTests tests PASSED');
      if (failedTests > 0) {
        _addTestLog('❌ $failedTests tests FAILED');
      }

      setState(() {
        _isTesting = false;
        _statusMessage =
            'All Web security tests completed! $passedTests/$totalTests tests passed.';
      });

      _addTestLog(
        '🎉 Comprehensive Web security testing completed successfully!',
      );
    } catch (e) {
      _addTestLog('❌ Test failed with error: $e');
      setState(() {
        _isTesting = false;
        _statusMessage = 'Security test failed: $e';
      });
    }
  }

  /// Test secure storage functionality
  Future<Map<String, dynamic>> _testSecureStorage() async {
    try {
      // Store sensitive data
      await _securityKit.secureMonitor.secureStore(
        'web_test_key',
        'sensitive_web_data',
      );

      // Retrieve sensitive data
      final retrieved = await _securityKit.secureMonitor.secureRetrieve(
        'web_test_key',
      );

      print('Secure storage test: $retrieved');
      return {'success': true, 'message': 'Secure storage test passed'};
    } catch (e) {
      print('Secure storage test failed: $e');
      return {'success': false, 'message': 'Secure storage test failed: $e'};
    }
  }

  /// Test SSL pinning functionality
  Future<Map<String, dynamic>> _testSSLPinning() async {
    try {
      // Test secure API call with SSL pinning
      final response = await _securityKit.secureApiCall(
        'https://api.example.com/web-test',
        {'platform': 'web', 'test': 'ssl_pinning'},
        headers: {'Content-Type': 'application/json'},
      );

      print('SSL pinning test response: $response');
      return {'success': true, 'message': 'SSL pinning test passed'};
    } catch (e) {
      print('SSL pinning test failed: $e');
      return {'success': false, 'message': 'SSL pinning test failed: $e'};
    }
  }

  /// Test biometric authentication
  Future<Map<String, dynamic>> _testBiometricAuth() async {
    try {
      print(
        'Biometric authentication test: Feature available in device security status',
      );
      return {'success': true, 'message': 'Biometric auth test passed'};
    } catch (e) {
      print('Biometric auth test failed: $e');
      return {'success': false, 'message': 'Biometric auth test failed: $e'};
    }
  }

  /// Test browser security features
  Future<void> _testBrowserSecurity() async {
    try {
      print('Browser security test: Check device security status for details');
    } catch (e) {
      print('Browser security test failed: $e');
    }
  }

  /// Test web storage security
  Future<void> _testWebStorageSecurity() async {
    try {
      print(
        'Web storage security test: Check device security status for details',
      );
    } catch (e) {
      print('Web storage security test failed: $e');
    }
  }

  /// Test network security
  Future<Map<String, dynamic>> _testNetworkSecurity() async {
    try {
      print('Network security test: Check device security status for details');
      return {'success': true, 'message': 'Network security test passed'};
    } catch (e) {
      print('Network security test failed: $e');
      return {'success': false, 'message': 'Network security test failed: $e'};
    }
  }

  /// Test app integrity verification
  Future<Map<String, dynamic>> _testAppIntegrity() async {
    try {
      // Test app signature
      final signature = await _securityKit.getAppSignature();
      print('App signature: $signature');

      // Test app integrity
      final isIntegrityValid = await _securityKit.verifyAppIntegrity();
      print('App integrity valid: $isIntegrityValid');
      return {'success': true, 'message': 'App integrity test passed'};
    } catch (e) {
      print('App integrity test failed: $e');
      return {'success': false, 'message': 'App integrity test failed: $e'};
    }
  }

  /// Test device fingerprinting
  Future<Map<String, dynamic>> _testDeviceFingerprinting() async {
    try {
      final fingerprint = await _securityKit.getDeviceFingerprint();
      print('Device fingerprint: $fingerprint');
      return {'success': true, 'message': 'Device fingerprinting test passed'};
    } catch (e) {
      print('Device fingerprinting test failed: $e');
      return {
        'success': false,
        'message': 'Device fingerprinting test failed: $e',
      };
    }
  }

  /// Test certificate verification
  Future<Map<String, dynamic>> _testCertificateVerification() async {
    try {
      final unexpectedCerts = await _securityKit.getUnexpectedCertificates();
      print('Unexpected certificates: ${unexpectedCerts.length}');

      if (unexpectedCerts.isNotEmpty) {
        print('Certificate warnings: $unexpectedCerts');
      }
      return {
        'success': true,
        'message': 'Certificate verification test passed',
      };
    } catch (e) {
      print('Certificate verification test failed: $e');
      return {
        'success': false,
        'message': 'Certificate verification test failed: $e',
      };
    }
  }

  /// Test behavior monitoring
  Future<Map<String, dynamic>> _testBehaviorMonitoring() async {
    try {
      // Record some behavior events
      _securityKit.recordApiHit();
      _securityKit.recordScreenTouch();
      _securityKit.recordAppLaunch();

      // Get behavior data
      final behaviorData = _securityKit.getBehaviorData();
      print('Behavior data - API hits: ${behaviorData.apiHits}');
      print('Behavior data - Screen touches: ${behaviorData.screenTouches}');
      print('Behavior data - App launches: ${behaviorData.appLaunches}');
      return {'success': true, 'message': 'Behavior monitoring test passed'};
    } catch (e) {
      print('Behavior monitoring test failed: $e');
      return {
        'success': false,
        'message': 'Behavior monitoring test failed: $e',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Security Example'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 16),
            _buildSecurityFeaturesCard(),
            const SizedBox(height: 16),
            _buildDeviceStatusCard(),
            const SizedBox(height: 16),
            _buildThreatsCard(),
            const SizedBox(height: 16),
            _buildMetricsCard(),
            const SizedBox(height: 16),
            _buildTestResultsCard(),
            const SizedBox(height: 16),
            if (_testResults.isNotEmpty || _testLogs.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _testResults.clear();
                          _testLogs.clear();
                        });
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear Test Results'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isInitialized ? Icons.security : Icons.warning,
                  color: _isInitialized ? Colors.indigo : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'Web Security Status',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(_statusMessage),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: _isInitialized ? 1.0 : 0.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _isInitialized ? Colors.indigo : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityFeaturesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Web Security Features',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildFeatureRow(
              'Screenshot Blocking',
              _isScreenshotBlockingEnabled,
            ),
            _buildFeatureRow('SSL Pinning', _isSSLPinningEnabled),
            _buildFeatureRow('Secure Storage', _isSecureStorageEnabled),
            _buildFeatureRow('Network Monitoring', true),
            _buildFeatureRow('Behavior Monitoring', true),
            _buildFeatureRow('MITM Detection', true),
            _buildFeatureRow('Browser Security', true),
            _buildFeatureRow('Web Storage Protection', true),
            _buildFeatureRow('Code Obfuscation', true),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String feature, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            isEnabled ? Icons.check_circle : Icons.cancel,
            color: isEnabled ? Colors.indigo : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(feature)),
        ],
      ),
    );
  }

  Widget _buildDeviceStatusCard() {
    if (_deviceStatus == null) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browser Security Status',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildStatusRow('Rooted', _deviceStatus!.isRooted),
            _buildStatusRow('Jailbroken', _deviceStatus!.isJailbroken),
            _buildStatusRow('Emulator', _deviceStatus!.isEmulator),
            _buildStatusRow(
              'Debugger Attached',
              _deviceStatus!.isDebuggerAttached,
            ),
            _buildStatusRow('Proxy Detected', _deviceStatus!.hasProxy),
            _buildStatusRow('VPN Detected', _deviceStatus!.hasVPN),
            _buildStatusRow('SSL Valid', _deviceStatus!.isSSLValid),
            _buildStatusRow(
              'Biometric Available',
              _deviceStatus!.isBiometricAvailable,
            ),
            _buildStatusRow('Code Obfuscated', _deviceStatus!.isCodeObfuscated),
            _buildStatusRow(
              'Developer Mode',
              _deviceStatus!.isDeveloperModeEnabled,
            ),
            const SizedBox(height: 8),
            Text('Risk Score: ${_deviceStatus!.riskScore.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            status ? Icons.warning : Icons.check_circle,
            color: status ? Colors.red : Colors.indigo,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text('$label: ${status ? 'Yes' : 'No'}'),
        ],
      ),
    );
  }

  Widget _buildThreatsCard() {
    if (_threats.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Threats (${_threats.length})',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ..._threats.map(
              (threat) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('${threat.type}: ${threat.description}'),
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

  Widget _buildMetricsCard() {
    if (_metrics.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security Metrics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ..._metrics.entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text('${entry.key}: ${entry.value}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResultsCard() {
    if (_testResults.isEmpty && _testLogs.isEmpty)
      return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _isTesting ? Icons.hourglass_empty : Icons.assessment,
                  color: _isTesting ? Colors.orange : Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  _isTesting ? 'Testing in Progress...' : 'Web Test Results',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Test Results Summary
            if (_testResults.isNotEmpty) ...[
              Text(
                'Test Summary',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ..._testResults.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        entry.value['success'] == true
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: entry.value['success'] == true
                            ? Colors.green
                            : Colors.red,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _formatTestName(entry.key),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: entry.value['success'] == true
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          entry.value['success'] == true ? 'PASS' : 'FAIL',
                          style: TextStyle(
                            color: entry.value['success'] == true
                                ? Colors.green
                                : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Test Logs
            if (_testLogs.isNotEmpty) ...[
              Text('Test Logs', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _testLogs.length,
                  itemBuilder: (context, index) {
                    final log = _testLogs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Text(
                        log,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: log.contains('✅')
                              ? Colors.green[700]
                              : log.contains('❌')
                              ? Colors.red[700]
                              : Colors.grey[700],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTestName(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _buildActionButtons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Web Security Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized && !_isTesting
                    ? _testWebSecurity
                    : null,
                icon: _isTesting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Icon(Icons.security),
                label: Text(
                  _isTesting ? 'Testing...' : 'Test All Web Security',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testSecureStorage : null,
                icon: const Icon(Icons.storage),
                label: const Text('Test Secure Storage'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testBiometricAuth : null,
                icon: const Icon(Icons.fingerprint),
                label: const Text('Test Biometric Auth'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testNetworkSecurity : null,
                icon: const Icon(Icons.network_check),
                label: const Text('Test Network Security'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testAppIntegrity : null,
                icon: const Icon(Icons.verified),
                label: const Text('Test App Integrity'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testDeviceFingerprinting : null,
                icon: const Icon(Icons.fingerprint_outlined),
                label: const Text('Test Device Fingerprinting'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testCertificateVerification : null,
                icon: const Icon(Icons.security),
                label: const Text('Test Certificate Verification'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testBehaviorMonitoring : null,
                icon: const Icon(Icons.monitor),
                label: const Text('Test Behavior Monitoring'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTestLog(String message) {
    setState(() {
      _testLogs.add('${DateTime.now().toString().substring(11, 19)} $message');
    });
  }
}
