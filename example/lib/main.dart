import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';
import 'package:ultra_secure_flutter_kit_example/security_example.dart';
import 'package:ultra_secure_flutter_kit_example/plugin_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ultra Secure Flutter Kit Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SecurityExample(),
      // home: PluginTest(),
      //   home: const MyHomePage(title: 'Ultra Secure Flutter Kit Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final UltraSecureFlutterKit _securityKit = UltraSecureFlutterKit();
  bool _isInitialized = false;
  ProtectionStatus _protectionStatus = ProtectionStatus.uninitialized;
  Map<String, dynamic> _securityMetrics = {};
  DeviceSecurityStatus? _deviceStatus;
  String _secureData = '';
  String _encryptedData = '';
  List<SecurityThreat> _threats = [];
  bool _isLoading = false;
  String _testResults = '';

  @override
  void initState() {
    super.initState();
    // Delay initialization to prevent blocking main thread during app startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _testPluginConnection();
      _initializeSecurity();
      _listenToSecurityEvents();
    });
  }

  Future<void> _testPluginConnection() async {
    try {
      final version = await _securityKit.getPlatformVersion();
      setState(() {
        _testResults = 'Plugin connection test: SUCCESS\nPlatform: $version';
      });
      print('Plugin connection test: SUCCESS - $version');
    } catch (e) {
      setState(() {
        _testResults = 'Plugin connection test: FAILED\nError: $e';
      });
      print('Plugin connection test: FAILED - $e');
    }
  }

  Future<void> _initializeSecurity() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Initialize Protect AI with strict security configuration
      await _securityKit.initializeSecureMonitor(
        const SecurityConfig(
          mode: SecurityMode.strict,
          blockOnHighRisk: true,
          enableScreenshotBlocking: true,
          enableSSLPinning: true,
          enableSecureStorage: true,
          enableNetworkMonitoring: true,
          enableBehaviorMonitoring: true,
          allowedCertificates: ['sha256/your-certificate-hash-here'],
        ),
      );

      setState(() {
        _isInitialized = true;
        _protectionStatus = _securityKit.protectionStatus;
        _securityMetrics = _securityKit.securityMetrics;
      });

      // Get device security status in background
      _updateDeviceStatus();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Security initialized successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Security initialization failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateDeviceStatus() async {
    try {
      final deviceStatus = await _securityKit.getDeviceSecurityStatus();
      if (mounted) {
        setState(() {
          _deviceStatus = deviceStatus;
        });
      }
    } catch (e) {
      print('Failed to get device status: $e');
    }
  }

  void _listenToSecurityEvents() {
    // Listen to security threats
    _securityKit.threatStream.listen((threat) {
      if (threat is SecurityThreat && mounted) {
        setState(() {
          _threats.add(threat);
        });

        // Commented out to prevent frequent dialog popups
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Security threat detected: ${threat.description}'),
        //     backgroundColor: Colors.orange,
        //   ),
        // );
      }
    });

    // Listen to protection status changes
    _securityKit.statusStream.listen((status) {
      if (status is ProtectionStatus && mounted) {
        setState(() {
          _protectionStatus = status;
        });
      }
    });
  }

  Future<void> _testSecureStorage() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Store sensitive data securely
      await _securityKit.secureStore(
        'user_token',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        expiresIn: const Duration(hours: 24),
      );

      // Retrieve the data
      final retrievedData = await _securityKit.secureRetrieve('user_token');
      setState(() {
        _secureData = retrievedData ?? 'No data found';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Secure storage test completed!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Secure storage test failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testEncryption() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Encrypt sensitive data
      final encrypted = await _securityKit.encryptSensitiveData(
        'This is sensitive information that should be encrypted!',
      );

      // Decrypt the data
      final decrypted = await _securityKit.decryptSensitiveData(encrypted);

      setState(() {
        _encryptedData =
            'Encrypted: ${encrypted.substring(0, 50)}...\nDecrypted: $decrypted';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Encryption test completed!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Encryption test failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testSecureApiCall() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Record API hit for behavior monitoring
      _securityKit.recordApiHit();

      // Make a secure API call
      final response = await _securityKit.secureApiCall(
        'https://api.example.com/secure-endpoint',
        {
          'user_id': '12345',
          'action': 'login',
          'timestamp': DateTime.now().toIso8601String(),
        },
        headers: {'Content-Type': 'application/json'},
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Secure API call completed: ${response['status'] ?? 'success'}',
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Secure API call failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testDeviceSecurity() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Check various device security aspects
      final isRooted = await _securityKit.isRooted();
      final isJailbroken = await _securityKit.isJailbroken();
      final isEmulator = await _securityKit.isEmulator();
      final isDebuggerAttached = await _securityKit.isDebuggerAttached();
      final hasProxy = await _securityKit.hasProxySettings();
      final hasVPN = await _securityKit.hasVPNConnection();
      final isScreenCaptureBlocked = await _securityKit
          .isScreenCaptureBlocked();

      final securityInfo =
          '''
Device Security Status:
- Rooted: $isRooted
- Jailbroken: $isJailbroken
- Emulator: $isEmulator
- Debugger Attached: $isDebuggerAttached
- Proxy Detected: $hasProxy
- VPN Detected: $hasVPN
- Screenshot Blocked: $isScreenCaptureBlocked
''';

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device security check completed'),
          backgroundColor: Colors.green,
        ),
      );

      // Show detailed security info
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Device Security Status'),
            content: Text(securityInfo),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Device security check failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _testScreenshotBlocking() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Enable screenshot blocking
      await _securityKit.enableScreenCaptureProtection();

      // Check if it's enabled
      final isBlocked = await _securityKit.isScreenCaptureBlocked();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Screenshot blocking ${isBlocked ? 'enabled' : 'failed'}',
          ),
          backgroundColor: isBlocked ? Colors.green : Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Screenshot blocking test failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _disableScreenshotBlocking() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Disable screenshot blocking
      await _securityKit.disableScreenCaptureProtection();

      // Check if it's disabled
      final isBlocked = await _securityKit.isScreenCaptureBlocked();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Screenshot blocking ${!isBlocked ? 'disabled' : 'still enabled'}',
          ),
          backgroundColor: !isBlocked ? Colors.green : Colors.orange,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Screenshot blocking disable failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _recordUserBehavior() {
    // Record user behavior for monitoring
    _securityKit.recordScreenTouch();
    _securityKit.recordApiHit();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User behavior recorded!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Plugin Connection Test
                if (_testResults.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Plugin Connection Test',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(_testResults),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Security Status Card
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
                        Text('Initialized: $_isInitialized'),
                        Text('Protection Status: $_protectionStatus'),
                        if (_deviceStatus != null) ...[
                          Text('Device Secure: ${_deviceStatus!.isSecure}'),
                          Text(
                            'Risk Score: ${_deviceStatus!.riskScore.toStringAsFixed(2)}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Security Metrics Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security Metrics',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Threat Count: ${_securityMetrics['threat_count'] ?? 0}',
                        ),
                        Text(
                          'Blocked Attempts: ${_securityMetrics['blocked_attempts'] ?? 0}',
                        ),
                        Text(
                          'Active Threats: ${_securityMetrics['active_threats'] ?? 0}',
                        ),
                        Text('API Hits: ${_securityMetrics['api_hits'] ?? 0}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Test Buttons
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security Tests',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton(
                              onPressed: _isLoading ? null : _testSecureStorage,
                              child: const Text('Test Secure Storage'),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _testEncryption,
                              child: const Text('Test Encryption'),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _testSecureApiCall,
                              child: const Text('Test Secure API'),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : _testDeviceSecurity,
                              child: const Text('Test Device Security'),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : _testScreenshotBlocking,
                              child: const Text('Test Screenshot Blocking'),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : _disableScreenshotBlocking,
                              child: const Text('Disable Screenshot Blocking'),
                            ),
                            ElevatedButton(
                              onPressed: _isLoading
                                  ? null
                                  : _recordUserBehavior,
                              child: const Text('Record Behavior'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const PluginTest(),
                                  ),
                                );
                              },
                              child: const Text('Plugin Test'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Secure Data Display
                if (_secureData.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Secure Data',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(_secureData),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Encryption Test Results
                if (_encryptedData.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Encryption Test Results',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(_encryptedData),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Security Threats
                if (_threats.isNotEmpty) ...[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Security Threats (${_threats.length})',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          ...(_threats
                              .take(5)
                              .map(
                                (threat) => ListTile(
                                  title: Text(threat.description),
                                  subtitle: Text(
                                    '${threat.type} - ${threat.level}',
                                  ),
                                  trailing: Text(
                                    '${threat.timestamp.hour}:${threat.timestamp.minute}',
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
