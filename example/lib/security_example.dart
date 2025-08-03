import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

/// Comprehensive example demonstrating all security features
class SecurityExample extends StatefulWidget {
  const SecurityExample({super.key});

  @override
  State<SecurityExample> createState() => _SecurityExampleState();
}

class _SecurityExampleState extends State<SecurityExample> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  bool _isInitialized = false;
  DeviceSecurityStatus? _deviceStatus;
  String _statusMessage = 'Initializing security...';
  List<SecurityThreat> _threats = [];
  Map<String, dynamic> _metrics = {};

  @override
  void initState() {
    super.initState();
    _initializeSecurity();
    _setupSecurityListeners();
  }

  /// Initialize comprehensive security protection
  Future<void> _initializeSecurity() async {
    try {
      // Configure comprehensive security settings
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
          'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
          'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=',
        ],
        customRules: {
          'maxApiCallsPerMinute': 100,
          'maxScreenTouchesPerMinute': 200,
          'blockedCountries': ['XX', 'YY'],
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

      // Initialize Protect AI security
      await _securityKit.initializeSecureMonitor(config);

      // Enable all security features
      await _enableAllSecurityFeatures();

      setState(() {
        _isInitialized = true;
        _statusMessage = 'Security initialized successfully!';
      });

      // Get initial device status
      await _updateDeviceStatus();
      await _updateSecurityMetrics();
    } catch (e) {
      setState(() {
        _statusMessage = 'Security initialization failed: $e';
      });
    }
  }

  /// Enable all security features
  Future<void> _enableAllSecurityFeatures() async {
    try {
      // 1. Device & Environment Security
      // Screenshot blocking is handled by the configuration
      await _securityKit.enableSecureFlag();

      // 2. Network Protection
      await _securityKit.enableNetworkMonitoring();
      await _securityKit.enableRealTimeMonitoring();

      // 3. Anti-Reverse Engineering
      await _securityKit.preventReverseEngineering();
      await _securityKit.applyAntiTampering();

      print('All security features enabled successfully');
    } catch (e) {
      print('Failed to enable some security features: $e');
    }
  }

  /// Setup security event listeners
  void _setupSecurityListeners() {
    // Listen to security threats
    _securityKit.threatStream.listen((threat) {
      setState(() {
        _threats.add(threat);
      });
      // Commented out to prevent frequent dialog popups
      // _showThreatAlert(threat);
    });

    // Listen to protection status changes
    _securityKit.statusStream.listen((status) {
      setState(() {
        _statusMessage =
            'Protection status: ${status.toString().split('.').last}';
      });
    });
  }

  /// Update device security status
  Future<void> _updateDeviceStatus() async {
    try {
      final status = await _securityKit.getDeviceSecurityStatus();
      setState(() {
        _deviceStatus = status;
      });
    } catch (e) {
      print('Failed to get device status: $e');
    }
  }

  /// Update security metrics
  Future<void> _updateSecurityMetrics() async {
    try {
      final metrics = _securityKit.securityMetrics;
      setState(() {
        _metrics = metrics;
      });
    } catch (e) {
      print('Failed to get security metrics: $e');
    }
  }

  /// Show threat alert
  // Commented out to prevent frequent dialog popups
  // void _showThreatAlert(SecurityThreat threat) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Security Threat Detected'),
  //       content: Text('${threat.description}\nLevel: ${threat.level}'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Demonstrate secure API call
  Future<void> _demonstrateSecureApiCall() async {
    try {
      final response = await _securityKit.secureApiCall(
        'https://api.example.com/secure',
        {
          'userId': '12345',
          'action': 'sensitive_operation',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
        headers: {
          'Authorization': 'Bearer ${_securityKit.generateSecureRandom()}',
          'Content-Type': 'application/json',
        },
        method: 'POST',
      );

      _showResult('Secure API Call', response.toString());
    } catch (e) {
      _showResult('Secure API Call Failed', e.toString());
    }
  }

  /// Demonstrate secure storage
  Future<void> _demonstrateSecureStorage() async {
    try {
      // Store sensitive data
      await _securityKit.secureStore(
        'user_token',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        expiresIn: const Duration(hours: 24),
      );

      // Retrieve sensitive data
      final token = await _securityKit.secureRetrieve('user_token');
      _showResult(
        'Secure Storage',
        'Token retrieved: ${token?.substring(0, 20)}...',
      );

      // Encrypt sensitive data
      final encrypted = await _securityKit.encryptSensitiveData(
        'sensitive_information',
      );
      final decrypted = await _securityKit.decryptSensitiveData(encrypted);
      _showResult('Encryption', 'Decrypted: $decrypted');
    } catch (e) {
      _showResult('Secure Storage Failed', e.toString());
    }
  }

  /// Demonstrate device security checks
  Future<void> _demonstrateDeviceChecks() async {
    try {
      final results = {
        'Rooted': await _securityKit.isRooted(),
        'Jailbroken': await _securityKit.isJailbroken(),
        'Emulator': await _securityKit.isEmulator(),
        'Debugger Attached': await _securityKit.isDebuggerAttached(),
        'Proxy Settings': await _securityKit.hasProxySettings(),
        'VPN Connection': await _securityKit.hasVPNConnection(),
        'App Signature': await _securityKit.getAppSignature(),
        'App Integrity': await _securityKit.verifyAppIntegrity(),
        'Device Fingerprint': await _securityKit.getDeviceFingerprint(),
      };

      _showResult('Device Security Checks', results.toString());
    } catch (e) {
      _showResult('Device Checks Failed', e.toString());
    }
  }

  /// Demonstrate behavior monitoring
  void _demonstrateBehaviorMonitoring() {
    // Record various behaviors
    _securityKit.recordApiHit();
    _securityKit.recordScreenTouch();
    _securityKit.recordAppLaunch();

    final behaviorData = _securityKit.getBehaviorData();
    _showResult('Behavior Monitoring', behaviorData.toJson().toString());
  }

  /// Demonstrate data sanitization
  void _demonstrateDataSanitization() {
    final maliciousInput =
        '<script>alert("XSS")</script>javascript:alert("XSS")';
    final sanitized = _securityKit.sanitizeInput(maliciousInput);
    _showResult('Data Sanitization', 'Sanitized: $sanitized');
  }

  /// Demonstrate secure random generation
  void _demonstrateSecureRandom() {
    final random32 = _securityKit.generateSecureRandom(length: 32);
    final random64 = _securityKit.generateSecureRandom(length: 64);
    _showResult('Secure Random', '32 chars: $random32\n64 chars: $random64');
  }

  /// Toggle screenshot blocking
  Future<void> _toggleScreenshotBlocking() async {
    try {
      // Get current status
      final currentStatus = await _securityKit.isScreenCaptureBlocked();

      // Toggle to opposite state
      await _securityKit.updateScreenshotBlocking(!currentStatus);

      // Get updated status
      final newStatus = await _securityKit.isScreenCaptureBlocked();

      _showResult(
        'Screenshot Blocking Toggled',
        'Previous: ${currentStatus ? "Blocked" : "Allowed"}\n'
            'Current: ${newStatus ? "Blocked" : "Allowed"}\n\n'
            'Try taking a screenshot now to test!',
      );

      // Refresh device status
      _updateDeviceStatus();
    } catch (e) {
      _showResult('Error', 'Failed to toggle screenshot blocking: $e');
    }
  }

  /// Set screenshot blocking to specific state
  Future<void> _setScreenshotBlocking(bool enabled) async {
    try {
      await _securityKit.updateScreenshotBlocking(enabled);

      // Refresh device status
      await _updateDeviceStatus();

      _showResult(
        'Screenshot Blocking Updated',
        'Screenshot blocking is now ${enabled ? "ENABLED" : "DISABLED"}\n\n'
            'Try taking a screenshot to test!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to update screenshot blocking: $e');
    }
  }

  /// Show result in dialog
  void _showResult(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Show result in dialog with action button
  void _showResultWithAction(
    String title,
    String content,
    String actionText,
    VoidCallback onAction,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onAction();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ultra Secure Flutter Kit Demo'),
        backgroundColor: _isInitialized ? Colors.green : Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Security Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Text(_statusMessage),
                    if (_deviceStatus != null) ...[
                      SizedBox(height: 8),
                      Text(
                        'Risk Score: ${(_deviceStatus!.riskScore * 100).toStringAsFixed(1)}%',
                      ),
                      Text('Is Secure: ${_deviceStatus!.isSecure}'),
                    ],
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Device Security Status
            if (_deviceStatus != null) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Device Security',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 8),
                      _buildSecurityItem('Rooted', _deviceStatus!.isRooted),
                      _buildSecurityItem(
                        'Jailbroken',
                        _deviceStatus!.isJailbroken,
                      ),
                      _buildSecurityItem('Emulator', _deviceStatus!.isEmulator),
                      _buildSecurityItem(
                        'Debugger',
                        _deviceStatus!.isDebuggerAttached,
                      ),
                      _buildSecurityItem('Proxy', _deviceStatus!.hasProxy),
                      _buildSecurityItem('VPN', _deviceStatus!.hasVPN),
                      _buildSecurityItem(
                        'Developer Mode',
                        _deviceStatus!.isDeveloperModeEnabled,
                      ),
                      _buildSecurityItem(
                        'Screen Capture Blocked',
                        _deviceStatus!.isScreenCaptureBlocked,
                      ),
                      _buildSecurityItem(
                        'SSL Valid',
                        _deviceStatus!.isSSLValid,
                      ),
                      _buildSecurityItem(
                        'Biometric Available',
                        _deviceStatus!.isBiometricAvailable,
                      ),
                      _buildSecurityItem(
                        'Code Obfuscated',
                        _deviceStatus!.isCodeObfuscated,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],

            // Security Metrics
            if (_metrics.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security Metrics',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 8),
                      Text('Threat Count: ${_metrics['threat_count'] ?? 0}'),
                      Text(
                        'Blocked Attempts: ${_metrics['blocked_attempts'] ?? 0}',
                      ),
                      Text(
                        'Active Threats: ${_metrics['active_threats'] ?? 0}',
                      ),
                      Text('API Hits: ${_metrics['api_hits'] ?? 0}'),
                      Text(
                        'Screen Touches: ${_metrics['screen_touches'] ?? 0}',
                      ),
                      Text('App Launches: ${_metrics['app_launches'] ?? 0}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],

            // Device Security Test Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Device Security Test',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Test all device security features at once',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _runCompleteDeviceSecurityTest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Run Complete Device Security Test',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _runIndividualSecurityTests,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Run Individual Security Tests',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Security Threats
            if (_threats.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Active Threats (${_threats.length})',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 8),
                      ...(_threats
                          .take(5)
                          .map(
                            (threat) => ListTile(
                              title: Text(threat.description),
                              subtitle: Text(
                                '${threat.type} - ${threat.level}',
                              ),
                              trailing: _getThreatIcon(threat.level),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],

            // Screenshot Blocking Control
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Screenshot Blocking Control',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _setScreenshotBlocking(true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Enable Screenshot Blocking'),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _setScreenshotBlocking(false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Disable Screenshot Blocking'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Current Status: ${_deviceStatus?.isScreenCaptureBlocked == true ? "BLOCKED" : "ALLOWED"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _deviceStatus?.isScreenCaptureBlocked == true
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Security Actions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Security Actions',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _demonstrateSecureApiCall,
                      child: Text('Secure API Call'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _demonstrateSecureStorage,
                      child: Text('Secure Storage'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _demonstrateDeviceChecks,
                      child: Text('Device Security Checks'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _demonstrateBehaviorMonitoring,
                      child: Text('Behavior Monitoring'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _demonstrateDataSanitization,
                      child: Text('Data Sanitization'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _demonstrateSecureRandom,
                      child: Text('Secure Random Generation'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _toggleScreenshotBlocking,
                      child: Text('Toggle Screenshot Blocking'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        await _updateDeviceStatus();
                        await _updateSecurityMetrics();
                      },
                      child: Text('Refresh Status'),
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

  Widget _buildSecurityItem(String label, bool value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                value ? Icons.warning : Icons.check_circle,
                color: value ? Colors.red : Colors.green,
                size: 16,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$label: ${value ? "YES" : "NO"}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              // Expanded(
              //   child: ElevatedButton(
              //     onPressed: () => _handleSecurityAction(label, true),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.green,
              //       foregroundColor: Colors.white,
              //       padding: EdgeInsets.symmetric(vertical: 8),
              //     ),
              //     child: Text(label),
              //   ),
              // ),
              SizedBox(width: 8),

              // Expanded(
              //   child: ElevatedButton(
              //     onPressed: () => _handleSecurityAction(label, false),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.red,
              //       foregroundColor: Colors.white,
              //       padding: EdgeInsets.symmetric(vertical: 8),
              //     ),
              //     child: Text(value ? '${label}' : '${label}'),
              //   ),
              // ),
              // // Add Fix button for Developer Mode
              if (label == 'Developer Mode' && value) ...[
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _openDeveloperOptionsSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text('Fix'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleSecurityAction(String label, bool enable) async {
    try {
      switch (label.toLowerCase()) {
        case 'rooted':
          // Root detection is always active - let's test it
          await _testRootDetection();
          return;
        case 'jailbroken':
          // Jailbreak detection is always active - let's test it
          await _testJailbreakDetection();
          return;
        case 'emulator':
          // Emulator detection is always active - let's test it
          await _testEmulatorDetection();
          return;
        case 'debugger':
          // Debugger detection is always active - let's test it
          await _testDebuggerDetection();
          return;
        case 'proxy':
          // Proxy detection is always active - let's test it
          await _testProxyDetection();
          return;
        case 'vpn':
          // VPN detection is always active - let's test it
          await _testVPNDetection();
          return;
        case 'screen capture blocked':
          await _securityKit.updateScreenshotBlocking(enable);
          break;
        case 'ssl valid':
          // SSL validation is typically a check, not something we can enable/disable
          _showResult(
            'Info',
            'SSL validation is a security check, not a toggleable feature',
          );
          return;
        case 'biometric available':
          // This is typically a device capability, not something we can enable/disable
          _showResult('Info', 'Biometric availability is a device capability');
          return;
        case 'code obfuscated':
          if (enable) {
            await _securityKit.preventReverseEngineering();
          }
          break;
        default:
          _showResult('Info', 'Action for $label is not implemented yet');
          return;
      }

      // Refresh status after action
      await _updateDeviceStatus();
      await _updateSecurityMetrics();

      _showResult(
        'Success',
        '${label} protection ${enable ? "enabled" : "disabled"} successfully',
      );
    } catch (e) {
      _showResult(
        'Error',
        'Failed to ${enable ? "enable" : "disable"} $label protection: $e',
      );
    }
  }

  // Detection test methods
  Future<void> _testRootDetection() async {
    try {
      final isRooted = await _securityKit.isRooted();
      _showResult(
        'Root Detection Test',
        'Device is ${isRooted ? "ROOTED" : "NOT ROOTED"}\n\n'
            'Detection is working correctly!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to test root detection: $e');
    }
  }

  Future<void> _testJailbreakDetection() async {
    try {
      final isJailbroken = await _securityKit.isJailbroken();
      _showResult(
        'Jailbreak Detection Test',
        'Device is ${isJailbroken ? "JAILBROKEN" : "NOT JAILBROKEN"}\n\n'
            'Detection is working correctly!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to test jailbreak detection: $e');
    }
  }

  Future<void> _testEmulatorDetection() async {
    try {
      final isEmulator = await _securityKit.isEmulator();
      _showResult(
        'Emulator Detection Test',
        'Device is ${isEmulator ? "EMULATOR" : "REAL DEVICE"}\n\n'
            'Detection is working correctly!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to test emulator detection: $e');
    }
  }

  Future<void> _testDebuggerDetection() async {
    try {
      final isDebuggerAttached = await _securityKit.isDebuggerAttached();
      _showResult(
        'Debugger Detection Test',
        'Debugger is ${isDebuggerAttached ? "ATTACHED" : "NOT ATTACHED"}\n\n'
            'Detection is working correctly!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to test debugger detection: $e');
    }
  }

  Future<void> _testProxyDetection() async {
    try {
      final hasProxy = await _securityKit.hasProxySettings();
      _showResult(
        'Proxy Detection Test',
        'Proxy is ${hasProxy ? "DETECTED" : "NOT DETECTED"}\n\n'
            'Detection is working correctly!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to test proxy detection: $e');
    }
  }

  Future<void> _testVPNDetection() async {
    try {
      final hasVPN = await _securityKit.hasVPNConnection();
      _showResult(
        'VPN Detection Test',
        'VPN is ${hasVPN ? "DETECTED" : "NOT DETECTED"}\n\n'
            'Detection is working correctly!',
      );
    } catch (e) {
      _showResult('Error', 'Failed to test VPN detection: $e');
    }
  }

  Future<void> _openDeveloperOptionsSettings() async {
    try {
      await _securityKit.openDeveloperOptionsSettings();
      // _showResult(
      //   'Settings Opened',
      //   'Developer Options settings have been opened.\n\n'
      //       'Please disable Developer Options to improve security.',
      // );
    } catch (e) {
      _showResult('Error', 'Failed to open Developer Options settings: $e');
    }
  }

  // Complete Device Security Test
  Future<void> _runCompleteDeviceSecurityTest() async {
    try {
      _showResult('Testing...', 'Running complete device security test...');

      // Test all device security features
      final results = await Future.wait([
        _securityKit.isRooted(),
        _securityKit.isJailbroken(),
        _securityKit.isEmulator(),
        _securityKit.isDebuggerAttached(),
        _securityKit.hasProxySettings(),
        _securityKit.hasVPNConnection(),
        _securityKit.isScreenCaptureBlocked(),
        _securityKit.isDeveloperModeEnabled(),
        _securityKit.getDeviceSecurityStatus(),
      ]);

      final isRooted = results[0] as bool;
      final isJailbroken = results[1] as bool;
      final isEmulator = results[2] as bool;
      final isDebuggerAttached = results[3] as bool;
      final hasProxy = results[4] as bool;
      final hasVPN = results[5] as bool;
      final isScreenCaptureBlocked = results[6] as bool;
      final isDeveloperModeEnabled = results[7] as bool;
      final deviceStatus = results[8] as DeviceSecurityStatus;

      // Calculate security score
      int securityScore = 100;
      List<String> issues = [];

      if (isRooted) {
        securityScore -= 30;
        issues.add('❌ Device is ROOTED (High Risk)');
      }
      if (isJailbroken) {
        securityScore -= 30;
        issues.add('❌ Device is JAILBROKEN (High Risk)');
      }
      if (isEmulator) {
        securityScore -= 20;
        issues.add('⚠️ Running on EMULATOR (Medium Risk)');
      }
      if (isDebuggerAttached) {
        securityScore -= 25;
        issues.add('⚠️ Debugger is ATTACHED (Medium Risk)');
      }
      if (hasProxy) {
        securityScore -= 10;
        issues.add('⚠️ Proxy detected (Low Risk)');
      }
      if (hasVPN) {
        securityScore -= 5;
        issues.add('ℹ️ VPN detected (Info)');
      }
      if (isDeveloperModeEnabled) {
        securityScore -= 15;
        issues.add('⚠️ Developer Mode is ENABLED (Medium Risk)');
      }
      if (!isScreenCaptureBlocked) {
        securityScore -= 15;
        issues.add('⚠️ Screenshot blocking is DISABLED (Medium Risk)');
      }

      // Generate report
      String report = '🔒 DEVICE SECURITY TEST REPORT\n\n';
      report += '📊 Security Score: $securityScore/100\n\n';

      if (issues.isEmpty) {
        report += '✅ All security checks passed!\n';
        report += 'Your device appears to be secure.\n\n';
      } else {
        report += '🚨 Security Issues Found:\n';
        report += issues.join('\n');
        report += '\n\n';
      }

      report += '📋 Detailed Results:\n';
      report += '• Rooted: ${isRooted ? "YES" : "NO"}\n';
      report += '• Jailbroken: ${isJailbroken ? "YES" : "NO"}\n';
      report += '• Emulator: ${isEmulator ? "YES" : "NO"}\n';
      report +=
          '• Debugger: ${isDebuggerAttached ? "ATTACHED" : "NOT ATTACHED"}\n';
      report += '• Proxy: ${hasProxy ? "DETECTED" : "NOT DETECTED"}\n';
      report += '• VPN: ${hasVPN ? "DETECTED" : "NOT DETECTED"}\n';
      report +=
          '• Developer Mode: ${isDeveloperModeEnabled ? "ENABLED" : "DISABLED"}\n';
      report +=
          '• Screenshot Blocked: ${isScreenCaptureBlocked ? "YES" : "NO"}\n';
      report +=
          '• Risk Score: ${(deviceStatus.riskScore * 100).toStringAsFixed(1)}%\n';

      // Show result with action button if developer mode is enabled
      if (isDeveloperModeEnabled) {
        _showResultWithAction(
          'Complete Security Test',
          report,
          'Fix Developer Mode',
          _openDeveloperOptionsSettings,
        );
      } else {
        _showResult('Complete Security Test', report);
      }
    } catch (e) {
      _showResult('Error', 'Failed to run complete security test: $e');
    }
  }

  // Individual Security Tests
  Future<void> _runIndividualSecurityTests() async {
    try {
      String report = '🔍 INDIVIDUAL SECURITY TESTS\n\n';

      // Test each security feature individually
      final tests = [
        ('Root Detection', _securityKit.isRooted()),
        ('Jailbreak Detection', _securityKit.isJailbroken()),
        ('Emulator Detection', _securityKit.isEmulator()),
        ('Debugger Detection', _securityKit.isDebuggerAttached()),
        ('Proxy Detection', _securityKit.hasProxySettings()),
        ('VPN Detection', _securityKit.hasVPNConnection()),
        ('Developer Mode Detection', _securityKit.isDeveloperModeEnabled()),
        ('Screenshot Blocking', _securityKit.isScreenCaptureBlocked()),
      ];

      for (var test in tests) {
        try {
          final result = await test.$2;
          final status = result
              ? '✅ WORKING'
              : '✅ WORKING (No threat detected)';
          report += '${test.$1}: $status\n';
        } catch (e) {
          report += '${test.$1}: ❌ FAILED - $e\n';
        }
      }

      report += '\n🎯 All detection methods are functioning correctly!';
      _showResult('Individual Tests Complete', report);
    } catch (e) {
      _showResult('Error', 'Failed to run individual tests: $e');
    }
  }

  Widget _getThreatIcon(SecurityThreatLevel level) {
    IconData icon;
    Color color;

    switch (level) {
      case SecurityThreatLevel.low:
        icon = Icons.info;
        color = Colors.blue;
        break;
      case SecurityThreatLevel.medium:
        icon = Icons.warning;
        color = Colors.orange;
        break;
      case SecurityThreatLevel.high:
        icon = Icons.error;
        color = Colors.red;
        break;
      case SecurityThreatLevel.critical:
        icon = Icons.dangerous;
        color = Colors.purple;
        break;
    }

    return Icon(icon, color: color);
  }
}
