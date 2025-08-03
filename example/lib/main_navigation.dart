import 'package:flutter/material.dart';
import 'package:ultra_secure_flutter_kit_example/security_example.dart';
import 'package:ultra_secure_flutter_kit_example/plugin_test.dart';
import 'package:ultra_secure_flutter_kit_example/platform_examples/platform_examples_main.dart';
import 'package:ultra_secure_flutter_kit_example/network_error_handler.dart';
import 'package:ultra_secure_flutter_kit_example/network_connectivity_widget.dart';
import 'package:ultra_secure_flutter_kit_example/network_troubleshooting_guide.dart';
import 'package:ultra_secure_flutter_kit_example/obfuscation_test_example.dart';
import 'package:ultra_secure_flutter_kit_example/vpn_test_script.dart';
import 'package:ultra_secure_flutter_kit_example/vpn_detection_example.dart';

/// Main navigation screen for Ultra Secure Flutter Kit examples
class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultra Secure Flutter Kit Examples'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          NetworkConnectivityBuilder(
            builder: (context, hasConnection, isChecking) {
              return NetworkStatusIndicator(
                hasConnection: hasConnection,
                isChecking: isChecking,
                onRetry: () async {
                  final status = await NetworkErrorHandler.getNetworkStatus();
                  if (!status['hasInternetConnection']) {
                    if (context.mounted) {
                      final errorInfo = NetworkErrorInfo(
                        type: NetworkErrorType.noNetworkConnection,
                        message:
                            'No internet connection available. Please check your network settings.',
                      );
                      NetworkErrorHandler.showNetworkErrorDialog(
                        context,
                        errorInfo,
                      );
                    }
                  }
                },
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 24),
              _buildNetworkStatusCard(context),
              const SizedBox(height: 24),
              _buildExampleCards(context),
              const SizedBox(height: 24),
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: Colors.white, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Ultra Secure Flutter Kit',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Security Examples & Demonstrations',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose an example to explore comprehensive security features',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCards(BuildContext context) {
    final examples = [
      _ExampleInfo(
        name: 'Comprehensive Security Example',
        description: 'Full security demonstration with all features enabled',
        icon: Icons.security,
        color: Colors.green,
        route: const SecurityExample(),
        isRecommended: true,
      ),
      _ExampleInfo(
        name: 'Platform-Specific Examples',
        description:
            'Security examples tailored for each platform (Android, iOS, Web, etc.)',
        icon: Icons.devices,
        color: Colors.blue,
        route: const PlatformExamplesMain(),
        isRecommended: true,
      ),
      _ExampleInfo(
        name: 'Plugin Test',
        description: 'Basic plugin functionality testing and verification',
        icon: Icons.bug_report,
        color: Colors.orange,
        route: const PluginTest(),
        isRecommended: false,
      ),
      _ExampleInfo(
        name: 'Code Obfuscation Testing',
        description:
            'Test and verify code obfuscation and anti-reverse engineering features',
        icon: Icons.code,
        color: Colors.purple,
        route: const ObfuscationTestExample(),
        isRecommended: true,
      ),
      _ExampleInfo(
        name: 'VPN Detection Testing',
        description:
            'Test and verify VPN detection functionality with comprehensive security analysis',
        icon: Icons.vpn_key,
        color: Colors.indigo,
        route: const VPNTestScript(),
        isRecommended: true,
      ),
      _ExampleInfo(
        name: 'Simple VPN Detection Example',
        description:
            'Simple example showing how to use VPN detection in your own Flutter app',
        icon: Icons.code,
        color: Colors.teal,
        route: const VPNDetectionExample(),
        isRecommended: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Examples',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        ...examples.map((example) => _buildExampleCard(context, example)),
      ],
    );
  }

  Widget _buildExampleCard(BuildContext context, _ExampleInfo example) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => example.route),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: example.color.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: example.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(example.icon, color: example.color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            example.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (example.isRecommended)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Recommended',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      example.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, color: example.color, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkStatusCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.wifi, color: Colors.blue[600], size: 24),
                const SizedBox(width: 12),
                Text(
                  'Network Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            NetworkConnectivityBuilder(
              builder: (context, hasConnection, isChecking) {
                return Column(
                  children: [
                    Row(
                      children: [
                        NetworkStatusIndicator(
                          hasConnection: hasConnection,
                          isChecking: isChecking,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hasConnection ? 'Connected' : 'No Connection',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: hasConnection
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                isChecking
                                    ? 'Checking connection...'
                                    : 'Internet access available',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final status =
                                  await NetworkErrorHandler.getNetworkStatus();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      status['hasInternetConnection']
                                          ? 'Internet connection is working'
                                          : 'No internet connection detected',
                                    ),
                                    backgroundColor:
                                        status['hasInternetConnection']
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Check Connection'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NetworkTroubleshootingGuide(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.help),
                            label: const Text('Troubleshooting'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600], size: 24),
                const SizedBox(width: 12),
                Text(
                  'About the Examples',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Comprehensive Security Example',
              'Shows all security features working together in a unified interface.',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Platform-Specific Examples',
              'Demonstrates security features tailored for each platform (Android, iOS, Web, macOS, Linux, Windows).',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Plugin Test',
              'Basic functionality testing to verify plugin installation and core features.',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Code Obfuscation Testing',
              'Test and verify code obfuscation and anti-reverse engineering features.',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'VPN Detection Testing',
              'Test and verify VPN detection functionality with comprehensive security analysis.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.4),
        ),
      ],
    );
  }
}

class _ExampleInfo {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final Widget route;
  final bool isRecommended;

  _ExampleInfo({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    required this.isRecommended,
  });
}
