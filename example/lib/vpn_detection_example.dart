import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

/// Simple example showing how to use VPN detection in your Flutter app
class VPNDetectionExample extends StatefulWidget {
  const VPNDetectionExample({super.key});

  @override
  State<VPNDetectionExample> createState() => _VPNDetectionExampleState();
}

class _VPNDetectionExampleState extends State<VPNDetectionExample> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  bool _isInitialized = false;
  bool _hasVPN = false;
  bool _isLoading = false;
  String _statusMessage = '';

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

      // Initialize security with VPN detection enabled
      final config = SecurityConfig(
        enableNetworkMonitoring: true,
        enableSSLPinning: true,
        enableCodeObfuscation: true,
      );

      await _securityKit.initializeSecureMonitor(config);

      setState(() {
        _isInitialized = true;
        _isLoading = false;
        _statusMessage = 'Security initialized successfully!';
      });

      // Check VPN status immediately after initialization
      await _checkVPNStatus();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Failed to initialize security: $e';
      });
    }
  }

  Future<void> _checkVPNStatus() async {
    try {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Checking VPN status...';
      });

      // Check if VPN is connected
      final hasVPN = await _securityKit.hasVPNConnection();

      setState(() {
        _hasVPN = hasVPN;
        _isLoading = false;
        _statusMessage = hasVPN
            ? '⚠️ VPN detected! This may affect security.'
            : '✅ No VPN detected. Network appears normal.';
      });

      // If VPN is detected, you might want to take additional security measures
      if (hasVPN) {
        _handleVPNDetected();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Failed to check VPN status: $e';
      });
    }
  }

  void _handleVPNDetected() {
    // Example: Show a warning dialog when VPN is detected
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('VPN Detected'),
        content: const Text(
          'A VPN connection has been detected. This may affect the security of your app. '
          'Please ensure you are using a trusted VPN service.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _getDeviceSecurityStatus() async {
    try {
      setState(() {
        _isLoading = true;
        _statusMessage = 'Getting device security status...';
      });

      final status = await _securityKit.getDeviceSecurityStatus();

      setState(() {
        _isLoading = false;
        _statusMessage =
            '''
Device Security Status:

🔒 Overall Security: ${status.isSecure ? 'SECURE' : 'AT RISK'}
📊 Risk Score: ${(status.riskScore * 100).toStringAsFixed(1)}%
🌐 VPN Status: ${status.hasVPN ? 'CONNECTED' : 'NOT CONNECTED'}
🔗 Proxy Status: ${status.hasProxy ? 'DETECTED' : 'NOT DETECTED'}
📱 Rooted: ${status.isRooted ? 'YES' : 'NO'}
🍎 Jailbroken: ${status.isJailbroken ? 'YES' : 'NO'}
🖥️ Emulator: ${status.isEmulator ? 'YES' : 'NO'}
🐛 Debugger: ${status.isDebuggerAttached ? 'ATTACHED' : 'NOT ATTACHED'}
🔧 Developer Mode: ${status.isDeveloperModeEnabled ? 'ENABLED' : 'DISABLED'}
📸 Screenshot Blocked: ${status.isScreenCaptureBlocked ? 'YES' : 'NO'}
🔐 SSL Valid: ${status.isSSLValid ? 'YES' : 'NO'}
🔒 Code Obfuscated: ${status.isCodeObfuscated ? 'YES' : 'NO'}
📱 Biometric Available: ${status.isBiometricAvailable ? 'YES' : 'NO'}
🔌 USB Cable: ${status.isUsbCableAttached ? 'ATTACHED' : 'NOT ATTACHED'}
🚨 Active Threats: ${status.activeThreats.length}
''';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Failed to get device security status: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VPN Detection Example'),
        backgroundColor: Colors.indigo,
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

            // Action Buttons
            ElevatedButton(
              onPressed: _isLoading ? null : _checkVPNStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Check VPN Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _getDeviceSecurityStatus,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Get Device Security Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // Results
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Results',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _statusMessage,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
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

/// Example of how to use VPN detection in your own code
class VPNDetectionUsageExample {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();

  /// Example: Check VPN before making sensitive API calls
  Future<bool> makeSecureApiCall(String url, Map<String, dynamic> data) async {
    try {
      // Check VPN status before making the API call
      final hasVPN = await _securityKit.hasVPNConnection();

      if (hasVPN) {
        // VPN detected - you might want to:
        // 1. Log the VPN detection
        print('VPN detected during API call to: $url');

        // 2. Apply additional security measures
        // 3. Show warning to user
        // 4. Block the request if needed

        // For this example, we'll just log and continue
        // In a real app, you might want to block the request
      }

      // Make the API call with security protection
      final result = await _securityKit.secureApiCall(url, data);

      return result['success'] == true;
    } catch (e) {
      print('API call failed: $e');
      return false;
    }
  }

  /// Example: Monitor VPN status continuously
  void startVPNMonitoring() {
    // Check VPN status periodically
    Future.delayed(const Duration(seconds: 30), () async {
      final hasVPN = await _securityKit.hasVPNConnection();

      if (hasVPN) {
        print('VPN detected during monitoring');
        // Handle VPN detection
        _handleVPNDetected();
      }

      // Continue monitoring
      startVPNMonitoring();
    });
  }

  void _handleVPNDetected() {
    // Implement your VPN detection handling logic here
    print('Handling VPN detection...');
  }

  /// Example: Get comprehensive security status
  Future<Map<String, dynamic>> getSecurityReport() async {
    try {
      final status = await _securityKit.getDeviceSecurityStatus();

      return {
        'isSecure': status.isSecure,
        'riskScore': status.riskScore,
        'hasVPN': status.hasVPN,
        'hasProxy': status.hasProxy,
        'isRooted': status.isRooted,
        'isJailbroken': status.isJailbroken,
        'isEmulator': status.isEmulator,
        'isDebuggerAttached': status.isDebuggerAttached,
        'isDeveloperModeEnabled': status.isDeveloperModeEnabled,
        'isScreenCaptureBlocked': status.isScreenCaptureBlocked,
        'isSSLValid': status.isSSLValid,
        'isCodeObfuscated': status.isCodeObfuscated,
        'isBiometricAvailable': status.isBiometricAvailable,
        'isUsbCableAttached': status.isUsbCableAttached,
        'activeThreats': status.activeThreats.length,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
}
