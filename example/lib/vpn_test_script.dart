import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

class VPNTestScript extends StatefulWidget {
  const VPNTestScript({super.key});

  @override
  State<VPNTestScript> createState() => _VPNTestScriptState();
}

class _VPNTestScriptState extends State<VPNTestScript> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  bool _isInitialized = false;
  bool _hasVPN = false;
  bool _isLoading = false;
  String _statusMessage = 'Click "Test VPN Detection" to start';

  @override
  void initState() {
    super.initState();
    _initializeSecurity();
  }

  Future<void> _initializeSecurity() async {
    try {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Initializing security...';
      });

      final config = SecurityConfig(
        enableCodeObfuscation: true,
        enableScreenshotBlocking: true,
        enableSSLPinning: true,
        enableNetworkMonitoring: true,
      );

      await _securityKit.initializeSecureMonitor(config);

      setState(() {
        _isInitialized = true;
        _isLoading = false;
        _statusMessage = 'Security initialized. Ready to test VPN detection.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Failed to initialize security: $e';
      });
    }
  }

  Future<void> _testVPNDetection() async {
    try {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Testing VPN detection...';
      });

      // Test VPN detection
      final hasVPN = await _securityKit.hasVPNConnection();
      
      // Get device security status
      final deviceStatus = await _securityKit.getDeviceSecurityStatus();
      
      // Get security metrics
      final metrics = _securityKit.securityMetrics;

      setState(() {
        _hasVPN = hasVPN;
        _isLoading = false;
        _statusMessage = '''
VPN Detection Test Results:

🔍 VPN Connection: ${hasVPN ? 'DETECTED' : 'NOT DETECTED'}
📱 Device Status VPN: ${deviceStatus.hasVPN ? 'YES' : 'NO'}
🛡️ Overall Security: ${deviceStatus.isSecure ? 'SECURE' : 'AT RISK'}
📊 Risk Score: ${(deviceStatus.riskScore * 100).toStringAsFixed(1)}%
🔒 Protection Status: ${_securityKit.protectionStatus}

Security Metrics:
- Threat Count: ${metrics['threat_count'] ?? 0}
- Blocked Attempts: ${metrics['blocked_attempts'] ?? 0}
- Active Threats: ${metrics['active_threats'] ?? 0}
- API Hits: ${metrics['api_hits'] ?? 0}
- Screen Touches: ${metrics['screen_touches'] ?? 0}
- App Launches: ${metrics['app_launches'] ?? 0}

${hasVPN ? '⚠️ VPN detected - this may affect security' : '✅ No VPN detected - network appears normal'}
''';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'VPN detection test failed: $e';
      });
    }
  }

  Future<void> _runComprehensiveTest() async {
    try {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Running comprehensive security test...';
      });

      // Test all network-related security features
      final results = await Future.wait([
        _securityKit.hasVPNConnection(),
        _securityKit.hasProxySettings(),
        _securityKit.getUnexpectedCertificates(),
        _securityKit.getDeviceSecurityStatus(),
      ]);

      final hasVPN = results[0] as bool;
      final hasProxy = results[1] as bool;
      final certificates = results[2] as List<String>;
      final deviceStatus = results[3] as DeviceSecurityStatus;

      setState(() {
        _hasVPN = hasVPN;
        _isLoading = false;
        _statusMessage = '''
🔒 COMPREHENSIVE SECURITY TEST RESULTS

Network Security:
🌐 VPN Connection: ${hasVPN ? 'DETECTED' : 'NOT DETECTED'}
🔗 Proxy Settings: ${hasProxy ? 'DETECTED' : 'NOT DETECTED'}
📜 Unexpected Certificates: ${certificates.length} found

Device Security Status:
📱 Rooted: ${deviceStatus.isRooted ? 'YES' : 'NO'}
🍎 Jailbroken: ${deviceStatus.isJailbroken ? 'YES' : 'NO'}
🖥️ Emulator: ${deviceStatus.isEmulator ? 'YES' : 'NO'}
🐛 Debugger: ${deviceStatus.isDebuggerAttached ? 'ATTACHED' : 'NOT ATTACHED'}
🔧 Developer Mode: ${deviceStatus.isDeveloperModeEnabled ? 'ENABLED' : 'DISABLED'}
📸 Screenshot Blocked: ${deviceStatus.isScreenCaptureBlocked ? 'YES' : 'NO'}
🔐 SSL Valid: ${deviceStatus.isSSLValid ? 'YES' : 'NO'}
🔒 Code Obfuscated: ${deviceStatus.isCodeObfuscated ? 'YES' : 'NO'}
📱 Biometric Available: ${deviceStatus.isBiometricAvailable ? 'YES' : 'NO'}
🔌 USB Cable: ${deviceStatus.isUsbCableAttached ? 'ATTACHED' : 'NOT ATTACHED'}

Risk Assessment:
⚠️ Risk Score: ${(deviceStatus.riskScore * 100).toStringAsFixed(1)}%
🛡️ Overall Security: ${deviceStatus.isSecure ? 'SECURE' : 'AT RISK'}
🚨 Active Threats: ${deviceStatus.activeThreats.length}

${_getSecurityRecommendations(deviceStatus, hasVPN, hasProxy)}
''';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Comprehensive test failed: $e';
      });
    }
  }

  String _getSecurityRecommendations(DeviceSecurityStatus status, bool hasVPN, bool hasProxy) {
    List<String> recommendations = [];

    if (status.isRooted) {
      recommendations.add('❌ Device is ROOTED - High security risk');
    }
    if (status.isJailbroken) {
      recommendations.add('❌ Device is JAILBROKEN - High security risk');
    }
    if (status.isEmulator) {
      recommendations.add('⚠️ Running on EMULATOR - Medium risk');
    }
    if (status.isDebuggerAttached) {
      recommendations.add('⚠️ Debugger is ATTACHED - Medium risk');
    }
    if (status.isDeveloperModeEnabled) {
      recommendations.add('⚠️ Developer Mode is ENABLED - Medium risk');
    }
    if (hasVPN) {
      recommendations.add('ℹ️ VPN detected - Monitor for suspicious activity');
    }
    if (hasProxy) {
      recommendations.add('⚠️ Proxy detected - Potential security risk');
    }
    if (!status.isScreenCaptureBlocked) {
      recommendations.add('⚠️ Screenshot blocking is DISABLED');
    }
    if (!status.isSSLValid) {
      recommendations.add('❌ SSL validation failed - High risk');
    }

    if (recommendations.isEmpty) {
      return '✅ All security checks passed! Device appears secure.';
    } else {
      return '🚨 Security Recommendations:\n${recommendations.join('\n')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VPN Detection Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Security Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _isInitialized ? Icons.check_circle : Icons.error,
                          color: _isInitialized ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isInitialized ? 'Initialized' : 'Not Initialized',
                          style: TextStyle(
                            color: _isInitialized ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (_hasVPN) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.vpn_key, color: Colors.orange),
                          const SizedBox(width: 8),
                          const Text(
                            'VPN DETECTED',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Test Buttons
            ElevatedButton(
              onPressed: _isLoading ? null : _testVPNDetection,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Test VPN Detection',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _runComprehensiveTest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Run Comprehensive Test',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
            const SizedBox(height: 16),

            // Results
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      _statusMessage,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 