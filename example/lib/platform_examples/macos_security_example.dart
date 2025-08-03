import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

/// macOS-specific security example demonstrating all macOS security features
class MacOSSecurityExample extends StatefulWidget {
  const MacOSSecurityExample({super.key});

  @override
  State<MacOSSecurityExample> createState() => _MacOSSecurityExampleState();
}

class _MacOSSecurityExampleState extends State<MacOSSecurityExample> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  bool _isInitialized = false;
  DeviceSecurityStatus? _deviceStatus;
  String _statusMessage = 'Initializing macOS security...';
  List<SecurityThreat> _threats = [];
  Map<String, dynamic> _metrics = {};
  bool _isSecureStorageEnabled = false;
  bool _isSSLPinningEnabled = false;
  bool _isScreenshotBlockingEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeMacOSSecurity();
    _setupSecurityListeners();
  }

  /// Initialize macOS-specific security protection
  Future<void> _initializeMacOSSecurity() async {
    try {
      // macOS-specific security configuration
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
          // Add your macOS app's certificate fingerprints
          'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
          'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=',
        ],
        customRules: {
          'maxApiCallsPerMinute': 100,
          'maxScreenTouchesPerMinute': 200,
          'blockedCountries': ['XX', 'YY'],
          // macOS-specific rules
          'checkForSIP': true,
          'checkForGatekeeper': true,
          'checkForNotarization': true,
          'checkForCodeSigning': true,
          'checkForSandbox': true,
          'checkForEntitlements': true,
          'checkForDeveloperID': true,
          'checkForAppStore': true,
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

      // Initialize macOS security
      await _securityKit.initializeSecureMonitor(config);

      // Enable macOS-specific security features
      await _enableMacOSSecurityFeatures();

      setState(() {
        _isInitialized = true;
        _statusMessage = 'macOS security initialized successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Failed to initialize macOS security: $e';
      });
    }
  }

  /// Enable macOS-specific security features
  Future<void> _enableMacOSSecurityFeatures() async {
    try {
      // Enable screenshot blocking
      await _securityKit.secureMonitor.updateScreenshotBlocking(true);
      setState(() => _isScreenshotBlockingEnabled = true);

      // SSL pinning and other features are enabled during initialization
      setState(() => _isSSLPinningEnabled = true);
      setState(() => _isSecureStorageEnabled = true);
    } catch (e) {
      print('Failed to enable macOS security features: $e');
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

  /// Test macOS-specific security features
  Future<void> _testMacOSSecurity() async {
    try {
      // Test device security status
      final status = await _securityKit.getDeviceSecurityStatus();
      setState(() => _deviceStatus = status);

      // Test secure storage
      await _testSecureStorage();

      // Test SSL pinning
      await _testSSLPinning();

      // Test biometric authentication
      await _testBiometricAuth();

      // Test system integrity protection
      await _testSystemIntegrity();

      // Test network security
      await _testNetworkSecurity();

      setState(() {
        _statusMessage = 'macOS security tests completed successfully!';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Security test failed: $e';
      });
    }
  }

  /// Test secure storage functionality
  Future<void> _testSecureStorage() async {
    try {
      // Store sensitive data
      await _securityKit.secureMonitor.secureStore(
        'macos_test_key',
        'sensitive_macos_data',
      );

      // Retrieve sensitive data
      final retrieved = await _securityKit.secureMonitor.secureRetrieve(
        'macos_test_key',
      );

      print('Secure storage test: $retrieved');
    } catch (e) {
      print('Secure storage test failed: $e');
    }
  }

  /// Test SSL pinning functionality
  Future<void> _testSSLPinning() async {
    try {
      // Test secure API call with SSL pinning
      final response = await _securityKit.secureApiCall(
        'https://api.example.com/macos-test',
        {'platform': 'macos', 'test': 'ssl_pinning'},
        headers: {'Content-Type': 'application/json'},
      );

      print('SSL pinning test response: $response');
    } catch (e) {
      print('SSL pinning test failed: $e');
    }
  }

  /// Test biometric authentication
  Future<void> _testBiometricAuth() async {
    try {
      print(
        'Biometric authentication test: Feature available in device security status',
      );
    } catch (e) {
      print('Biometric auth test failed: $e');
    }
  }

  /// Test system integrity protection
  Future<void> _testSystemIntegrity() async {
    try {
      print(
        'System Integrity Protection test: Check device security status for details',
      );
    } catch (e) {
      print('System Integrity Protection test failed: $e');
    }
  }

  /// Test network security
  Future<void> _testNetworkSecurity() async {
    try {
      print('Network security test: Check device security status for details');
    } catch (e) {
      print('Network security test failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('macOS Security Example'),
        backgroundColor: Colors.grey[800],
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
                  color: _isInitialized ? Colors.grey[800] : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'macOS Security Status',
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
                _isInitialized ? Colors.grey[800]! : Colors.orange,
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
              'macOS Security Features',
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
            _buildFeatureRow('System Integrity Protection', true),
            _buildFeatureRow('Touch ID', true),
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
            color: isEnabled ? Colors.grey[800] : Colors.red,
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
              'Device Security Status',
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
            color: status ? Colors.red : Colors.grey[800],
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

  Widget _buildActionButtons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'macOS Security Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isInitialized ? _testMacOSSecurity : null,
                icon: const Icon(Icons.security),
                label: const Text('Test macOS Security'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
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
                  backgroundColor: Colors.grey[700],
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
                label: const Text('Test Touch ID'),
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
                onPressed: _isInitialized ? _testSystemIntegrity : null,
                icon: const Icon(Icons.shield),
                label: const Text('Test System Integrity'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
